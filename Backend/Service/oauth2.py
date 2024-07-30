import json
from django.http import HttpRequest, JsonResponse
from django.shortcuts import redirect
from Login.models import User
from .models import Service, ServiceAccount
from .serviceShema import ServiceShema, InfoRegister
from .utils import getServiceSchema
import requests
import os
from .views import all_service
from. exchangeCode import exchangeCodeTwitter

#twitter api for authentification
from pytwitter import Api

#URL redirect oauth2 Discord
def acceptoauth2Discord(request: HttpRequest):
    service : ServiceShema = getServiceSchema('Discord', all_service)
    if service == None:
        return JsonResponse({'succes': False, 'message' : 'error not have service Discord'}, safe=False, status=500)
    code = request.GET.get('code')
    if code == None:
        return JsonResponse({'success' : False})
    data = {
        'client_id' : service.oauth2.client_id,
        'client_secret': service.oauth2.client_secret,
        'grant_type': 'authorization_code',
        'code': code,
        'redirect_uri': service.oauth2.redirect_uri,
        'scope': ['identify', 'guilds', 'rpc'],
    }
    headers = {
        'Content-Type': 'application/x-www-form-urlencoded'
    }
    r = requests.post(service.oauth2.endpoint, data=data, headers=headers)
    id_token = r.json()['access_token']
    if id_token == None:
        return JsonResponse({'success': False, 'message': 'cannot find access token'})
    to_redirect = os.getenv('url_redirection')
    if to_redirect != None:
        return redirect(to_redirect + id_token)
    return JsonResponse({'success': True, 'result': r.json(), 'access_token': id_token})


# redirect url oauth2 twitter
def acceptoauth2twitter(request : HttpRequest):
    code = request.GET.get('code')
    state = request.GET.get('state')
    service = getServiceSchema('Twitter', all_service)
    # scope = ['tweet.read', 'tweet.write', 'users.read', 'offline.access']

    if service == None:
        return JsonResponse({'success': False, 'message': 'error message'})

    api = Api(client_id=service.oauth2.client_id, oauth_flow=True
    , client_secret=service.oauth2.client_secret
    , callback_uri=service.oauth2.redirect_uri
    , scopes=service.oauth2.scope)

    url, code_verifier, _ = api.get_oauth2_authorize_url()
    response = api.generate_oauth2_access_token(service.oauth2.redirect_uri + '?state=' + state + '&code=' + code, code_verifier='challenge')
    try:
        id_token = response['access_token']
        to_redirect = os.getenv('url_redirection')
        if to_redirect != None:
            return redirect(to_redirect + id_token)
    except:
        return JsonResponse({'success': False, 'message': response})
    return JsonResponse({'success' : True, 'message': response})

def acceptoauth2twittersave(request : HttpRequest):
    if request.method == 'POST':
        token = request.META.get('HTTP_AUTHORIZATION')
        decode = request.body.decode('utf-8')
        if decode == None:
            return JsonResponse({'success': False, 'message': 'dose not provide body'})
        body : dict = json.loads(decode)
        code = body.get('code')
        state = body.get('state')
        if code == None or state == None:
            return JsonResponse({'success': False, 'message': 'code body not found'})
        if token == None:
            return JsonResponse({'success' : False, 'message': 'token not found'})
        try:
            user = User.objects.get(Token=token)
        except:
            return JsonResponse({'success': False, 'message': 'invalid token'})
        acc_token = exchangeCodeTwitter(code, state)
        if acc_token == None:
            return JsonResponse({'success': False, 'message': 'code or state invalid'})
        try:
            try:
                ServiceAccount.objects.get(token=acc_token)
                return JsonResponse({'success': True, 'message': 'already in db'})
            except:
                try:
                    service = Service.objects.get(name='Twitter')
                    new_account = ServiceAccount(id_service=service.id, id_user=user.id)
                    new_account.token = acc_token
                    new_account.save()
                    return JsonResponse({'success': True, 'message': 'Success connect to databases'})
                except:
                    return JsonResponse({'success': False})
        except:
            return JsonResponse({'success': False})
    return JsonResponse({'success': False})

def postInsertTokenOauth2(request : HttpRequest, service_name):
    if request.method != 'POST':
        return JsonResponse({'success' : True, 'message': 'not POST method'})
    token : str = request.META.get('HTTP_AUTHORIZATION')
    decode = request.body.decode('utf-8')
    body : dict = json.loads(decode)

    service = getServiceSchema(service_name, all_service)
    if service == None or service.oauth2.eligible == False:
        return JsonResponse({'success': False, 'message' : 'service not oauth2 eligible'})
    try:
        user = User.objects.get(Token=token)
    except:
        return JsonResponse({'success' : False, 'message' : 'invalid token'})
    account  = InfoRegister()
    account.token = body.get('token')
    if account.token == None:
        return JsonResponse({'success' : False, 'message': 'body token doesnt send'})
    if service.oauth2.register_function(account) == False:
        return JsonResponse({'success': False, 'message' : 'cannot register to service ' + service_name})
    try:
        db_service = Service.objects.get(name=service_name)
        new_account = ServiceAccount(id_service=db_service.id, id_user=user.id, password=account.password
        , email=account.email, token=account.token, extra=account.extra)
        new_account.save()
    except:
        return JsonResponse({'success' : False, 'message': 'error in db'})
    return JsonResponse({'success' : True, 'message': 'success to connect to service'})

def redirectPortalOauthService(request : HttpRequest, service_name):
    service = getServiceSchema(service_name, all_service)

    if service == None or service.oauth2.eligible == False:
        return JsonResponse({'success': False, 'message': service_name + ' does not send Portal Oauth2'})
    return JsonResponse({'success': True, 'portale': service.oauth2.urlportal})

def serviceOauth2Elgible(request : HttpRequest, service_name):
    service = getServiceSchema(service_name, all_service)

    if service == None:
        return JsonResponse({'success': False, 'message': 'does not provide service ' + service_name})
    return JsonResponse({'success': True, 'oauth2': service.oauth2.eligible
    , 'url': service.oauth2.urlportal
    , 'redirect' : service.oauth2.redirect_uri
    , 'save': service.oauth2.url_save_code})

def setRedirection(request: HttpRequest):
    decode = request.body.decode('utf-8')
    if decode == None or len(decode) == 0:
        return JsonResponse({'success': False, 'message': 'no body set'})
    body : dict = json.loads(decode)
    url_redirection = body.get('url')

    if url_redirection == None:
        return JsonResponse({'success': False, 'message': 'body does not have url body'})
    os.environ['url_redirection'] = url_redirection
    print('url redirection = ', url_redirection)
    return JsonResponse({'success': True, 'message': 'success put ' + url_redirection + ' to the next url_redirection'})
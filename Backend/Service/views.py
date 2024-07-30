import json
from tokenize import Token
from django.http import HttpRequest, JsonResponse
from Login.models import User
from .models import Service, ServiceAccount
from .migrate_service import migrate_service
from .serviceShema import ServiceShema, InfoRegister
from .utils import getServiceSchema

all_service : list  = migrate_service()

def acceptoauth2(request: HttpRequest):
    print(request.GET)
    print(request.POST)
    return JsonResponse({'success': True})

def postService(request : HttpRequest):
    qs = list(Service.objects.values())
    if request.method == 'POST':
        service = Service()
        name = request.POST.get('name')
        description = request.POST.get('description')
        image = request.FILES.get('image')
        if name == None:
            return JsonResponse({'message' : 'error name not specified'}, safe=False, status=500)
        service.name = name
        service.description = description if description else ''
        if image != None:
            service.image = image
        service.save()
        return JsonResponse(qs, safe=False)
    return JsonResponse(qs, safe=False)

def postServiceAccount(request : HttpRequest, service_name : str):
    if request.method == 'POST':
        token : str = request.META.get('HTTP_AUTHORIZATION')
        token = token.replace('Token ', '').replace('token ', '')
        decode = request.body.decode('utf-8')
        body : dict = json.loads(decode)

        account : InfoRegister = InfoRegister()
        account.email = body.get('email')
        account.password = body.get('password')
        account.token = body.get('token')
        account.extra = body.get('extra')
        try:
            user = User.objects.get(Token=token)
        except:
            return JsonResponse({'success' : False, 'message' : 'invalid token'})
        service = getServiceSchema(name=service_name, all_service=all_service)
        if service == None  or service.needRegister == False:
            return JsonResponse({'success' : False, 'message' : 'service: ' + service_name + ' not required connection'})
        if service.register(account) == False:
            return JsonResponse({'success' : False, 'message' : 'cannot connect to service: ' + service_name})
        try:
            db_service = Service.objects.get(name=service_name)
            new_account = ServiceAccount(id_service=db_service.id, id_user=user.id, password=account.password
            , email=account.email, token=account.token, extra=account.extra)
            new_account.save()
        except:
            return JsonResponse({'success' : False, 'message': 'error in db'})
        return JsonResponse({'success' : True, 'message' : 'new account create' }, safe=False)
    return JsonResponse({'success' : False, 'message' : 'nothing specified'}, safe=False)

def postServiceAccount(request : HttpRequest, service_name : str):
    if request.method == 'POST':
        token : str = request.META.get('HTTP_AUTHORIZATION')
        token = token.replace('Token ', '').replace('token ', '')
        decode = request.body.decode('utf-8')
        body : dict = json.loads(decode)

        account : InfoRegister = InfoRegister()
        account.email = body.get('email')
        account.password = body.get('password')
        account.token = body.get('token')
        account.extra = body.get('extra')
        try:
            user = User.objects.get(Token=token)
        except:
            return JsonResponse({'success' : False, 'message' : 'invalid token'})
        service = getServiceSchema(name=service_name, all_service=all_service)
        if service == None  or service.needRegister == False:
            return JsonResponse({'success' : False, 'message' : 'service: ' + service_name + ' not required connection'})
        if service.register(account) == False:
            return JsonResponse({'success' : False, 'message' : 'cannot connect to service: ' + service_name})
        try:
            db_service = Service.objects.get(name=service_name)
            new_account = ServiceAccount(id_service=db_service.id, id_user=user.id, password=account.password
            , email=account.email, token=account.token, extra=account.extra)
            new_account.save()
        except:
            return JsonResponse({'success' : False, 'message': 'error in db'})
        return JsonResponse({'success' : True, 'message' : 'new account create' }, safe=False)
    return JsonResponse({'success' : False, 'message' : 'nothing specified'}, safe=False)

def postServiceAccountOauth2(request : HttpRequest, service_name : str):
    if request.method == 'POST':
        token : str = request.META.get('HTTP_AUTHORIZATION')
        token = token.replace('Token ', '').replace('token ', '')
        decode = request.body.decode('utf-8')
        body : dict = json.loads(decode)

        account : InfoRegister = InfoRegister()
        account.token = body.get('token')
        try:
            user = User.objects.get(Token=token)
        except:
            return JsonResponse({'success' : False, 'message' : 'invalid token'})
        service = getServiceSchema(name=service_name, all_service=all_service)
        if service.oauth2 == False:
            return JsonResponse({'succes': False, 'message' : 'service: ' + service_name + 'dose not provide oauth2'})
        if service == None  or service.needRegister == False:
            return JsonResponse({'success' : False, 'message' : 'service: ' + service_name + ' not required connection'})
        if service.oauth2.register_function(account) == False:
            return JsonResponse({'success' : False, 'message' : 'cannot connect to service: ' + service_name})
        try:
            db_service = Service.objects.get(name=service_name)
            try:
                ServiceAccount.objects.get(id_service=db_service.id, token=account.token)
            except:
                new_account = ServiceAccount(id_service=db_service.id, id_user=user.id, password=account.password
                , email=account.email, token=account.token, extra=account.extra)
                new_account.save()
        except:
            return JsonResponse({'success' : False, 'message': 'error in db'})
        return JsonResponse({'success' : True, 'message' : 'new account create' }, safe=False)
    return JsonResponse({'success' : False, 'message' : 'nothing specified'}, safe=False)

def getService(request : HttpRequest):
    qs = Service.objects.values()
    return JsonResponse(list(qs), safe=False)

def getServiceId(request : HttpRequest, id : int):
    qs = Service.objects.filter(id = id).values()
    return JsonResponse(list(qs), safe=False)

def getServiceName(request : HttpRequest, name : str):
    qs = Service.objects.filter(name = name).values()
    return JsonResponse(list(qs), safe=False)

def getServiceUseInfo(request : HttpRequest, name : str):
    service = getServiceSchema(name, all_service=all_service)
    if service == None:
        return JsonResponse({'message' : name + ' is not a service'}, safe=False, status=400)
    return JsonResponse({**service.useInfo.__dict__, **{'extra': service.useInfo.extra.__dict__ } }, safe=False)

def needRegistration(request : HttpRequest, name : str):
    service = getServiceSchema(name, all_service=all_service)
    if service == None:
        return JsonResponse({'message' : name + ' is not a service'}, safe=False, status=400)
    return JsonResponse({'needRegistration' : service.needRegister}, safe=False)

def userEligibleService(request : HttpRequest, service_name : str):
    token : str = request.META.get('HTTP_AUTHORIZATION')
    token = token.replace('Token ', '').replace('token ', '')

    service_shema = getServiceSchema(service_name, all_service)
    if service_shema != None and service_shema.needRegister == False:
        return JsonResponse({'subscribe' : True})
    try:
        user = User.objects.get(Token=token)
    except:
        return JsonResponse({'message' : 'invalid Token'}, status=400)
    try:
        service = Service.objects.get(name=service_name)
    except:
        return JsonResponse({'message' : 'invalid service name'}, status=400)
    if ServiceAccount.objects.filter(id_user=user.id, id_service=service.id).exists() == True:
        return JsonResponse({'subscribe' : True})
    return JsonResponse({'subscribe' : False})
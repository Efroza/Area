from .views import all_service
from .utils import getServiceSchema
from pytwitter import Api


def exchangeCodeTwitter(code : str, state : str):
    service = getServiceSchema('Twitter', all_service)
    # scope = ['tweet.read', 'tweet.write', 'users.read', 'offline.access']


    if service == None:
        return None
    api = Api(client_id=service.oauth2.client_id, oauth_flow=True
    , client_secret=service.oauth2.client_secret
    , callback_uri=service.oauth2.redirect_uri
    , scopes=service.oauth2.scope)

    try:
        url, code_verifier, _ = api.get_oauth2_authorize_url()
        response = api.generate_oauth2_access_token(service.oauth2.redirect_uri + '?state=' + state + '&code=' + code, code_verifier='challenge')
        try:
            acc_token = response['access_token']
            return acc_token
        except:
            return None
    except:
        return None
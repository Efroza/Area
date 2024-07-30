from Service.serviceShema import ServiceShema
import os

image = 'assets/twitter-logo.png'

name = 'Twitter'

description = 'Twitter Service'

needRegister = True

twitter = ServiceShema(name=name, description=description, image=image, needRegister=needRegister)

def concatscope(scope : list) -> str:
    result = ''
    for i in range(len(scope)):
        result = result + scope[i]
        if i < len(scope) - 1:
            result = result + '%20'
    return result

def getService():
    twitter.useInfo.email == False
    twitter.useInfo.password == False
    twitter.oauth2.eligible = True
    twitter.oauth2.client_id = 'bE5TU2g4bG0yTThDX1d3OXh0dG86MTpjaQ'
    twitter.oauth2.client_secret = 'c6bvYFU3he7TyIh7-OcrNZADkXUUEN-ipT8lr5E8yWaWTO3pWQ'
    twitter.oauth2.redirect_uri = os.getenv('API_URL') + 'service/accept/oauth2/twitter'
    twitter.oauth2.url_save_code = os.getenv('API_URL') + 'service/accept/oauth2/code/twitter'
    twitter.oauth2.scope = ['tweet.read', 'tweet.write', 'users.read', 'offline.access']
    twitter.oauth2.endpoint = 'https://twitter.com/api/oauth2/token'
    twitter.oauth2.urlportal = 'https://twitter.com/i/oauth2/authorize?response_type=code'
    twitter.oauth2.urlportal = twitter.oauth2.urlportal + '&client_id=' + twitter.oauth2.client_id
    twitter.oauth2.urlportal = twitter.oauth2.urlportal + '&redirect_uri=' + twitter.oauth2.redirect_uri
    # twitter.oauth2.urlportal = twitter.oauth2.urlportal + '&scope=' + concatscope(twitter.oauth2.scope)
    twitter.oauth2.urlportal = twitter.oauth2.urlportal + '&scope=tweet.read%20tweet.write%20users.read%20offline.access'
    twitter.oauth2.urlportal = twitter.oauth2.urlportal + '&state=state&code_challenge=challenge&code_challenge_method=plain'
    return twitter
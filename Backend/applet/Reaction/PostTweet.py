from django.http import QueryDict
from applet.Applet import Reaction_Components
from Service.utils import getServiceAccountToken
import requests

name = 'Post a tweet'

description = "Poste un tweet"

mandatory = ['content']

service = 'Twitter'

url = "https://api.twitter.com/2/tweets"


def main(id_user : int, data : QueryDict) :
    content = data.get('content')
    payload = "{\n    \"text\": \""+content+"\"\n}"
    token = getServiceAccountToken(service, id_user)
    print("bonjou "+token)
    print(payload)
    headers = {"Authorization": "Bearer " +token, "Content-type": "application/json"}
    try :
        response = requests.request("POST", url, headers=headers, data=payload)
        print(response.text)
    except :
        return

PostTweet= Reaction_Components(func=main, name=name, description=description, mandatory=mandatory, service_name=service)

def getReaction():
    return PostTweet
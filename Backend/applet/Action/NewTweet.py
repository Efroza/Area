from django.http import QueryDict
from applet.Applet import Action_Components
from Service.utils import getServiceAccountToken

import tweepy

name = 'New Tweet'

description = "Active l'applet lorsqu'il ya un nouveau tweet"

service = 'Twitter'

mandatory = ['subject']

needRegister = True

def main(id_user : int, query : QueryDict):
    token = getServiceAccountToken(service, id_user)
    subject = query.get('subject')
    client = tweepy.Client(bearer_token=token)
    query = subject + ' -is:retweet'
    response = client.search_recent_tweets(query=query, max_results=20)
    if response.data == None:
        return False
    return True

newtweet = Action_Components(func=main, name=name, description=description, mandatory=mandatory, service_name=service)

def getAction():
    return newtweet


##
# @file yosra.py
# @brief Ce fichier permet de créer une reaction 'yosra'.
# @section la fonction main :
# - @param id_user : l'id de l'utilisateur qui a posté le message
# - @param data : les données du message
# - @description : permet de récupérer le message et de l'afficher dans la console
from django.http import QueryDict
from applet.Applet import Reaction_Components
from Service.utils import getServiceAccountToken

name = 'Yosra'

description = 'Yosra description'

mandatory = ['message', 'name']

def main(id_user : int, data : QueryDict):
    token = getServiceAccountToken('Twitter', id_user)
    message = data.get('message')
    print('HELLO WORLD FROM REACTION YOSRA the message is:', message)

yosra = Reaction_Components(func=main, name=name, description=description, mandatory=mandatory)

def getReaction():
    return yosra
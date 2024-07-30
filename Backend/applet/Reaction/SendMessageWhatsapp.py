##
# @file SendMessageWhatsapp.py
# @brief Ce fichier permet de créer la réaction "SendMessageWhatsapp".
# @section SendMessageWhatsapp :
# - @param id_user : id de l'utilisateur
# - @param query : les données du message
# - @description : permet de récupérer le numero et le message à envoyer. Ensuite, on envoie le message au numéro donné.
from django.http import QueryDict
from applet.Applet import Reaction_Components

import pywhatkit

name = 'Send Whatsapp Message'

description = 'Envoie un message Whatsapp au numero specifier'

service = 'Whatsapp'

mandatory = ['numero +33', 'message']

def main(id_user : int, data : QueryDict):
    numero = data.get('numero +33')
    message = data.get('message')
    pywhatkit.sendwhatmsg_instantly(numero, message)

sendmessage = Reaction_Components(func=main, name=name, description=description, mandatory=mandatory, service_name=service)

def getReaction():
    return sendmessage
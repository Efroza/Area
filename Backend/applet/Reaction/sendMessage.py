##
# @file sendMessage.py
# @brief Ce fichier permet de créer une reaction "SendMessage" via l'api Twilio.
# @section la class twillio_sendMessage :
# - @param id_user : id de l'utilisateur
# - @param data : les données du message
# - @description : permet de récupérer le twillio_number, le receiver_number et le message et de les envoyer.
from django.http import QueryDict
from applet.Applet import Reaction_Components
from Service.utils import getServiceAccountToken, getServiceAccountExtra
from twilio.rest import Client


name = 'Twillio message'

description = 'Envoie un message avec twillio sur le numero de telephone specifier'

service = 'Twillio'

mandatory = ['twillio_number', 'receiver_number', 'message']

def main(id_user : int, data : QueryDict):
    sid = getServiceAccountExtra(service_name=service, id_user=id_user)
    auth_token = getServiceAccountToken(service_name=service, id_user=id_user)

    twillio_number = data['twillio_number']
    receiver_number = data['receiver_number']
    message = data['message']
    client = Client(sid, auth_token)
    try:
        client.messages.create(
            body=message,
            from_=twillio_number,
            to=receiver_number
        )
    except:
        return

twillio_sendMessage = Reaction_Components(func=main, name=name, description=description, mandatory=mandatory, service_name=service)

def getReaction():
    return twillio_sendMessage

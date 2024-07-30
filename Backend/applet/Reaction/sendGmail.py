##
# @file sendGmail.py
# @brief Ce fichier permet de créer la réaction sendGmail via l'api Gmail.
# @section getEmailMessage :
# - @param From : l'adresse email de l'utilisateur
# - @param To : l'adresse email du destinataire
# - @param Subject : le sujet du message
# - @param Body : le corps du message
# - @description : permet de créer un EmailMessage avec les paramètres donnés.

from django.http import QueryDict
from applet.Applet import Reaction_Components
from Service.utils import getServiceAccountEmail, getServiceAccountPassword
from email.message import EmailMessage
import smtplib, ssl

mandatory = ['to', 'subject', 'body']
name = 'Send Gmail'
description = 'envoie un message de votre compte gmail au mail que vous specifier'
service = 'Google'

def getEmailMessage(From, To, Subject, Body) -> EmailMessage:
    em = EmailMessage()
    em['From'] = From
    em['To'] = To
    em['Subject'] = Subject
    em.set_content(Body)
    return em

def main(id_user : int, data : QueryDict):
    to = data.get('to')
    subject = data.get('subject')
    body = data.get('body')
    user_email = getServiceAccountEmail(service, id_user)
    user_password = getServiceAccountPassword(service, id_user)

    em = getEmailMessage(From=user_email, To=to, Subject=subject, Body=body)
    try:
        context = ssl.create_default_context()
        server = smtplib.SMTP_SSL('smtp.gmail.com', 465, context=context)
        server.login(user_email, user_password)
        server.sendmail(user_email, to, em.as_string())
        server.close()
    except:
        print('error in sending data')

gmail = Reaction_Components(func=main, name=name, description=description, mandatory=mandatory, service_name=service)

def getReaction():
    return gmail

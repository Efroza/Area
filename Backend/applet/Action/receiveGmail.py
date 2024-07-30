##
# @file receiveGmail.py
# @brief Ce fichier permet de créer l'action 'receiveGmail'.
# @section receiveGmail :
# - @param id_user : id de l'utilisateur
# - @param query : les données du message
# - @description : permet de récupérer le mail de l'utilisateur et de vérifier s'il a reçu un mail dans la journée.
from django.http import QueryDict
from applet.Applet import Action_Components
from Service.utils import getServiceAccountEmail, getServiceAccountPassword
import imaplib
from email import message_from_bytes
from datetime import datetime
from dateutil import tz

ERROR = False

mandatory = ['email']
name = 'Receive Gmail'
description = 'Active Applet when receive a mail in your gmail account'
service = 'Google'

INDEX_TIME = 4

INDEX_CONVERSION = 5

conversion = 'UTC+01:00'

def connectGmail(mail : imaplib.IMAP4_SSL, user : str, password : str) -> bool:
    try:
        mail.login(user, password)
        mail.list()
        mail.select("inbox") # connect to inbox.
        return True
    except:
        print('error reveice gmail')
        return False

def getGmailByDate(mail : imaplib.IMAP4_SSL):
    now = datetime.now()
    return mail.search(None, "(SINCE " + now.strftime("%d-%b-%Y") + ')')

def getLastGmailId(data : list):
    ids = data[0] # data is a list.
    id_list = ids.split() # ids is a space separated string
    if len(id_list) <= 0:
        return None
    return id_list[-1] # get the latest

def updateConvertisseur(date_mail : str):
    global conversion
    if date_mail == None or len(date_mail.split(' ')) < INDEX_CONVERSION:
        return
    value = date_mail.split(' ')[INDEX_CONVERSION]
    if len(value) < 4:
        return
    signe = value[0]
    left = value[1] + value[2]
    right = value[3] + value[4]
    conversion = 'UTC' + signe + left + ':' + right

def extractTime(last_email_id, mail : imaplib.IMAP4_SSL):
    result, data = mail.fetch(last_email_id, "(RFC822)") # fetch the email body (RFC822) for the given ID

    raw = message_from_bytes(data[0][1]) #extract byte field from data
    date_mail = raw['Date']
    if date_mail == None:
        return None
    updateConvertisseur(date_mail=date_mail)
    try:
        dt = datetime.strptime(date_mail, "%a, %d %b %Y %H:%M:%S %z")
    except:
        return None
    return dt.strftime('%H:%M:%S')

def getConvertTime():
    date_now = datetime.now()
    from_zone =  tz.tzlocal()
    to_zone = tz.gettz(conversion)
    date_now = date_now.replace(tzinfo=from_zone)
    central = date_now.astimezone(to_zone)
    return central.strftime("%H:%M:%S")

def getSecondsDifference(time_now, time_mail):
    actual = datetime.strptime(time_now, "%H:%M:%S")
    mail_time = datetime.strptime(time_mail, "%H:%M:%S")
    return (actual - mail_time).seconds

def main(id_user : int, query : QueryDict) -> bool:
    mail = imaplib.IMAP4_SSL('imap.gmail.com')
    user = getServiceAccountEmail(service_name=service, id_user=id_user)
    password = getServiceAccountPassword(service_name=service, id_user=id_user)
    if user == None or password == None or connectGmail(mail, user, password) == False:
        return ERROR
    result, data = getGmailByDate(mail)
    last_email_id = getLastGmailId(data)
    if last_email_id == None:
        return False
    time_mail = extractTime(last_email_id, mail)
    if time_mail == None:
        return ERROR
    mail.close()
    mail.logout()
    time_now = getConvertTime()
    difference = getSecondsDifference(time_now, time_mail)
    print(difference)
    return difference < 19

receiveGmail = Action_Components(func=main, name=name, description=description, mandatory=mandatory, service_name=service)

def getAction():
    return receiveGmail

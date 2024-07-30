##
# @file Schedule.py
# @brief Ce fichier permet de setUp l'action Schedule.
# @section Schedule_activation :
# - @param id_user : id de l'utilisateur
# - @param query : les données du message
# - @description : permet de récupérer le temps et de le mettre en sleep. Puis de réaliser une réaction.
import string
from django.http import QueryDict
from applet.Applet import Action_Components
from time import sleep

mandatory : list = ['time']

def Schedule_activation(id_user : int, query : QueryDict) -> bool :
    times = query.get('time')
    if times != None:
        try:
            time = int(times)
            sleep(time)
        except:
            print('error int')
    print('action:', query)
    return True

Schedule_Name : string = "Schedule_Action"

Schedule_Description : string = 'Begin Action at a specifiq time'

Schedule_Action : Action_Components = Action_Components(Schedule_activation
, Schedule_Name
, Schedule_Description
, mandatory=mandatory
, service_name='Time'
)

def getAction() -> Action_Components:
    return Schedule_Action

import string
from applet.Applet import Action_Components

def Schedule_reaction(id : object, url : string) -> bool :
    print(url, id)
    return False

Schedule_Name : string = "Schedule_reaction"

Schedule_Description : string = 'Begin Action at a specifiq time'

Schedule_reaction : Action_Components = Action_Components(Schedule_reaction, Schedule_Name, Schedule_Description)

def getAction() -> Action_Components:
    # print('get action')
    return Schedule_reaction
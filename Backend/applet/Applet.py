##
# @file Applet.py
# @brief Ce fichier permet de définir les différentes classes de l'applet.
# @section la class Applet_Components :
# @description Cette classe permet de définir les différents attributs de l'applet.
# - @param add_function : permet d'ajouter une fonction à l'applet.
# - @param add_action : permet d'ajouter une action à l'applet.
# - @param add_reaction : permet d'ajouter une réaction à l'applet.
from django.http import QueryDict
import string
import threading
from time import sleep


class Applet_Components:
    def __init__(self, func  = None
    , name : string  = ""
    , description : string = ""
    , mandatory : list= []
    , service_name : str = ''):
        self.func = func
        self.name = name
        self.description = description
        self.db_id = 0
        self.query = ''
        self.db_id_user = 0
        self.mandatory = mandatory
        self.service = service_name

    def __str__(self) -> str:
        return '{ db_id: ' + str(self.db_id)\
            + ', name: ' + self.name\
            + ', description: ' + self.description\
            + ', mandatory: ' + str(self.mandatory) + '}'

    def add_function(self, func) -> None:
        self.func = func
    def add_name(self, name) -> None:
        self.name = name
    def set_query(self, query : str) -> None:
        self.query = query
    def setService(self, service_name : str) -> None:
        self.service = service_name
    def getService(self) -> None:
        return self.service
    def get_name(self) -> string:
        return self.name
    def get_description(self) -> string:
        return self.description
    def set_db_id(self, id : int) -> None:
        self.db_id = id
    def set_db_id_user(self, id : int) -> None:
        self.db_id_user = id
    def get_db_id(self) -> int :
        return self.db_id

class Action_Components(Applet_Components):
    def Activate(self) -> bool:
        return self.func(self.db_id_user, QueryDict(self.query))

class Reaction_Components(Applet_Components):
    def run(self) -> None:
        self.func(self.db_id_user, QueryDict(self.query))

def wait_action(action : Action_Components, reactions : list):
    while True:
        if action.Activate() == True:
            break
        sleep(15)
    for reaction in reactions:
        try:
            reaction.run()
        except:
            print("reactions list has unexepted error dosen't have run attribute in element", reaction)

class Applet_Trigger:
    def __init__(self, action : Action_Components, reaction : list = []) -> None:
        self.action : Action_Components = action
        self.reaction : list[Reaction_Components] = reaction

    def add_action(self, action : Applet_Components):
        self.action = action

    def add_reaction(self, reaction : Reaction_Components):
        self.reaction.append(reaction)

    def run(self):
        applet_thread = threading.Thread(target=wait_action, args=(self.action, self.reaction))
        applet_thread.start()
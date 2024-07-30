##
# @file migration_applet.py
# @brief Migration des différents applet
# @section function id_service_component :
#   @brief Fonction qui permet de récupérer l'id du service
#   @param service_name : nom du service
#   @param component_service : id du service
#   @param name_component : nom du composant
#   @return id du service
import importlib.util
import string
from types import ModuleType
from .Applet import Action_Components, Reaction_Components
from .models import Action, Reaction, Action_Mandatory, Reaction_Mandatory
from Service.models import Service
from .settings_path import ActualDirectory, ActionDirectory, ActionModules, ReactionDirectory, ReactionModules


def colored(r, g, b, text):
    return "\033[38;2;{};{};{}m{} \033[38;2;255;255;255m".format(r, g, b, text)

def id_service_component(service_name : str, component_service : int, name_component) -> int:
    if len(service_name) == 0:
        return 0
    try:
        service = Service.objects.get(name=service_name)
        if component_service == service.id:
            return component_service
        print(colored(0, 255, 0, 'components: ' + name_component + ' updated service: ' + service.name))
        return service.id
    except:
        print(colored(255, 0, 0, 'error in service dose not have ' + service_name ))
        return 0

def import_module(name : string, directory : string) -> ModuleType:
    try:
        return importlib.util.spec_from_file_location(
            name, ActualDirectory + '/' + directory + '/' + name + '.py'
            ).loader.load_module()
    except:
        print(colored(255, 0, 0, 'error file module [ '+ name + " ] does not exist"))
        return None

def migrate_mandatory_action(action_mandatory : list, id_action : int) -> None:
    for mandatory in action_mandatory:
        if not Action_Mandatory.objects.filter(id_action = id_action, name = mandatory).exists():
            try:
                new_action_mandatory = Action_Mandatory(id_action = id_action, name = mandatory)
                new_action_mandatory.save()
                print(colored(0, 255, 0, 'action migration mandatory ' + mandatory))
            except:
                print(colored(255, 0, 0, 'error in action migtation ' + mandatory))

def export_db_action(action : Action_Components) -> int:
    try:
        action_db = Action.objects.get(name=action.get_name())
        migrate_mandatory_action(action.mandatory, id_action=action_db.id)
        id_service = id_service_component(action.service, action_db.id_service, action_db.name)
        Action.objects.filter(id = action_db.id).update(id_service = id_service)
        return action_db.id
    except:
        print(action.get_name(), 'not in db Action')
        try:
            new_action = Action(name=action.get_name(), description=action.get_description())
            new_action.id_service = id_service_component(action.service, 0, action.name)
            new_action.save()
            print(colored(0, 255, 0, 'migration: ' + action.get_name() + ' in applet_action'))
            migrate_mandatory_action(action.mandatory, new_action.id)
            return new_action.id
        except:
            print(colored(255, 0, 0, 'error in migration: ' + action.get_name()))
    return 0

def migration_action() -> list:
    result : list[Action_Components] = []
    for ActionFile in ActionModules:
        FileModule = import_module(ActionFile, ActionDirectory)
        try:
            action : Action_Components = FileModule.getAction()
        except:
            print(ActionDirectory + '.' + ActionFile, 'dose nott provide exepted method "getAction() -> Applet.Action"')
            continue
        if type(action) != Action_Components or action.get_name() == None:
            print(ActionDirectory + '.' + ActionFile, 'error action not Applet.Action')
            continue
        id = export_db_action(action)
        if id == 0:
            continue
        action.set_db_id(id)
        result.append(action)
    return result

def migrate_mandatory_reaction(reaction_mandatory : list, id_reaction : int) -> None:
    for mandatory in reaction_mandatory:
        if not Reaction_Mandatory.objects.filter(id_reaction = id_reaction, name = mandatory).exists():
            try:
                new_reaction_mandatory = Reaction_Mandatory(id_reaction = id_reaction, name = mandatory)
                new_reaction_mandatory.save()
                print(colored(0, 255, 0, 'reaction migration mandatory ' + mandatory))
            except:
                print(colored(255, 0, 0, 'error in reaction migtation ' + mandatory))


def export_db_reaction(reaction : Reaction_Components) -> int :
    try:
        reaction_db = Reaction.objects.get(name=reaction.get_name())
        migrate_mandatory_reaction(reaction.mandatory, reaction_db.id)
        id_service = id_service_component(reaction.service, reaction_db.id_service, reaction.name)
        Reaction.objects.filter(id=reaction_db.id).update(id_service=id_service)
        return reaction_db.id
    except:
        print(reaction.get_name(), 'not in db Action')
        try:
            new_reaction = Reaction(name=reaction.get_name(), description=reaction.get_description())
            new_reaction.id_service = id_service_component(reaction.service, 0, reaction.get_name())
            new_reaction.save()
            print(colored(0, 255, 0, 'migration: ' + reaction.get_name() + ' in applet_reaction'))
            migrate_mandatory_reaction(reaction.mandatory, new_reaction.id)
            return new_reaction.id
        except:
            print(colored(255, 0, 0, 'error in migration: ' + reaction.get_name()))
    return 0

def migration_reaction() -> list:
    result : list[Reaction_Components] = []
    for ReactionFile in ReactionModules:
        FileModule = import_module(ReactionFile, ReactionDirectory)
        try:
            reaction : Reaction_Components = FileModule.getReaction()
        except:
            print(colored(255, 0, 0, ReactionDirectory + '.' + ReactionFile + ' dose not provide exepted method "getReaction() -> Applet.Reaction"'))
            continue
        if reaction == None or type(reaction) != Reaction_Components or reaction.get_name() == None:
            print(colored(255, 0, 0, ReactionDirectory + '.' + ReactionFile + ' error reaction not Applet.reaction'))
            continue
        id = export_db_reaction(reaction)
        if id == 0:
            continue
        reaction.set_db_id(id)
        result.append(reaction)
    return result
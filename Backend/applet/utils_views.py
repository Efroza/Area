##
# @file utils_views.py
# @brief Ce fichier permet de créer les différentes fonctions utiles pour les views.
# @section la fonction format_components_json :
# - @param action : un objet de type Action
# - @return un dictionnaire contenant les informations de l'action
# @section la fonction format_list_components_json :
# - @param reaction : une liste d'objet de type Reaction
# - @return une liste de dictionnaire contenant les informations des reactions
# @section la fonction check_mandatory_list :
# - @param body : un dictionnaire contenant les informations de l'action ou de la reaction
# - @param id : l'id de l'action ou de la reaction
# - @param reaction : un booléen qui permet de savoir si c'est une action ou une reaction
# - @return une erreur si un champ obligatoire n'est pas renseigné
# @section la fonction add_tables :
# - @param Action_body : un dictionnaire contenant les informations de l'action
# - @param Reaction_body : une liste de dictionnaire contenant les informations des reactions
# - @param id_user : l'id de l'utilisateur
# - @return une erreur si un champ obligatoire n'est pas renseigné ou si l'action ou la reaction n'existe pas
from enum import Enum
from urllib.parse import urlencode
from .models import Action, Action_Mandatory, Reaction, Applet, Action_Running, Reaction_Mandatory, Reaction_Running
from django.http import JsonResponse

def format_components_json(action) -> dict:
    try:
        return {
            "id" : action.id,
            "name": action.name,
            "description" : action.description
        }
    except:
        print('error: ', action)
    return None

def format_list_components_json(reaction) -> list:
    result = []
    if reaction == None:
        return []
    for comp in reaction:
        result.append(format_components_json(comp))
    return result

def check_mandatory_list(body : dict, id : int, reaction : bool = False):
    key_body : list = []
    print('key body', body)
    for key in body:
        if key == 'id':
            continue
        key_body.append(key)
    if reaction == True:
        not_set_mandatory = Reaction_Mandatory.objects.filter(id_reaction=id).exclude(name__in=key_body)
    else:
        not_set_mandatory = Action_Mandatory.objects.filter(id_action=id).exclude(name__in=key_body)
    if len(key_body) != 0 \
        and not_set_mandatory.exists():
        raise ValueError('mandatory '+ str(list(not_set_mandatory.values())) + " not set")

def add_tables(Action_body : dict, Reaction_body : list, id_user : int):
    action = None
    reaction : list = []
    print('reactionBody', Reaction_body)
    try:
        id_action = Action_body.get('id')
        action = Action.objects.get(id=id_action)
        check_mandatory_list(body=Action_body, id=id_action, reaction=False)
    except ValueError as error:
        return JsonResponse({"message" : "mandatory id action: " + str(id_action)}, status=500)
    except:
        return JsonResponse({"message" : "db.Action.id = " + str(Action_body) + " is not in databses"})
    try:
        for id_reaction_body in Reaction_body:
            id_reaction = id_reaction_body.get('id')
            if id_reaction_body == None:
                raise Exception("Error")
            check_mandatory_list(body=id_reaction_body, id=id_reaction, reaction=True)
            reaction.append( Reaction.objects.get( id = id_reaction ) )
    except ValueError as error:
        return JsonResponse({"message" : error.args}, status=500)
    except:
        return JsonResponse({"message" : "db.Reaction.id = " + str(Reaction_body) + " is not in databses"})
    try:
        new_applet = Applet(id_user=id_user)
        new_applet.save()
        new_action_running = Action_Running(id_action=action.id, id_applet=new_applet.id)
        new_action_running.query_string = urlencode(Action_body)
        new_action_running.save()
        index = 1
        for dict_reaction in reaction:
            new_reaction_running = Reaction_Running(id_reaction=dict_reaction.id, id_applet=new_applet.id, order=index)
            for body in Reaction_body:
                if body.get('id') ==  dict_reaction.id:
                    new_reaction_running.query_string = urlencode(body)
            new_reaction_running.save()
            index = index + 1
    except:
        return JsonResponse({"message" : "internale error conflict"}, status=500)
    return JsonResponse(
        {
            "applet_id" : new_applet.id,
            "action" : format_components_json(action),
            "reaction" : format_list_components_json(reaction)
        }, safe=False)
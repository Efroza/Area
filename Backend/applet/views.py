##
# @file views.py
# @brief Ce fichier contient les fonctions qui permettent de gérer les applets
# @section getId_User
#  @param applet_id : id de l'applet
#  @description Cette fonction permet de récupérer l'id de l'utilisateur qui a créé l'applet
#  @return id_user : id de l'utilisateur
# @section getAction_Components
#  @param applet_id : id de l'applet
#  @param id_user : id de l'utilisateur
#  @description Cette fonction permet de récupérer l'action de l'applet
#  @return action_module : action de l'applet
# @section getListReaction_Components
#  @param applet_id : id de l'applet
#  @param id_user : id de l'utilisateur
#  @description Cette fonction permet de récupérer la liste des réactions de l'applet
#  @return list_reaction : liste des réactions de l'applet
# @section check_reaction_list
#  @param reaction : liste des réactions
#  @description Cette fonction permet de vérifier que la liste des réactions est correcte
#  @return True si la liste est correcte, False sinon
# @section IsSubscribe
#  @param id_service : id du service
#  @param id_user : id de l'utilisateur
#  @description Cette fonction permet de vérifier si l'utilisateur est abonné au service
#  @return True si l'utilisateur est abonné au service, False sinon
# @section getAction
#  @param request : requête HTTP
#  @description Cette fonction permet de récupérer la liste des actions
#  @return liste des actions
# @section getActionName
#  @param request : requête HTTP
#  @param name : nom de l'action
#  @description Cette fonction permet de récupérer l'action dont le nom est passé en paramètre
#  @return action dont le nom est passé en paramètre
# @section getReaction
#  @param request : requête HTTP
#  @description Cette fonction permet de récupérer la liste des réactions
#  @return liste des réactions
# @section getReactionName
#  @param request : requête HTTP
#  @param name : nom de la réaction
#  @description Cette fonction permet de récupérer la réaction dont le nom est passé en paramètre
#  @return réaction dont le nom est passé en paramètre
# @section getActionMandatoryId
#  @param request : requête HTTP
#  @param id : id de l'action
#  @description Cette fonction permet de récupérer les paramètres obligatoires de l'action dont l'id est passé en paramètre
#  @return paramètres obligatoires de l'action dont l'id est passé en paramètre
# @section getActionMandatory
#  @param request : requête HTTP
#  @param name : nom de l'action
#  @description Cette fonction permet de récupérer les paramètres obligatoires de l'action dont le nom est passé en paramètre
#  @return paramètres obligatoires de l'action dont le nom est passé en paramètre
# @section getActionOptionalId
#  @param request : requête HTTP
#  @param id : id de l'action
#  @description Cette fonction permet de récupérer les paramètres optionnels de l'action dont l'id est passé en paramètre
#  @return paramètres optionnels de l'action dont l'id est passé en paramètre
# @section getActionOptional
#  @param request : requête HTTP
#  @param name : nom de l'action
#  @description Cette fonction permet de récupérer les paramètres optionnels de l'action dont le nom est passé en paramètre
#  @return paramètres optionnels de l'action dont le nom est passé en paramètre
# @section getReactionMandatoryId
#  @param request : requête HTTP
#  @param id : id de la réaction
#  @description Cette fonction permet de récupérer les paramètres obligatoires de la réaction dont l'id est passé en paramètre
#  @return paramètres obligatoires de la réaction dont l'id est passé en paramètre
# @section getReactionMandatory
#  @param request : requête HTTP
#  @param name : nom de la réaction
#  @description Cette fonction permet de récupérer les paramètres obligatoires de la réaction dont le nom est passé en paramètre
#  @return paramètres obligatoires de la réaction dont le nom est passé en paramètre
# @section postApplet
#  @param request : requête HTTP
#  @description Cette fonction permet de créer une applet
#  @return True si l'applet a été créée, False sinon
# @section activateApplet
#  @param request : requête HTTP
#  @description Cette fonction permet d'activer une applet
#  @return True si l'applet a été activée, False sinon


import json
from django.http import HttpRequest, JsonResponse
from django.views.decorators.csrf import csrf_exempt
from Service.models import Service
from applet.Applet import Action_Components, Reaction_Components, Applet_Trigger
from .models import Action, Reaction, Applet, Action_Running, Reaction_Running, Action_Mandatory, Reaction_Mandatory
from .utils_views import add_tables
from Login.models import User
from Service.models import ServiceAccount, Service
from .migration_applet import migration_action, migration_reaction

Action_exec : list = migration_action()

Reaction_exec : list = migration_reaction()

def getId_User(applet_id : int) -> int:
    try:
        applet = Applet.objects.get(id = applet_id)
        return applet.id_user
    except:
        return -1

def getAction_Components(applet_id, id_user : int):
    if Action_exec == None or len(Action_exec) == 0:
        return None
    try:
        action_running_applet = Action_Running.objects.get(id_applet=applet_id)
    except:
        print(applet_id, "not in action_running db")
        return None
    for action_module in Action_exec:
        try:
            if action_module.get_db_id() == action_running_applet.id_action:
                action_module.set_query(action_running_applet.query_string)
                action_module.set_db_id_user(id_user)
                return action_module
        except:
            print('action_module has no member named get_db_id')
    return None

def getListReaction_Components(applet_id, id_user : int):
    list_reaction : list = []
    if Reaction_exec == None or len(Reaction_exec) == 0:
        return []
    try:
        reaction_running_applet = Reaction_Running.objects.filter(id_applet=applet_id)
    except:
        print(applet_id, "not in db applet_reaction_running scope")
        return []
    for running in reaction_running_applet:
        for reaction_module in Reaction_exec:
            try:
                if reaction_module.get_db_id() == running.id_reaction:
                    reaction_module.set_query(running.query_string)
                    reaction_module.set_db_id_user(id_user)
                    list_reaction.append(reaction_module)
            except:
                print('action_module has no member named get_db_id')
                return []
    if len(list_reaction) == 0:
        return []
    return list_reaction

def check_reaction_list(reaction : list) -> bool:
    for reaction_dict in reaction:
        if type(reaction_dict) != dict or reaction_dict.get('id') == None:
            return False
    return True

def IsSubscribe(id_service : int, id_user : int) -> bool:
    if Service.objects.get(id=id_service).inscription == False:
        return True
    return ServiceAccount.objects.filter(id_service=id_service, id_user=id_user).exists()

# Create your views here.
def getAction(request : HttpRequest):
    token : str = request.META.get('HTTP_AUTHORIZATION')

    if token == None:
        return JsonResponse({'message': 'no token'}, safe=False, status=500)
    token = token.replace('Token ', '').replace('token ', '')
    try:
        id_user = User.objects.get(Token=token).id
    except:
        return JsonResponse({'message': 'invalid token'}, safe=False, status=500)
    action_service = list(Action.objects.exclude(id_service=0).values())
    try:
        action_service = filter(lambda action : IsSubscribe(id_service=action['id_service'], id_user=id_user), action_service)
    except:
        return JsonResponse({'message': 'not ids_ervice in field Reaction'}, safe=False, status=500)
    qs = list(action_service) + list(Action.objects.filter(id_service=0).values())
    return JsonResponse(qs, safe=False)

def getActionName(request : HttpRequest, name : str):
    qs = list(Action.objects.filter(name=name).values())
    return JsonResponse(qs, safe=False)

def getReaction(request : HttpRequest):
    token : str = request.META.get('HTTP_AUTHORIZATION')

    if token == None:
        return JsonResponse({'message': 'no token'}, safe=False, status=500)
    token = token.replace('Token ', '').replace('token ', '')
    try:
        id_user = User.objects.get(Token=token).id
    except:
        return JsonResponse({'message': 'invalid token'}, safe=False, status=500)
    reaction_service = list(Reaction.objects.exclude(id_service=0).values())
    try:
        reaction_service = filter(lambda reaction : IsSubscribe(id_service=reaction['id_service'], id_user=id_user), reaction_service)
    except:
        return JsonResponse({'message': 'not ids_ervice in field Reaction'}, safe=False, status=500)
    qs = list(reaction_service) + list(Reaction.objects.filter(id_service=0).values())
    return JsonResponse(list(qs), safe=False)

def getActionMandatoryId(request : HttpRequest, id : int):
    qs = Action_Mandatory.objects.filter(id_action = id)
    return JsonResponse(list(qs.values()), safe=False)


def getActionMandatory(request : HttpRequest):
    qs = list(Action_Mandatory.objects.values())
    return JsonResponse(qs, safe=False)

def getReactionMandatoryId(request : HttpRequest, id : int):
    qs = Reaction_Mandatory.objects.filter(id_reaction = id)
    return JsonResponse(list(qs.values()), safe=False)


def getReactionMandatory(request : HttpRequest):
    qs = list(Reaction_Mandatory.objects.values())
    return JsonResponse(qs, safe=False)

def getActionServiceId(request : HttpRequest, id : int):
    qs = Action.objects.filter(id_service=id)
    return JsonResponse(list(qs.values()), safe=False)

def getReactionServiceId(request : HttpRequest, id : int):
    qs = Reaction.objects.filter(id_service=id)
    return JsonResponse(list(qs.values()), safe=False)

def getActionServiceName(request : HttpRequest, name : str):
    try:
        service = Service.objects.get(name=name)
    except:
        return JsonResponse([], safe=False)
    qs = Action.objects.filter(id_service=service.id)
    return JsonResponse(list(qs.values()), safe=False)

def getReactionServiceName(request : HttpRequest, name : str):
    try:
        service = Service.objects.get(name=name)
    except:
        return JsonResponse([], safe=False)
    qs = Reaction.objects.filter(id_service=service.id)
    return JsonResponse(list(qs.values()), safe=False)

@csrf_exempt
def postApplet(request : HttpRequest):
    token : str = request.META.get('HTTP_AUTHORIZATION')

    if token == None:
        return JsonResponse({'message': 'no token'}, safe=False, status=500)
    token = token.replace('Token ', '').replace('token ', '')
    try:
        id_user = User.objects.get(Token=token).id
    except:
        return JsonResponse({'message': 'invalid token'}, safe=False, status=500)

    if request.method == 'POST':
        decode = request.body.decode('utf-8')
        body : dict = json.loads(decode)
        Action_body : dict = body.get('action')
        Reaction_body : list[dict] = body.get('reaction')
        if Action_body == None or type(Action_body) != dict \
            or type(Reaction_body) != list or check_reaction_list(Reaction_body) == False:
            return JsonResponse({'message' : "invalid body format {action({id, ...}), reaction(list[{id, ...}, ...]), user(dict)}"}\
                , status=500)
        if Action_body.get('id') == None or type(Action_body.get('id')) != int:
            return JsonResponse({'message' : "invalid members .id (type int) in Action dosen't exist"}, status=500)
        return add_tables(Action_body, Reaction_body, id_user)
    return JsonResponse(list(Applet.objects.values()), safe=False)

@csrf_exempt
def activateApplet(request : HttpRequest):
    if request.method == 'POST':
        decode = request.body.decode('utf-8')
        body : dict = json.loads(decode)
        applet_id : int = body.get('applet_id')
        if applet_id == None or type(applet_id) != int:
            print(applet_id)
            return JsonResponse({'message' : "invalid body {applet_id(int)}"}, status=500)
        id_user = getId_User(applet_id=applet_id)
        if id_user == -1:
            return JsonResponse({'message' : 'id_applet: ' + str(applet_id) + ' not in database ' }, status=400)
        action_component : Action_Components = getAction_Components(applet_id, id_user)
        if action_component == None:
            return JsonResponse({'message' : 'id_applet: ' + str(applet_id) + ' not in database ' }, status=400)
        reaction_components : list[Reaction_Components] = getListReaction_Components(applet_id, id_user)
        applet : Applet_Trigger = Applet_Trigger(action_component, reaction_components)
        applet.run()
    return JsonResponse({'applet_id' : applet_id, 'action' : str(action_component), 'reaction' : str(reaction_components)})
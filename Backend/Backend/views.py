##
# @file views.py
# @brief Ce fichier permet de setUp les différents services du serveur.
# @section function :
# - @param getActionsService : permet de récupérer les actions d'un service
# - @param getReactionsService : permet de récupérer les réactions d'un service
# - @param getdate : permet de récupérer la date actuelle
# - @param get_client_ip : permet de récupérer l'ip du client
# - @param about : permet de récupérer les informations du serveur

from django.http import HttpRequest, JsonResponse
from Service.views import getService
from Service.models import Service
from applet.models import Action, Reaction
from datetime import datetime

def getActionsService(service_id) -> list:
    try:
        value = Action.objects.filter(id_service=service_id)
        result_action = [{'name': action.get('name'), 'description': action.get('description')} for action in value.values()]
        return result_action
    except:
        return []

def getReactionsService(service_id) -> list:
    try:
        value = Reaction.objects.filter(id_service=service_id)
        result_action = [{'name': action.get('name'), 'description': action.get('description')} for action in value.values()]
        return result_action
    except:
        return []

def getdate():
    return datetime.utcnow().timestamp()

def get_client_ip(request : HttpRequest):
    x_forwarded_for = request.META.get('HTTP_X_FORWARDED_FOR')
    if x_forwarded_for:
        ip = x_forwarded_for.split(',')[0]
    else:
        ip = request.META.get('REMOTE_ADDR')
    return ip

def about(request : HttpRequest):
    services = []
    qs = list(Service.objects.values())
    for service in qs:
        try:
            name = service.get('name')
            id = service.get('id')
            json_service = {'name': name}
            json_service = {**json_service, 'actions' : getActionsService(id)}
            json_service = {**json_service, 'reactions' : getReactionsService(id)}
            services.append(json_service)
        except:
            return JsonResponse({'success': False})
    server = {"server": {"current_time": getdate(), "services": services}}
    return JsonResponse({"client": {"host": get_client_ip(request)} ,**server})

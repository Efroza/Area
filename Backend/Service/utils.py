from .serviceShema import ServiceShema
from .models import ServiceAccount, Service

def getServiceSchema(name : str, all_service : list) -> ServiceShema:
    for service in all_service:
        if service.name == name:
            return service
    return None

def getServiceAccountEmail(service_name, id_user):
    try:
        service = Service.objects.get(name=service_name)
        return ServiceAccount.objects.get(id_service=service.id, id_user=id_user).email
    except:
        return None

def getServiceAccountPassword(service_name, id_user):
    try:
        service = Service.objects.get(name=service_name)
        return ServiceAccount.objects.get(id_service=service.id, id_user=id_user).password
    except:
        return None

def getServiceAccountToken(service_name, id_user):
    try:
        service = Service.objects.get(name=service_name)
        for service in  list(ServiceAccount.objects.filter(id_service=service.id, id_user=id_user).values()):
            return service['token']
    except:
        return None

def getServiceAccountExtra(service_name, id_user):
    try:
        service = Service.objects.get(name=service_name)
        return ServiceAccount.objects.get(id_service=service.id, id_user=id_user).extra
    except:
        return None

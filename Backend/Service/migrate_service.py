import importlib.util
import os
from types import ModuleType
from .models import Service
from .path_service import ActualDirectory, ServiceDirectory, ServiceModule
from .serviceShema import ServiceShema
from .service.Time import getService

def colored(r, g, b, text):
    return "\033[38;2;{};{};{}m{} \033[38;2;255;255;255m".format(r, g, b, text)

def import_module(name : str, directory : str) -> ModuleType:
    try:
        return importlib.util.spec_from_file_location(
            name, ActualDirectory + '/' + directory + '/' + name + '.py'
            ).loader.load_module()
    except:
        print(colored(255, 0, 0, 'error Service file module [ '+ name + " ] does not exist"))
        return None

def export_db_service(service : ServiceShema) -> int:
    try:
        service_db = Service.objects.get(name = service.name)
        try:
            service_db.inscription = service.needRegister
            service_db.save()
        except:
            print(colored(255, 0, 0, 'cannot save new value inscription for ' + service.name))
        return service_db.id
    except:
        print(service.name, 'service not in db Action')
        try:
            service_db = Service(name = service.name, description=service.description, image = service.image, inscription=service.needRegister)
            service_db.save()
            print(colored(0, 255, 0, 'migration: ' + service.name + ' in service'))
            return service_db.id
        except:
            print(colored(255, 0, 0, 'error in migration service ' + service.name))
    return 0

def migrate_service() -> list:
    result : list[ServiceShema] = []
    for ServiceFile in ServiceModule:
        Module = import_module(ServiceFile, ServiceDirectory)
        try:
            service : ServiceShema = Module.getService()
        except:
            print(colored(255, 0, 0, ServiceDirectory + '.' + ServiceFile + ' dose not provide exepted method "getService() -> Applet.serviceShema"'))
            continue
        if service == None or type(service) != ServiceShema or service.name == None:
            print(colored(255, 0, 0, ServiceDirectory + '.' + ServiceFile + ' error service not Service.serviceSHema'))
            continue
        id : int = export_db_service(service)
        service.set_db_id(id)
        result.append(service)
    return result
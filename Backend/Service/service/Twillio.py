from Service.serviceShema import ServiceShema, InfoRegister
from twilio.rest import Client


image = 'assets/twillio-logo.png'

name = 'Twillio'

description = 'Twillio Service'

needRegister = True

def register(register : InfoRegister):
    token = register.token
    sid = register.extra
    try:
        client = Client(sid, token)
        return True
    except:
        return False


twillio = ServiceShema(name=name, description=description, image=image, needRegister=needRegister, register=register)

def getService():
    twillio.useInfo.email = False
    twillio.useInfo.password = False
    twillio.useInfo.token = True
    twillio.useInfo.extra.required = True
    twillio.useInfo.extra.description = 'Sid'
    return twillio
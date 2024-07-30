from Service.serviceShema import ServiceShema

image = 'assets/hockey-logo.png'

name = 'Hockey'

description = 'Hockey Service'

hockey = ServiceShema(name=name, description=description, image=image, needRegister=False)

def getService():
    return hockey
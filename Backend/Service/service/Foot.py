from Service.serviceShema import ServiceShema

image = 'assets/hockey-logo.png'

name = 'Foot'

description = 'Foot Service'

foot = ServiceShema(name=name, description=description, image=image, needRegister=False)

def getService():
    return foot
from Service.serviceShema import ServiceShema

name = 'Whatsapp'

description = 'Whatsapp service'

image = 'assets/logo-whatsapp.jpg'

whatsapp = ServiceShema(name=name, description=description, image=image)

def getService():
    return whatsapp
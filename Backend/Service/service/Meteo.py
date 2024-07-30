from Service.serviceShema import ServiceShema

image = 'assets/meteo.jpeg'

name = 'Meteo'

description = 'Meteo Service'

meteo = ServiceShema(name=name, description=description, image=image, needRegister=False)

def getService():
    return meteo
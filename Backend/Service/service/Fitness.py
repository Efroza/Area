from Service.serviceShema import ServiceShema

image = 'assets/fitness-logo.png'

name = 'Fitness'

description = 'Fitness Service'

fit = ServiceShema(name=name, description=description, image=image, needRegister=False)

def getService():
    return fit
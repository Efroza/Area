from Service.serviceShema import ServiceShema

image = 'assets/music.jpeg'

name = 'Music'

description = 'Music service'

music = ServiceShema(name=name, description=description, image=image, needRegister=False)

def getService():
    return music
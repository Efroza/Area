from Service.serviceShema import ServiceShema

image = 'assets/nba-logo.png'

name = 'NBA'

description = 'NBA Service'

nba_coco_jorrrdan = ServiceShema(name=name, description=description, image=image, needRegister=False)

def getService():
    return nba_coco_jorrrdan
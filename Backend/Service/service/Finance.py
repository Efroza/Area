from Service.serviceShema import ServiceShema

name = 'Finance'

description = 'Finance service for crypto and ...'

image = 'assets/finance-logo.jpg'

finance = ServiceShema(name=name, description=description, image=image)

def getService():
    return finance
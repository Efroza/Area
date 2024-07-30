from Service.serviceShema import ServiceShema, InfoRegister, Info
import smtplib, ssl

image = 'assets/20221024141851google.jpg'

name = 'Google'

description = 'Google Service'

needRegister = True

def register(register : InfoRegister):
    email = register.email
    password = register.password
    try:
        context = ssl.create_default_context()
        server = smtplib.SMTP_SSL('smtp.gmail.com', 465, context=context)
        server.login(email, password)
        server.close()
        return True
    except:
        return False

google_service = ServiceShema(name=name, description=description, image=image, needRegister=needRegister
, register=register)

def getService():
    google_service.oauth2 = True
    return google_service
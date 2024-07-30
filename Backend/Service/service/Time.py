from Service.serviceShema import ServiceShema

image = 'assets/time-image.jpg'

Time_Service : ServiceShema =  ServiceShema(name="Time", description="Time Module"
, image=image,
needRegister = False)

def getService() -> ServiceShema:
    return Time_Service
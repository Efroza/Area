class InfoRegister:
    email : str = ''
    password : str = ''
    token : str = ''
    extra : str = ''

def default_register(register : InfoRegister) -> True:
    print('default_register', 'email:', register.email, 'password:', register.password)
    return True

class Extra:
    def __init__(self, description = '', required = False) -> None:
        self.description : str = description
        self.required : bool = required

class Info:
    def __init__(self, email = True, password = True, token = False) -> None:
        self.email : bool = email
        self.password : bool = password
        self.token : bool = token
        self.extra : Extra = Extra()

class Oauth2:
    def __init__(self, eligible, register_function = default_register) -> None:
        self.eligible = eligible
        self.register_function = register_function
        self.client_id  = ''
        self.client_secret = ''
        self.redirect_uri = ''
        self.endpoint = ''
        self.urlportal = ''
        self.url_save_code = ''
        self.scope = []

class ServiceShema:
    def __init__(self, name : str, description : str = ""
    , image : str = 'assets/default-image.jpg'
    , needRegister : bool = False, register = default_register, oauth2 = False):
        self.name = name
        self.description = description
        self.image = image
        self.needRegister = needRegister
        self.register = register
        self.id : int = 0
        self.useInfo : Info = Info()
        self.oauth2 = Oauth2(oauth2)
    def set_db_id(self, id : int):
        self.id = id
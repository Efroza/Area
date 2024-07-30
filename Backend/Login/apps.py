##
# @file apps.py
# @brief Ce fichier permet de setUp l'app Login.
# @section la class LoginConfig :
# - @param AppConfig : permet de créer une app
from django.apps import AppConfig

class LoginConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'Login'

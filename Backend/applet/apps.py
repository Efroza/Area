##
# @file apps.py
# @brief Ce fichier permet de setUp l'app applet.
from django.apps import AppConfig


class AppletConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'applet'

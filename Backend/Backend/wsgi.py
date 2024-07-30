"""
WSGI config for Backend project.

It exposes the WSGI callable as a module-level variable named ``application``.

For more information on this file, see
https://docs.djangoproject.com/en/4.1/howto/deployment/wsgi/
"""

##
# @file wsgi.py
# @brief Ce fichier permet de setUp les settings du backend django.
# @section os.environ.setdefault :
# - @param 'DJANGO_SETTINGS_MODULE' : permet de setUp le module de settings
# - @param 'Backend.settings' : permet de setUp le module de settings
import os

from django.core.wsgi import get_wsgi_application

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'Backend.settings')

application = get_wsgi_application()

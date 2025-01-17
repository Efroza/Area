"""
ASGI config for Backend project.

It exposes the ASGI callable as a module-level variable named ``application``.

For more information on this file, see
https://docs.djangoproject.com/en/4.1/howto/deployment/asgi/
"""
##
# @file asgi.py
# @brief Ce fichier permet de setUp les settings du backend django.

import os

from django.core.asgi import get_asgi_application

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'Backend.settings')

application = get_asgi_application()

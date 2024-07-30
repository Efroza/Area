##
# @file urls.py
# @brief Ce programme permet de setUp les différentes routes des applets.
#
# @section Les différentes routes :
#   - action/ : permet de récupérer les actions disponibles pour l'utilisateur.
#   - action/<str:action> : permet de récupérer les informations d'une action.
#   - action/mandatory : permet de récupérer les actions obligatoires pour l'utilisateur pour chaque action.
#   - action/mandatory/<str:action> : permet de récupérer les actions obligatoires pour l'utilisateur pour une action.
#   - reaction/ : permet de récupérer les réactions disponibles pour l'utilisateur.
#   - reaction/<str:reaction> : permet de récupérer les informations d'une réaction.
#   - reaction/mandatory : permet de récupérer les réactions obligatoires pour l'utilisateur pour chaque réaction.
#   - reaction/mandatory/<str:reaction> : permet de récupérer les réactions obligatoires pour l'utilisateur pour une réaction.
#   - applet/ : permet de récupérer les applets disponibles pour l'utilisateur.
#   - activate : permet d'activer une applet.

import imp
from django.urls import path
from . import views

urlpatterns = [
    path('action', views.getAction),
    path('reaction', views.getReaction),
    path('action/<str:name>', views.getActionName),
    path('activate', views.activateApplet),
    path('applet/', views.postApplet),
    path('action/mandatory/<int:id>', views.getActionMandatoryId),
    path('action/mandatory', views.getActionMandatory),
    path('reaction/mandatory/<int:id>', views.getReactionMandatoryId),
    path('reaction/mandatory', views.getReactionMandatory),
    path('action/service/<int:id>', views.getActionServiceId),
    path('reaction/service/<int:id>', views.getReactionServiceId),
    path('action/service/<str:name>', views.getActionServiceName),
    path('reaction/service/<str:name>', views.getReactionServiceName),
]
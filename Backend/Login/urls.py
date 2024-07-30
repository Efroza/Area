##
# @file urls.py
# @brief Ce programme permet de setUp les différentes routes du serveur.
#
# @section Les différentes routes
#   - /signup : permet de créer un nouvel utilisateur.
#   - /signin : permet de connecter l'utilisateur.
#   - /forgetPassword : permet de changer le mot de passe de l'utilisateur.
#   - /confirm/token=... : permet de vérifier l'email de l'utilisateur.
#   - /confirm/email=<str:mail>/newPass=... : permet de confimer le changement de mot de passe de l'utilisateur.
from django.urls import path
from . import views

urlpatterns = [
    path('', views.home, name='home'),
    path('home', views.home, name='home'),
    path('signin', views.signin, name='signin'),
    path('forgetPassword', views.forgetPassword, name='forgetPassword'),
    path('confirm/email=<str:mail>/newPass=<str:password>', views.newPass, name='newPass'),
    path('signup', views.signup, name='signup'),
    path('confirm/token=<auth_token>', views.verify_register, name='confirm'),

]
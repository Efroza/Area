##
# @file liker_commentaire.py
# @brief Ce fichier permet de liker un commentaire
# @section like_comment :
# @description : Fonction qui permet de liker un commentaire
from django.http import QueryDict
from applet.Applet import Reaction_Components
from Service.utils import getServiceAccountEmail, getServiceAccountPassword

mandatory = ['commentaire', 'post']
name = 'LIKER COMMENTAIRE'
description = 'Liker un commentaire sous un post'
service = 'Google'

def like_comment(id_user : int, data : QueryDict):
    commentaire = data.get('commentaire')
    post = data.get('post')
    print('you liked the comment', commentaire, 'in the post', post)
    print('email', getServiceAccountEmail(service, id_user))
    print('password', getServiceAccountPassword(service, id_user))

like : Reaction_Components = Reaction_Components(func=like_comment, name=name, description=description, mandatory=mandatory)

like.service = service

def getReaction() -> Reaction_Components:
    return like

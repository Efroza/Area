##
# @file test_two.py
# @brief Ce fichier permet de créer une reaction 'test_two'.
# @section test_function :
# - @param id_user : id de l'utilisateur
# - @param query : les données du message
# - @description : permet de récupérer la description et l'action et de les afficher.
from django.http import QueryDict
from applet.Applet import Reaction_Components

mandatory = ['description', 'action']

def test_function(id_user : int, query : QueryDict):
    print('------------------------test_two------------')
    print('id user:', id_user)
    print('description = ', query.get('description'))
    print('action = ', query.get('action'))
    print('------------------------------------')


test_reaction : Reaction_Components = \
    Reaction_Components(test_function, "test_two_reaction", description="just test reaction file", mandatory=mandatory)

def getReaction() -> Reaction_Components:
    return test_reaction
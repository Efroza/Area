##
# @file test_one.py
# @brief Ce fichier permet de créer une reaction 'test_one'.
# @section test_function :
# - @param id_user : id de l'utilisateur
# - @param query : les données du message
# - @description : permet de récupérer le message et de l'afficher dans la console.
from django.http import QueryDict
from applet.Applet import Reaction_Components

mandatory = ['message']

def test_function(id_user : int, query : QueryDict):
    print('---------Reaction test_one------------')
    print(query)
    print(query.get('message'))
    print('-------------------------')

test_reaction : Reaction_Components = \
    Reaction_Components(test_function, "test_one_reaction", description="just test reaction file", mandatory=mandatory)

def getReaction() -> Reaction_Components:
    return test_reaction

##
# @file test_tree.py
# @brief Ce fichier permet de créer une réaction 'test_tree'.
# @section run :
# - @param id_user : id de l'utilisateur
# - @param query : les données du message
# - @description : permet de récupérer le theme, le message et le name dans le query et de les afficher
from django.http import QueryDict
from applet.Applet import Reaction_Components

mandatory = ['theme', 'message', 'name']

def run(id_user : int, query : QueryDict):
    print('------------------------test_tree------------')
    print('thme = ', query.get('theme'))
    print('message = ', query.get('message'))
    print('name = ', query.get('name'))
    print('------------------------------------')

test_reaction : Reaction_Components = \
    Reaction_Components(run, "test_tree_reaction", description="another test", mandatory=mandatory, service_name='Google')

def getReaction() -> Reaction_Components:
    return test_reaction
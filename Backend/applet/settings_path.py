##
# @file settings_path.py
# @brief Ce fichier permet de définir les chemins des fichiers des reactions et actions
# @section ActionDirectory :
# @description : Chemin vers le dossier des actions
# @section ReactionDirectory :
# @description : Chemin vers le dossier des reactions
# @section ActionModules :
# @description : Chemin des fichiers des actions
# @section ReactionModules :
# @description : Chemin des fichiers des reactions
ActualDirectory = 'applet'

ActionDirectory = 'Action'

ActionModules = [
    'Schedule',
    'receiveGmail',
    'MeteoAction',
    'MarketCoin',
    'MeteoActionHumidity',
    'FitIbm',
    'BetHockey',
    'Jooorrdan',
    'NewTweet',
    'BetFoot'
]

ReactionDirectory = 'Reaction'

ReactionModules = [
    'test_one',
    'test_two',
    'test_tree',
    'liker_commentaire',
    'sendGmail',
    'sendMessage',
    'SendMessageWhatsapp',
    'PostTweet'
]
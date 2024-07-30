##
# @file MusicReact.py
# @brief Ce fichier permet de créer la réaction PlayMusic.
# @section PlayMusic :
# - @param id_user : id de l'utilisateur
# - @param query : les données du message
# - @description : permet de récupérer le nom de la musique et de la jouer.
from django.http import QueryDict
from applet.Applet import Reaction_Components

import requests

name = 'PlayMusic'

description = 'play music'

mandatory = ['music_name']

service = 'Music'

url = "https://kareoke.p.rapidapi.com/v1/song/search"

headers = {
	"X-RapidAPI-Key": "56d8f9087cmsh22258227e48c10bp10a6a7jsne69caf6e9b7e",
	"X-RapidAPI-Host": "kareoke.p.rapidapi.com"
}

def main(id_user : int, data : QueryDict) :
    music_name = data.get('music_name')
    try :
        querystring = {"q": music_name,"limit":"1"}
        response = requests.request("GET", url, headers=headers, params=querystring)
        print(response.text)
    except :
        return


PlayMusic = Reaction_Components(func=main, name=name, description=description, mandatory=mandatory, service_name=service)

##
# @file MeteoActionHumidity.py
# @brief Ce fichier permet de créer l'action MeteoActionHumidity.
# @section meteo_action :
# - @param id_user : id de l'utilisateur
# - @param query : les données du message
# - @description : permet de récupérer la ville et la limite d'humidité dans le query et de les afficher
from django.http import QueryDict
from applet.Applet import Action_Components
import requests

name = 'Action Meteo Humidity'

description = "declanche un applet quand l'humidite vaut une certain valeur"

mandatory = ['city', 'limit humidity']

service = 'Meteo'

url = "https://weather-by-api-ninjas.p.rapidapi.com/v1/weather"

headers = {
	"X-RapidAPI-Key": "56d8f9087cmsh22258227e48c10bp10a6a7jsne69caf6e9b7e",
	"X-RapidAPI-Host": "weather-by-api-ninjas.p.rapidapi.com"
}

def main(id_user : int, query : QueryDict):
    city = query.get('city')
    querystring = {"city": city, "country": "France"}
    try:
        limt = int(query.get('limit humidity'))
        response = requests.request("GET", url, headers=headers, params=querystring)
        humidity = response.json()['humidity']
        if humidity > limt:
            return True
        return False
    except:
        return False



meteo_action = Action_Components(func=main, name=name, description=description, mandatory=mandatory, service_name=service)

def getAction():
    return meteo_action
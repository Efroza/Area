from django.http import QueryDict
from applet.Applet import Action_Components
import requests

name = "Action Football"

description = "Pari sur qui va gagner entre la homeTeam et la awayTeam, et tente de gagner une reaction !"

mandatory = ['FootEkip', 'date']

service = 'Foot'

url = "https://soccer-data.p.rapidapi.com/match/list/results"

headers = {
	"X-RapidAPI-Key": "e5352d65bamshc20d6300e0f845cp165da5jsn94e6fe091cee",
	"X-RapidAPI-Host": "soccer-data.p.rapidapi.com"
}

def main(id_user : int, query : QueryDict):
    date = query.get('date')
    querystring = {'date': date}
    try:
        ekip = query.get('FootEkip')
        response = requests.request("GET", url, headers=headers, params=querystring)
        if ekip == 'homeTeam':
            return True if response.json()[0]['homeTeam']['score']['current'] > response.json()[0]['awayTeam']['score']['current'] else False
        elif ekip == 'awayTeam':
            return True if response.json()[0]['awayTeam']['score']['current'] > response.json()[0]['homeTeam']['score']['current'] else False
        return False
    except:
        return False

Soccer_el_futbol = Action_Components(func=main, name=name, description=description, mandatory=mandatory, service_name=service)

def getAction():
    return Soccer_el_futbol
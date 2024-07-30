from django.http import QueryDict
from applet.Applet import Action_Components
import requests

name = "Action Betting Hockey"

description = "Pari sur qui va gagner entre la homeTeam et la awayTeam, et tente de gagner une reaction !"

mandatory = ['team', 'date']

service = 'Hockey'

url = "https://ice-hockey-data.p.rapidapi.com/match/list/results"

querystring = {"date":"28/01/2021"}

headers = {
	"X-RapidAPI-Key": "e5352d65bamshc20d6300e0f845cp165da5jsn94e6fe091cee",
	"X-RapidAPI-Host": "ice-hockey-data.p.rapidapi.com"
}

def main(id_user : int, query : QueryDict):
    date = query.get('date')
    querystring = {"date": date}
    try:
        team = query.get('team')
        response = requests.request("GET", url, headers=headers, params=querystring)
        if team == 'homeTeam':
            team1 = response.json()[0][team]['score']['current']
            team2 = response.json()[0]['awayTeam']['score']['current']
            return True if team1 > team2 else False
        elif team == 'awayTeam':
            team1 = response.json()[0]['homeTeam']['score']['current']
            team2 = response.json()[0][team]['score']['current']
            return True if team1 < team2 else False
        return False
    except:
        return False

bet_hockey = Action_Components(func=main, name=name, description=description, mandatory=mandatory, service_name=service)

def getAction():
    return bet_hockey
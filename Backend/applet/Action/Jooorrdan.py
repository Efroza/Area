from django.http import QueryDict
from applet.Applet import Action_Components
import requests

name = "Action NBA 2K22"

description = "Pari sur ton équipe préférée et reçois des petits cadeaux !"

mandatory = ['NBAteam', 'date']

service = 'NBA'

url = "https://basketball-data.p.rapidapi.com/match/list/results"

headers = {
	"X-RapidAPI-Key": "e5352d65bamshc20d6300e0f845cp165da5jsn94e6fe091cee",
	"X-RapidAPI-Host": "basketball-data.p.rapidapi.com"
}

def main(id_user : int, query : QueryDict):
    date = query.get('date')
    querystring = {'date': date}
    try:
        myteam = query.get('NBAteam')
        response = requests.request("GET", url, headers=headers, params=querystring)
        if response.json()[0]['homeTeam']['name'] == myteam:
            return True if response.json()[0]['homeTeam']['score']['current'] > response.json()[0]['awayTeam']['score']['current'] else False
        elif response.json()[0]['awayTeam']['name'] == myteam:
            return True if response.json()[0]['awayTeam']['score']['current'] > response.json()[0]['homeTeam']['score']['current'] else False
        return False
    except:
        return False

bet_NBA = Action_Components(func=main, name=name, description=description, mandatory=mandatory, service_name=service)

def getAction():
    return bet_NBA
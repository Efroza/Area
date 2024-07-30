##
# @file MarketCoin.py
# @brief Ce fichier permet de définir l'action MarketCoin
# @section main :
# @param id_user : id de l'utilisateur
# @param data : les données du message
# @description : permet de récupérer le nom de la crypto, le nom de l'exchange plateform, le prix max et la quote
# @return : True si le prix de la crypto est inférieur ou égal au prix max, False sinon
from django.http import QueryDict
from applet.Applet import Action_Components
import requests


name = 'Market Coin'

description = 'declanche un applet lorsque le [prix crypto] est en dessous du [prix max] ayant pour base USDT'

service = 'Finance'

mandatory = ['crypto', 'exchange plateform', 'prix max']

url = "https://coinlore-cryptocurrency.p.rapidapi.com/api/coin/markets/"

querystring = {"id":"90"}

headers = {
	"X-RapidAPI-Key": "56d8f9087cmsh22258227e48c10bp10a6a7jsne69caf6e9b7e",
	"X-RapidAPI-Host": "coinlore-cryptocurrency.p.rapidapi.com"
}

def main(id_user : int, data : QueryDict):
    name = data.get('crypto')
    name_exchange = data.get('exchange plateform')
    prix_max = data.get('prix max')
    quote = 'USDT'
    response = requests.request("GET", url, headers=headers, params=querystring)
    result = -1

    try:
        for value in response.json():
            if str(value.get('name')).capitalize() == name_exchange.capitalize() and \
                value.get('base') == name and value.get('quote') == quote:
                result = value.get('price')
        if result == -1:
            return False
        prix_max = int(prix_max)
        return result <= prix_max
    except:
        return False

market_coin = Action_Components(func=main, name=name, description=description, mandatory=mandatory, service_name=service)

def getAction():
    return market_coin
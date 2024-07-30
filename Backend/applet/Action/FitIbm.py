from django.http import QueryDict
from applet.Applet import Action_Components
import requests

name = "Action Fitness Ibm"

description = "un calculateur qui renvoie un truc en fonction de l'echelle ibm"

mandatory = ['age', 'weight', 'height', 'ibm']

service = 'Fitness'

url = "https://fitness-calculator.p.rapidapi.com/bmi"

headers = {
	"X-RapidAPI-Key": "e5352d65bamshc20d6300e0f845cp165da5jsn94e6fe091cee",
	"X-RapidAPI-Host": "fitness-calculator.p.rapidapi.com"
}

def main(id_user : int, query : QueryDict):
    age = query.get('age')
    weight = query.get('weight')
    height = query.get('height')
    querystring = {"age": age, "weight": weight, "height": height}
    try:
        ibm = float(query.get('ibm'))
        response = requests.request("GET", url, headers=headers, params=querystring)
        ibm_range = response.json()['data']['healthy_bmi_range']
        ibm_range = ibm_range.split('-')
        ibm_range = [float(i) for i in ibm_range]
        return True if ibm > min(ibm_range) and ibm < max(ibm_range) else False
    except:
        return False

fit_ibm_action = Action_Components(func=main, name=name, description=description, mandatory=mandatory, service_name=service)

def getAction():
    return fit_ibm_action
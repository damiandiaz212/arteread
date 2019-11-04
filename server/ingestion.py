import requests
import json

API = "KEY_HERE"
URL = 'https://api.nal.usda.gov/fdc/v1/search'

headers = {'Content-Type':'application/json'}
auth = (API, '')
payload = {"generalSearchInput":"Cheddar cheese"}

response = requests.post(URL, data=json.dumps(payload), headers=headers, auth=auth).json()

# grab the food code from the top result
foods = response['foods']
top_result = foods[0]
food_code = top_result['foodCode']
print(food_code)
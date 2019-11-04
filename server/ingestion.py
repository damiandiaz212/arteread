import requests
import json
import timeit
import sys

API = sys.argv[1]
URL_1 = 'https://api.nal.usda.gov/fdc/v1/search'
URL_2 = 'https://api.nal.usda.gov/fdc/v1/'

headers = {'Content-Type':'application/json'}
auth = (API, '')

# what we return if we have a bad request
error = {
	"message":"error"
}

def getInfo(keywords):
	
	# create payload
	payload = {"generalSearchInput":keywords}
	
	# get food code
	start = timeit.default_timer()
	response = requests.post(URL_1, data=json.dumps(payload), headers=headers, auth=auth)
	stop = timeit.default_timer()
	time = stop - start

	if response.status_code == 200:
	
		response = response.json()

		# grab the food code from the top result
		foods = response['foods']
		top_result = foods[0]
		food_code = str(top_result['fdcId'])

		# debug
		print('Food Code Retrieved: ' + food_code + ' took(sec): ', time)
	
	else:
		print('[GENERAL SEARCH REQUEST FAILED]')
		print(response.request.url)
		print(response.status_code)
		print(response.json())
		return error

	#######

	# get nutrient info
	start = timeit.default_timer()
	response = requests.get(URL_2+food_code, headers=headers, auth=auth)
	stop = timeit.default_timer()
	time = stop - start

	if response.status_code == 200:

		# debug
		print('Food Data Retrieved: ' + food_code + ' took(sec): ', time)
		response = response.json()

		# parsing info
		foodNutrients = response['foodNutrients']
		nutrient_name = response['description']
		nutrient_object  = findCholesterol(foodNutrients)

		if nutrient_object == None:
			print('Couldnt find Cholesterol content in' + nutrient_name)
			return error

		nutrient_amount = nutrient_object['amount']
		nutrient_info = nutrient_object['nutrient']
		printNutrientInfo(nutrient_name, nutrient_info, nutrient_amount)
	else:
		print('[CODE SEARCH REQUEST FAILED]')
		print(response.request.url)
		print(response.status_code)
		print(response.json())
		return error


def outputJSONData(data):
	with open('data.txt', 'w') as out:
		json.dump(data, out)

def printNutrientInfo(name, info, amount):
	nName = info['name']
	unit = info['unitName']
	print('\nFood: ' + name + '\n' + nName +': ' + str(amount) + ' ' + unit)

def findCholesterol(data):

	for i in data:
		temp = i['nutrient']
		if temp['name'] == 'Cholesterol':
			return i

	return None



getInfo(str(sys.argv[2]))
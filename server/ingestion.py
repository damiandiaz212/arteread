import requests
import json
import timeit
import sys

class ingestion:

	def getInfoJSON(self, keywords, api):

		URL_1 = 'https://api.nal.usda.gov/fdc/v1/search'
		URL_2 = 'https://api.nal.usda.gov/fdc/v1/'

		headers = {'Content-Type':'application/json'}

		# what we return if we have a bad request
		error = {
			"message":"error"
		}

		auth = (api, '')
		
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
			error['reason'] = 'unable to locate a result matching those keywords.'
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
			nutrient_object  = self.findCholesterol(foodNutrients)

			if nutrient_object == None:
				print('Couldnt find Cholesterol content in' + nutrient_name)
				error['reason'] = 'unable to find cholesterol.'
				return error

			nutrient_amount = nutrient_object['amount']
			nutrient_info = nutrient_object['nutrient']
			self.printNutrientInfo(nutrient_name, nutrient_info, nutrient_amount)
			return self.getNutrientInfo(nutrient_name, nutrient_info, nutrient_amount)
		else:
			print('[CODE SEARCH REQUEST FAILED]')
			print(response.request.url)
			print(response.status_code)
			print(response.json())
			error['reason'] = 'fdcId invalid.'
			return error


	def outputJSONData(self, data):
		with open('data.txt', 'w') as out:
			json.dump(data, out)

	def printNutrientInfo(self, name, info, amount):
		nName = info['name']
		unit = info['unitName']
		print('\nFood: ' + name + '\n' + nName +': ' + str(amount) + ' ' + unit)

	def getNutrientInfo(self, name, info, amount):
		nName = info['name']
		unit = info['unitName']
		return {'Food':name, 'Type':nName, 'Unit':unit, 'Amount':amount}

	def findCholesterol(self, data):

		for i in data:
			temp = i['nutrient']
			if temp['name'] == 'Cholesterol':
				return i

		return None



	#getInfo(sys.argv[1], str(sys.argv[2]))
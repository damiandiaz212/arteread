import requests
import json
import timeit
import sys


class ingestion:

	def getInfoJSON(self, keywords, api):

		URL_1 = 'https://api.nal.usda.gov/fdc/v1/search'
		URL_2 = 'https://api.nal.usda.gov/fdc/v1/'
		error = {"message":"error"}
		headers = {'Content-Type':'application/json'}

		results_per_request = 5
		auth = (api, '')
		
		# create payload
		payload = {"generalSearchInput":keywords,
					"includeDataTypes":{"Survey (FNDDS)":False,"Foundation":True,"Branded":True,"SR Legacy":True},
					"requireAllWords":"true"
					}
		
		# get food code
		start = timeit.default_timer()
		response = requests.post(URL_1, data=json.dumps(payload), headers=headers, auth=auth)
		stop = timeit.default_timer()
		time = stop - start

		if response.status_code == 200:
		
			response = response.json()

			# grab the food code from the top result
			foods = response['foods']
			top_result = []

			if len(foods) < results_per_request:
				top_result = foods[:len(foods)]
			else:
				top_result = foods[:results_per_request]

			food_codes = []

			for i in top_result:
				food_codes.append(str(i['fdcId']))

			# debug
			#print('Food Code Retrieved: ' + food_codes + ' took(sec): ', time)
		
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

		response = []
		for i in food_codes:
			response.append(requests.get(URL_2+i, headers=headers, auth=auth))
		stop = timeit.default_timer()

		time = stop - start

		if response[0].status_code == 200:

			# debug
			#print('Food Data Retrieved: ' + food_codes + ' took(sec): ', time)
			
			for i in range(len(response)):
				response[i] = response[i].json()

			info = []

			# parsing info
			for i in response:
				
				foodNutrients = i['foodNutrients']
				nutrient_name = i['description']
				nutrient_object  = self.findCholesterol(foodNutrients)

				if nutrient_object == None:
					print('Couldnt find Cholesterol content in' + nutrient_name)
					error['reason'] = 'unable to find cholesterol.'
					return error

				nutrient_amount = nutrient_object['amount']
				nutrient_info = nutrient_object['nutrient']
				info.append(self.getNutrientInfo(nutrient_name, nutrient_info, nutrient_amount))

			
			return {keywords:info}

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
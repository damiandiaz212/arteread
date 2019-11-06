![logo](https://i.imgur.com/Wq23K7e.png)

# What is it?
arteread is a mobile app to keep track of your cholesterol intake. 

  - Keep track of your cholesterol intake daily with easy UX
  - Add meals on the fly by searching foods to automatically add to your daily intake
  - Set goals and get recommendations for a healthier diet
  - View your data on a chart

# How to use?
install requirements
```shell
$ pip install -r requirements.txt
```
navigate into server and run flask
```shell
$ cd arteread/server
$ flask run
```
in another terminal run
```shell
$ curl -X POST http://localhost:5000/api/v1.0/search/<FOOD_HERE>/api=<API_KEY>
```
*NOTE: you need a FDC api key to run this script, you can get one at https://fdc.nal.usda.gov/api-key-signup.html*
![example](https://i.imgur.com/4ad8FLq.png)

# Development checklist
##### [BACK-END]
- [X] Create basic server side api ingestion engine
  - [X] Call FDC API using keywords and recieve actual results
  - [X] Parse JSON response and collect "Food Code" from top result
  - [X] Make another call with "Food Code" to collect nutrition info
  - [X] Parse JSON response and collect needed info
- [ ] Create server side request handler using Flask
  - [X] Handle inbound requests
  - [X] Parse keywords from request 
  	- [ ] possibly run natural language processing on them
  - [X] Send keywords to ingestion engine, recieve response
  - [X] Respond to initial request with ingestion response
  - [X] Secure API (authorization, request limits) 
- [ ] Build test dashboard to test back-end services
- [X] Deploy 
##### [FRONT-END]
- [X] Set up X-Code enviornment
- [ ] pending

*Have an idea for a feature? Fork this repo and add it to the list!*
 
# Stack:

![alt text][flask_logo] ![alt text][python_logo] ![alt text][swift_logo]

[flask_logo]: https://i.imgur.com/AwtdvZ8.png "Flask"
[python_logo]: https://cdn4.iconfinder.com/data/icons/logos-and-brands/512/267_Python_logo-128.png "Python"
[swift_logo]: https://cdn4.iconfinder.com/data/icons/logos-and-brands/512/332_Swift_logo-128.png "Swift"

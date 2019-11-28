![logo](https://i.imgur.com/MuNJxAp.png)
![app](https://i.imgur.com/fxo5p2q.png)

# UPDATE (11/27/2019)

As of right now i'm unfortunately unable to publish to the App Store or have a developer account due to my employment agreement with Apple, therefore further development will be paused for now. In the meantime I will be working on other projects outside of the mobile app space.
-Damian

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

_NOTE: you need a FDC api key to run this script, you can get one at https://fdc.nal.usda.gov/api-key-signup.html_
![example](https://i.imgur.com/4ad8FLq.png)

# Development checklist

##### [BACK-END]

- [x] Create basic server side api ingestion engine
  - [x] Call FDC API using keywords and recieve actual results
  - [x] Parse JSON response and collect "Food Code" from top result
  - [x] Make another call with "Food Code" to collect nutrition info
  - [x] Parse JSON response and collect needed info
- [x] Create server side request handler using Flask
  - [x] Handle inbound requests
  - [x] Parse keywords from request - [ ] possibly run natural language processing on them
  - [x] Send keywords to ingestion engine, recieve response
  - [x] Respond to initial request with ingestion response
  - [x] Secure API (authorization, request limits)
- [x] Deploy

##### [FRONT-END]

- [x] Set up X-Code enviornment
- [x] Create Overview page
  - [x] Create progress bar feature, with cholesterol amount
  - [x] Create date header, and labels
  - [x] Create info button
- [x] Create View Page
  - [x] Create list feature
  - [x] Create add button
- [ ] Create Add page
  - [x] Create search feature
  - [x] Create list and results found label
  - [ ] Create manual add button
  - [ ] Create back button
- [ ] Polish animations/transitions
- [ ] Publish!

_Have an idea for a feature? Fork this repo and add it to the list!_

# Stack:

![alt text][flask_logo] ![alt text][python_logo] ![alt text][swift_logo]

[flask_logo]: https://i.imgur.com/AwtdvZ8.png "Flask"
[python_logo]: https://cdn4.iconfinder.com/data/icons/logos-and-brands/512/267_Python_logo-128.png "Python"
[swift_logo]: https://cdn4.iconfinder.com/data/icons/logos-and-brands/512/332_Swift_logo-128.png "Swift"

![logo](https://i.imgur.com/lw6P8yt.png)

# What is it?
arteread is a mobile app to keep track of your cholesterol intake. 

  - Keep track of your cholesterol intake daily with easy UX
  - Add meals on the fly by searching foods to automatically add to your daily intake
  - Set goals and get recommendations for a healthier diet
  - View your data on a chart

# Development checklist
##### [BACK-END]
- [ ] Create basic server side api ingestion engine
  - [X] Call FDC API using keywords and recieve actual results
  - [X] Parse JSON response and collect "Food Code" from top result
  - [ ] Make another call with "Food Code" to collect nutrition info
  - [ ] Parse JSON response and collect needed info
- [ ] Create server side request handler using Flask
  - [ ] subtasks pending
- [ ] Test functionality with web app
- [ ] Deploy 
##### [FRONT-END]
- [ ] pending

*Have an idea for a feature? Fork this repo and add it to the list!*
 
# Stack:

![alt text][flask_logo] ![alt text][python_logo] ![alt text][swift_logo]

[flask_logo]: https://i.imgur.com/AwtdvZ8.png "Flask"
[python_logo]: https://cdn4.iconfinder.com/data/icons/logos-and-brands/512/267_Python_logo-128.png "Python"
[swift_logo]: https://cdn4.iconfinder.com/data/icons/logos-and-brands/512/332_Swift_logo-128.png "Swift"

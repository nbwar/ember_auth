MealPlanner.ApplicationController = Ember.Controller.extend
  currentUser: ( ->
    MealPlanner.AuthManager.get('apiKey.user')
  ).property('MealPlanner.AuthManager.apiKey')

  isAuthenticated: ( ->
    MealPlanner.AuthManager.isAuthenticated()
  ).property('MealPlanner.AuthManager.apiKey')

  actions:
    logout: () ->
      MealPlanner.AuthManager.reset()
      @.transitionToRoute('index')




MealPlanner.UsersNewRoute = Ember.Route.extend
  model : () ->
    # MealPlanner.User.create
    this.store.createRecord('user')


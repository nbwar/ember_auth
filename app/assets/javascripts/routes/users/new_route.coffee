MealPlanner.UsersNewRoute = Ember.Route.extend
  model : () ->
    @store.createRecord('user')
  setupController: (controller, model) ->
    @controller.set('model', model)


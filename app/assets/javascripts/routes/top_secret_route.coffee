MealPlanner.TopSecretRoute = Ember.Route.extend
  setupController: (controller) ->
    @controller.set('model', @store.find('user'))

###### This will work to instead of setupController
  # model: () ->
    # @store.find('user')


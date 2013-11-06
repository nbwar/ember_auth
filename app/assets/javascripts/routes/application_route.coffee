MealPlanner.ApplicationRoute = Ember.Route.extend
  init: () ->
    @_super()
    MealPlanner.AuthManager = AuthManager.create {
      store: @store
    }


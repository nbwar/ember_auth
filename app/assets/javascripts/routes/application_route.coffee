MealPlanner.ApplicationRoute = Ember.Route.extend
  init: () ->
    @_super()
    MealPlanner.AuthManager = AuthManager.create {
      store: @store
    }

    # MealPlanner.AuthManager.init(@store.get('store'))

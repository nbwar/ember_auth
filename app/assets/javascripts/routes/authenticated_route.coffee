MealPlanner.AuthenticatedRoute = Ember.Route.extend
  beforeModel: (transition) ->
    if (MealPlanner.AuthManager.isAuthenticated() == false && !$.cookie().access_token)
      @redirectToLogin(transition)

  redirectToLogin: (transition) ->
    loginController = @controllerFor('login')
    loginController.set('attemptedTransition', transition)
    @transitionTo('login')

    actions:
      errors: (reason, transition) ->
        @redirectToLogin(transition)

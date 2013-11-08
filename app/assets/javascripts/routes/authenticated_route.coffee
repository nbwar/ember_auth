AuthenticatedRoute = Ember.Route.extend
  beforeModel: (transition) ->
    if (!MealPlanner.AuthManager.isAuthenticated())
      @redirectToLogin(transition)

  redirectToLogin: (transition) ->
    sessionNewControler = @controllerFor('login')
    sessionsNewController.set('attemptedTransition', transition)
    @transitionTo('login')

    actions:
      errors: (reason, transition) ->
        @redirectToLogin(transition)

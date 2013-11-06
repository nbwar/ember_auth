MealPlanner.Router.map ()->
  @route 'login'

  @resource 'users', ->
    @route 'new'

  @route 'signup'

  @route 'top_secret'


MealPlanner.Router.map ()->
  @route 'login'

  @resource 'users', ->
    @route 'new'

  @route 'top_secret'


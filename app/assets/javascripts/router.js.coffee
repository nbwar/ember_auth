MealPlanner.Router.map ()->
  @resource 'sessions', ->
    @route 'new'

  @resource 'users', ->
    @route 'new'

  @route 'top_secret'


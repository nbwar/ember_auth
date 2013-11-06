MealPlanner.Router.map ()->
  @route 'login'

  @resource 'users', ->
    @route 'new'

  @route 'signup'

  @route 'top_secret'

# To remove # mark in URL but then can't refresh page
# MealPlanner.Router.reopen
  # location: 'history'


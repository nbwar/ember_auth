MealPlanner.User = DS.Model.extend
  username: DS.attr('string'),
  email: DS.attr('string')

  errors: {}


  # save: ->
    # console.log("saving")
    # this.get('store').commit();

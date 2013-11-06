MealPlanner.User = DS.Model.extend
  username: DS.attr('string'),
  email: DS.attr('string')

  # save: ->
    # console.log("saving")
    # this.get('store').commit();

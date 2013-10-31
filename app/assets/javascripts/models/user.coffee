MealPlanner.User = DS.Model.extend
  username : DS.attr('string')
  email: DS.attr('string')

  save: ->
    this.get('store').commit();

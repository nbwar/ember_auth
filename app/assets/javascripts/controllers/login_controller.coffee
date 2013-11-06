MealPlanner.LoginController = Ember.ObjectController.extend
  actions:
    loginUser: ->
      _this = @
      router = @get('target')
      data = @getProperties('username_or_email', 'password')
      $.post '/login', data, (response) ->
        MealPlanner.AuthManager.authenticate(response.api_key.access_token, response.api_key.user_id, _this.get('store'))
        _this.set('model', "");
        router.transitionTo('index')




MealPlanner.LoginController = Ember.ObjectController.extend
  attemptedTransition: null

  actions:
    loginUser: ->
      _this = @
      router = @get('target')
      data = @getProperties('username_or_email', 'password')
      attemptedTrans = @get('attemptedTransition')

      $.post '/login', data, (response) ->
        MealPlanner.AuthManager.authenticate(response.api_key.access_token, response.api_key.user_id, _this.get('store'))
        if (attemptedTrans)
          attemptedTrans.retry()
          _this.set('attemptedTransition', null)
        else
          _this.set('model', "")
          router.transitionTo('index')




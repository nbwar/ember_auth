MealPlanner.UsersNewController = Ember.ObjectController.extend
  actions:
    createUser: () ->
      _this = @
      data = @getProperties('username', 'email', 'password', 'password_confirmation')

      $.post '/users', { user: data }, (response) ->
        # TODO HOW TO SAVE MODEL TO STORE
        # _this.get('model').save

        #clears form
        _this.set('model', _this.store.createRecord('user'));
        MealPlanner.AuthManager.authenticate(response.api_key.access_token, response.api_key.user_id, _this.get('store'))
        _this.transitionToRoute('index')


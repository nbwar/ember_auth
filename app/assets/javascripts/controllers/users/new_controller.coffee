MealPlanner.UsersNewController = Ember.ObjectController.extend
  actions:
    createUser: () ->
      _this = @
      router = @get('target')
      data = @getProperties('username', 'email', 'password', 'password_confirmation')


      # window.user = @store.createRecord 'user', {
      #   username: 'Nick',
      #   email: 'nick@nick.com'
      # }
      $.post '/users', { user: data }, (response) ->
        _this.store.push 'user', {
          id: response.api_key.user_id,
          username: data['username'],
          email: data['email'],
        }
        MealPlanner.AuthManager.authenticate(response.api_key.access_token, response.api_key.user_id, _this.get('store'))
        _this.set('model', _this.store.createRecord('user'));
        router.transitionTo('index')
        # _this.transitionToRoute('index')











   # #   # TODO HOW TO SAVE MODEL TO STORE
      #   user = _this.store.crea 'user', {
      #     id: response.api_key.user_id,
      #     username: data['username'],
      #     email: data['email']
      #   }
      #   console.log(user)
      #   user2 = _this.store.find('user',response.api_key.user_id)
      #   console.log(user2)
      #   #clears form

      #   blah = _this.get('store').find('user', response.api_key.user_id)   #_this.get('store').find('user', response.api_key.user_id)
      #   console.log(blah)

var AuthManager = Ember.Object.extend({
  init: function() {
    this._super();
    var accessToken = $.cookie('access_token');
    var authUserId = $.cookie('auth_user');
    if(!Ember.isEmpty(accessToken) && !Ember.isEmpty(authUserId)) {
      this.authenticate(accessToken, authUserId);
    }
  },

  isAuthenticated: function() {
    return !Ember.isEmpty(this.get('apiKey.accessToken')) && !Ember.isEmpty(this.get('apiKey.user'))
  },

  authenticate: function(accessToken, userId, store) {
    $.ajaxSetup({
      headers: {'Authorization': 'Bearer ' + accessToken }
    });

    // TODO UNCOMMENT THESE TO DO OTHER TODOS
    // this.set('accessToken', accessToken);
    // this.set('userId', userId);


    // var user = MealPlanner.get('user', userId);
    // console.log(this.get('accessToken'));
    // console.log(this.get('userId'));
    // var store = MealPlanner.get('store');
    // var store = MealPlanner.Store;
    // var user = store.get('user', userId);
    // var api = MealPlanner.ApiKey.createRecord({
    //   accessToken: '123232323'
    // });

    // TODO FIGURE OUT HOW TO GET ACCESS TO USER
    // var user = MealPlanner.store.find('user', userId);
    // console.log('USER in auth manager');
    // console.log(user);

    this.set('apiKey', MealPlanner.ApiKey.create({
      accessToken: accessToken,
      user: user
    }));

    // this.set('apiKey', store.createRecord( 'ApiKey', {
    //   accessToken: accessToken,
    //   user: userId
    // }));

  },

  reset: function() {
    MealPlanner.__container__.lookup("route:application").transitionTo('sessions.new');
    Ember.run.sync();
    Ember.run.next(this, function() {
      // TODO Change to set accessToken & userId to null
      this.set('apiKey', null);
      $.ajaxSetup({
        headers: { 'Authorization': 'Bearer none'}
      });
    });
  },
  apiKeyObserver: function() {
    // TODO change to this.get('accessToken') && this.get('userId')
    if (Ember.isEmpty(this.get('apiKey'))) {
      $.removeCookie('access_token');
      $.removeCookie('auth_user');
    } else {
      $.cookie('access_token', this.get('apiKey.accessoken'));
      $.cookie('auth_user', this.get('apiKey.user'));
    }
  }.observes('apiKey')
});

DS.rejectinHandler = function(reason) {
  if (reason.status === 401) {
    MealPlanner.AuthManager.reset();
  }
  throw reason;
};


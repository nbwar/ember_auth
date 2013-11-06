var AuthManager = Ember.Object.extend({
  init: function() {
    var store = this.get('store');
    this._super();
    var accessToken = $.cookie('access_token');
    var authUserId = $.cookie('auth_user');
    if(!Ember.isEmpty(accessToken) && !Ember.isEmpty(authUserId)) {
      window.blah = this;
      this.authenticate(accessToken, authUserId, store);
    }
  },

  isAuthenticated: function() {
    return !Ember.isEmpty(this.get('apiKey.accessToken')) && !Ember.isEmpty(this.get('apiKey.user'))
  },

  authenticate: function(accessToken, userId, store) {
    $.ajaxSetup({
      headers: {'Authorization': 'Bearer ' + accessToken }
    });
    _this = this;
    var user = store.find('user', userId).then(function(response) {
      _this.set('apiKey', MealPlanner.ApiKey.create({
        accessToken: accessToken,
        user: response
      }));
    });


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
      $.cookie('access_token', this.get('apiKey.accessToken'));
      $.cookie('auth_user', this.get('apiKey.user.id'));
    }
  }.observes('apiKey')
});

DS.rejectinHandler = function(reason) {
  if (reason.status === 401) {
    MealPlanner.AuthManager.reset();
  }
  throw reason;
};


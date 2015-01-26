import Ember from 'ember';

export default Ember.Controller.extend({
	loginFailed: false,
  isProcessing: false,
  isSlowConnection: false,
  timeout: null,

  actions: {
    login: function() {
      this.setProperties({
        loginFailed: false,
        isProcessing: true
      });
      var that = this;
      this.set("timeout", setTimeout(this.slowConnection.bind(this), 5000));

      var request = $.post("/api/users/sign_in", {
        email_or_username: this.get("email_or_username"),
        password: this.get("password")
      });

      request.then(function(response) {
        that.reset();
        that.store.createRecord('user', response.user);
        that.get('cookie').setCookie('token', response.user.auth_code)
         .then(function() {
            that.transitionToRoute('dashboard');
          });
      }, function(error) {
        that.reset();
        that.set("loginFailed", true);
      });
    }
  },

  slowConnection: function() {
    this.set("isSlowConnection", true);
  },

  reset: function() {
    clearTimeout(this.get("timeout"));
    this.setProperties({
      isProcessing: false,
      isSlowConnection: false,
      password: ""
    });
  }
});

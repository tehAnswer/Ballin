import Ember from 'ember';
import NewSessionMixin from 'blln/mixins/new-session'

export default Ember.Controller.extend(NewSessionMixin, {
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
        newSession(response);
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

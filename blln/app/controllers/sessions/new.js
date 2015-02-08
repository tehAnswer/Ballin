import Ember from 'ember';
import NewSessionMixin from 'blln/mixins/new-session';


export default Ember.Controller.extend(NewSessionMixin, {
	loginFailed: false,
  isProcessing: false,
  isSlowConnection: false,
  timeout: null,

  actions: {
    login: function() {
      var that = this;
      that.beginLogin();
      that.login();
    }
  },

  record: function() {
    return {
        email_or_username: this.get("email_or_username"),
        password: this.get("password")
      };
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
  },

  beginLogin: function () {
    this.setProperties({
      loginFailed: false,
      isProcessing: true
    });
    this.set("timeout", setTimeout(this.slowConnection.bind(this), 5000));
  },

  isValid: Ember.computed('email_or_username', 'password', function () {
    return !Ember.isEmpty(this.get('email_or_username')) && !Ember.isEmpty(this.get('password'));
  }),

  isInvalid: Ember.computed.not('isValid')
});

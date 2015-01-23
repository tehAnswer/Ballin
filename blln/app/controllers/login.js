import Ember from 'ember';

export default Ember.Controller.extend({
	loginFailed: true,
  isProcessing: false,
  isSlowConnection: true,
  timeout: null,

  login: function() {
  	alert("1");
    this.setProperties({
      loginFailed: false,
      isProcessing: true
    });

    this.set("timeout", setTimeout(this.slowConnection.bind(this), 5000));

    //var request = $.post("/sign_in", this.getProperties("email", "password"));
    //request.then(this.success.bind(this), this.failure.bind(this));
    return false;
  },

  success: function() {
    this.reset();
    alert("hell, yeah!");
    document.location = "/welcome";
  },

  failure: function() {
    this.reset();
    alert("fuckkk!");
    this.set("loginFailed", true);
  },

  slowConnection: function() {
    this.set("isSlowConnection", true);
  },

  reset: function() {
    clearTimeout(this.get("timeout"));
    this.setProperties({
      isProcessing: false,
      isSlowConnection: false
    });
  }
});

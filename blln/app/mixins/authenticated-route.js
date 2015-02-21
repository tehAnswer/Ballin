import Ember from 'ember';

export default Ember.Mixin.create({
  beforeModel: function() {
    var token = this.get('cookie').getCookie('token');
    if(token == null) {
      this.transitionTo('sessions.new');
    }
  }
});
import Ember from 'ember';
import NewSessionMixin from 'blln/mixins/new-session';

export default Ember.Route.extend(NewSessionMixin, {

  beforeModel: function() {
    var token = this.get('cookie').getCookie('token');
    if(token == null) {
      this.transitionTo('sessions.new');
    }  
  },
  model: function() {
    return this.whoiam();
  }
});
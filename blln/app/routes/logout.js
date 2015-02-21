import Ember from 'ember';


export default Ember.Route.extend({
  activate: function() {
    this.get('cookie').removeCookie('token');
    this.transitionTo('sessions.new');
  }
});
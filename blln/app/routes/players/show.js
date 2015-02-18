import Ember from 'ember';

export default Ember.Route.extend({

  model: function(params) {
    var user = this.store.filter('user', {})
    return user;
  }
});

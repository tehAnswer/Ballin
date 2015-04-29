import Ember from 'ember';
export default Ember.Route.extend({
  model: function() {
    return this.store.createRecord('user');
  },
  deactivate: function() {
  	var model = this.modelFor('users/sign-up');
  	if (model.get('isNew')) {
  		model.destroyRecord();
  	}
    this.controllerFor('users/sign_up').set('failed', false);
  }
});
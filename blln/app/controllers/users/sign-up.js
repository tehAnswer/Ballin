import Ember from 'ember';
import NewSessionMixin from 'blln/mixins/new-session';

export default Ember.Controller.extend(NewSessionMixin, {
	actions: {
		signUp: function () {
      this.register();
    }
	},

	record: function () {
		return {
			login: {
				username: this.get('model.username'),
				password: this.get('model.password'),
				email: this.get('model.email')
			}
		};
	},

	isValid: Ember.computed(
		'model.email',
		'model.username',
		'model.password',
		'model.repassword', 
		function() {
			return !Ember.isEmpty(this.get('model.email')) && !Ember.isEmpty(this.get('model.username')) && !Ember.isEmpty(this.get('model.password')) && !Ember.isEmpty(this.get('model.repassword')) && this.get('model.password') === this.get('model.repassword') && this.get('model.password').length >= 8 && this.get('model.email').indexOf("@") > 0;
		}),

	isInvalid: Ember.computed.not('isValid')
});
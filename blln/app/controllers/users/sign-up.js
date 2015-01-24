import Ember from 'ember';

export default Ember.Controller.extend({
	actions: {
		signUp: function () {
			alert(this.get('isValid'));
			if(this.get('isValid')) {
				var that = this;
				var request = $.post("/api/users", {
					login: {
						username: this.get('model.username'),
						password: this.get('model.password'),
						email: this.get('model.email')
					}
				});

				request.then(function(response) {
					alert(response.user);
					that.store.createRecord('user', response.user);
					that.transitionTo('dashboard');
				},
				function(error) {
					that.set('errorMessage', error);
				});
			}
			else {
				that.set('errorMessage', "Fill the form correctly, please.");
			}
		}
	},

	isValid: Ember.computed(
		'model.email',
		'model.username',
		'model.password',
		'model.repassword', 
		function() {
			return !Ember.isEmpty(this.get('model.email')) && !Ember.isEmpty(this.get('model.username')) && !Ember.isEmpty(this.get('model.password')) && !Ember.isEmpty(this.get('model.repassword')) && this.get('model.password') === this.get('model.repassword') && this.get('model.password').length >= 8 && this.get('model.email').indexOf("@") > 0;
		}
	)
});
import Ember from "ember";
import ajax from 'ic-ajax';



export default Ember.Mixin.create({
	newSession: function (response) {
		var that = this;
		that.store.createRecord('user', response.user);
		that.get('cookie').setCookie('token', response.user.auth_code).then(function() {
			if (response.user.team_id !== -1) {
				that.transitionToRoute('dashboard');
			} else {
				that.transitionToRoute('fantastic_teams.new');
			}
		});
	}, 
	submitAction: function (isLogin, path) {
		var that = this;
		if(that.get('isValid')) {
			var request = ajax({ url: path, type: "POST", data: that.record() });
			request.then(function(response) {
				if(isLogin)
					that.reset();
				that.newSession(response);
			}, function(error) {
				that.set('errorMessage', error);
				that.set('failed', true);
			});
		} else {
			that.setErrorMessage("Fill the form correctly, please.");
		}
	},

	login: function() {
		this.submitAction(true, "/api/users/sign_in");
	},

	register: function() {
		this.submitAction(false, "/api/users");
	}
});
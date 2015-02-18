import Ember from "ember";
import ajax from 'ic-ajax';



export default Ember.Mixin.create({
	newSession: function (response) {
		var that = this;

		that.store.pushPayload('user', response);

		that.get('cookie').setCookie('token', response.user.auth_token).then(function() {
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
			that.submitActionWithCallbacks(path, that.record(), that.loginHook(isLogin, that), that.failHook(that));
		} else {
			that.setErrorMessage("Fill the form correctly, please.");
		}
	},

	submitActionWithCallbacks: function (path, record, success, failure) {
		var request = ajax({ url: path, type: "POST", data: record });
		request.then(success, failure);
	},

	loginHook: function(isLogin, that) {
		return function(response) {
				if(isLogin)
					that.reset();
				that.newSession(response);
			};
	},

	failHook: function(that) {
		return function(error) {
				that.set('errorMessage', error);
				that.set('failed', true);
			};
	},

	login: function() {
		this.submitAction(true, "/api/users/sign_in");
	},

	register: function() {
		this.submitAction(false, "/api/users");
	},

	whoiam: function () {
		var that = this;
		var token = this.get('cookie').getCookie('token');
		var request = ajax({ url: "/me", type: "GET", headers: { dagger: token } });
		return request.then(function(response) {
			that.store.pushPayload('user', response);
			console.log(response);
			return that.store.find('user', response.user.id);
		}, function(error) {
			return null;
		})
	}
});
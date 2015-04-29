import Ember from "ember";
import ajax from 'ic-ajax';



export default Ember.Mixin.create({
	newSession: function (response) {
		var that = this;

		that.store.pushPayload('user', response);
		var user = response.user;
		that.get('cookie').setCookie('token', user.authCode).then(function() {
			if (user.team.id !== "-1") {
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
				if(isLogin) {
					that.reset();
				}
				that.newSession(response);
			};
	},

	failHook: function(that) {
		return function(error) {
				//that.set('errorMessage', error);
				that.set('loginFailed', true);
			};
	},

	login: function() {
		this.submitAction(true, "/api/users/sign_in");
	},

	register: function() {
		this.submitAction(false, "/api/users");
	},

	getRequest: function (path, entity) {
		var that = this;
		var token = this.get('cookie').getCookie('token');
		var request = ajax({ url: path, type: "GET", headers: { dagger: token } });
		var user = request.then(function(response) {
			that.store.pushPayload(entity, response);
			var user = that.store.find(entity, response[entity].id);
			return user;
		}, function(error) {
			console.log(error);

			return null;
		});
		
		return user;
	},

	whoiam: function () {
		return this.getRequest('/me', 'user');
	},

	myTeam: function() {
		return this.getRequest('/my_team', 'fantastic_team');
	},

	myLeague: function() {
		return this.getRequest('/my_league', 'league');
	}
});
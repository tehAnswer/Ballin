import Ember from "ember";

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
	}
});
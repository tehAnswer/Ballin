import Ember from 'ember';
import ajax from 'ic-ajax';

export default Ember.Controller.extend({

	actions: {
		createTeam: function () {
			var that = this;
			var request = ajax({
				url:"/api/fantastic_teams",
				type:"POST",
				headers: { 
					"Accept" : "application/json; charset=utf-8",
					"dagger" : that.get('cookie').getCookie('token')
				},
				data: that.record(),
				dataType:"json"
			});

			request.then(function(response) {
				that.set('isLoading', false);
				that.store.createRecord("fantastic_team", response.fantastic_team);
				that.transitionToRoute('dashboard');
			}, function(error) {
				that.set('isLoading', false);
				alert("TODO. Something goes wrong.");
			}); 
		}
	},

	isValid: Ember.computed(
		'name',
		'abbreviation',
		'hood',
		'headline',
		'divisionId', 
		function() {
			return !Ember.isEmpty(this.get('name')) && !Ember.isEmpty(this.get('abbreviation')) && !Ember.isEmpty(this.get('hood')) && !Ember.isEmpty(this.get('divisionId'));
		}
	),

	isInvalid: Ember.computed.not('isValid'),
	record: function() {
		return {
			fantastic_team: {
				"name": this.get('name'),
				"abbreviation": this.get('abbreviation'),
				"hood": this.get('hood'),
				"division_id": this.get('divisionId')
			}
		};
	},
	isLoading: false,
	isDisabled: Ember.computed.or('isInvalid', 'isLoading')
});
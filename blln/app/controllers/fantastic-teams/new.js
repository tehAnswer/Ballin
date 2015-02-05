import Ember from 'ember';

export default Ember.Controller.extend({

	actions: {
		createTeam: function () {
			var that = this;

			var request = $.post("/api/fantastic_teams", {
				name: this.get("name"),
				abbreviation: this.get("abbreviation"),
				hood: this.get("hood"),
				division: this.get("division.id")
			})
		}
	}
});
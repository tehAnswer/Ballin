import Ember from 'ember';
import AuthenticatedRoute from 'blln/mixins/authenticated-route';
import NewSessionMixin from 'blln/mixins/new-session';

export default Ember.Route.extend(AuthenticatedRoute, NewSessionMixin, {
  model: function() {
    var user = this.modelFor('dashboard');
    return user == null ? this.myTeam() : user.team;
  },

  afterModel: function () {
    var team = this.modelFor('my_team');
    Ember.RSVP.hash({lineup: team.rotation}).then(function(values){
      console.log("Fetched lineup");
    });
  }
});
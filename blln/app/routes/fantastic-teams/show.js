import Ember from 'ember';

export default Ember.Route.extend({

  model: function(params) {
    var team = this.store.find('fantastic-team', params.fantastic_team_id);
    return team;
  }
});
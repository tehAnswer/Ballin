import Ember from 'ember';

export default Ember.Route.extend({

  model: function(params) {
    var league = this.store.find('league', params.league_id);
    return league;
  }
});

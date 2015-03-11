import Ember from 'ember';

export default Ember.Route.extend({

  model: function(params) {
    var game = this.store.find('game', params.game_id);
    return game;
  }
});
import Ember from 'ember';

export default Ember.Component.extend({
  player: null,
  team: null,
  currentPosition: function() {
    var rotation = this.get('team').get('rotation');
    var player = this.get('player');
    alert(player.get('name'));
    player.canPlay().forEach(function(position) {
      if (rotation[position] == player.get('id')) {
        return position;
      }
    });
    return "NADA";
  }.property('player', 'team')
});
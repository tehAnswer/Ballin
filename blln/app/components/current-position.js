import Ember from 'ember';

export default Ember.Component.extend({
  contract: null,
  lineup: null,
  currentPosition: Ember.computed('lineup', function() {
    var contract = this.get('contract');
    var team = contract.get('team');
    var rotation = team.get('rotation');
    var player = contract.get('player');
    var lineup = rotation.get('playersId');
    var ret = "BENCH";
    player.get('canPlay').forEach(function (position) {
      if(lineup[position] == player.get('id')) {
        ret = position;
      }
    });
    return ret;
  }),
  spanClass: function() {
    if (this.get('currentPosition') == "BENCH") {
      return "label label-default";
    } else {
      return "label label-success";
    }
  }.property('currentPosition')
});
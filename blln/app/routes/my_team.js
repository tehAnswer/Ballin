import Ember from 'ember';
import AuthenticatedRoute from 'blln/mixins/authenticated-route';
import NewSessionMixin from 'blln/mixins/new-session';
import ajax from 'ic-ajax';

export default Ember.Route.extend(AuthenticatedRoute, NewSessionMixin, {
  model: function() {
    return this.myTeam();
  },

  afterModel: function () {
    var team = this.modelFor('my_team');
    Ember.RSVP.hash({lineup: team.rotation}).then(function(values){
      console.log("Fetched lineup");
    });
  },
  actions: {
    setAs: function(position, player) {
      var that = this;
      var record = { rotation : { } }
      record["rotation"][position] = player.get('id');
      var rotation = this.modelFor('my_team').get("rotation");
      var request = ajax({
        url: "/api/rotations/" + rotation.get('id'),
        type:"PATCH",
        headers: { 
          "Accept" : "application/json; charset=utf-8",
          "dagger" : that.get('cookie').getCookie('token')
        },
        data: record,
        dataType:"json"
      });

      request.then(function() {
        var playersId = rotation.get('playersId');
        playersId[position] = player.get('id');
        rotation.set('playersId', playersId);
        that.refresh();
      }, function(error) {
        alert("TODO. Something goes wrong.");
      }); 
    }
  }
});
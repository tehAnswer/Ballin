import Ember from 'ember';
import AuthenticatedRoute from 'blln/mixins/authenticated-route';
import NewSessionMixin from 'blln/mixins/new-session';
import ajax from 'ic-ajax';

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
  },
  actions: {
    setAs: function(position, player) {
      var that = this;
      var record = { rotation : { } }
      record["rotation"][position] = player.get('id');
      var rotationId = this.modelFor('my_team').get("rotation").get('id');
      var request = ajax({
        url: "/api/rotations/" + rotationId,
        type:"PATCH",
        headers: { 
          "Accept" : "application/json; charset=utf-8",
          "dagger" : that.get('cookie').getCookie('token')
        },
        data: record,
        dataType:"json"
      });
      request.then(function() {
        var rotation = that.store.find('rotation', rotationId);
        alert(rotation);
        var playersId = rotation.get('playersId');
        playersId[position] = player.get('id');
        rotation.set('playersId', playersId);
        rotation.save();
      }, function(error) {
        alert("TODO. Something goes wrong.");
      }); 
    }
  }
});
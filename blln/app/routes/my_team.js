import Ember from 'ember';
import AuthenticatedRoute from 'blln/mixins/authenticated-route';
import NewSessionMixin from 'blln/mixins/new-session';
import RequestMixin from 'blln/mixins/request';


export default Ember.Route.extend(AuthenticatedRoute, NewSessionMixin, RequestMixin, {
  model: function() {
    return this.myTeam();
  },

  afterModel: function () {
    var team = this.modelFor('my_team');
    Ember.RSVP.hash({lineup: team.rotation}).then(function(values) {
      
      console.log("Fetched lineup (" + values + ")");
    });
  },
  
  changeHook: function (rotation, position, player) {
    var that = this;
    return function () {
      var playersId = rotation.get('playersId');
      playersId[position] = player.get('id');
      rotation.set('playersId', playersId);
      that.refresh();
    };
  },

  failureHook: function() {
    return function () {
      alert("Something goes wrong.");
    };
  },

  record: function(position, player) {
    var record = { rotation : { } };
    record["rotation"][position] = player.get('id');
    return record;
  },

  requestPath: function(path, item) {
    return path + item.get('id');
  },

  actions: {
    setAs: function(position, player) {
      var rotation = this.modelFor('my_team').get("rotation");
      var path = this.requestPath("/api/rotations/", rotation);
      var record = this.record(position, player);
      var successHook = this.changeHook(rotation, position, player);
      var failureHook = this.failureHook();

      this.makeRequest(path, "PATCH", record, successHook, failureHook);
    },

    waive: function(contract) {
      contract.destroyRecord();
    }
  }
});
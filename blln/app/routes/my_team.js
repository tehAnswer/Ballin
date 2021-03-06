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

  getKeyForValue: function (obj, value) {
    for (var name in obj) {
      if (obj[name] - value === 0) {
        return name;
      }
    }
    return null;
  },
  
  changeHook: function (rotation, position, player) {
    var that = this;
    return function () {
      var playersId = rotation.get('playersId');
      var previousPosition = that.getKeyForValue(playersId, player.get('id'));
      if (previousPosition !== null) {
        playersId[previousPosition] = -1;
      }
      playersId[position] = player.get('id');
      rotation.set('playersId', playersId);
      that.refresh();
    };
  },

  auctionHook: function () {
    var that = this;
    return function () {
      that.controllerFor('my-team').set('errorMessage', false);
      that.controllerFor('my-team').set('auctionCreated', true);
    };
  },

  failureHook: function() {
    var that = this;
    return function () {
      that.controllerFor('my-team').set('auctionCreated', false);
      that.controllerFor('my-team').set('errorMessage', true);
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
    },

    createAuction: function(contract) {
      var leagueId = contract.get("league.id");
      var playerId = contract.get("player.id");
      var path = "/api/leagues/" + leagueId + "/auctions";
      var record = { auction : { } };
      record["auction"]["player_id"] = playerId;

      this.makeRequest(path, "POST", record, this.auctionHook(), this.failureHook());
    }
  },

  deactivate: function() {
    this.controllerFor('my-team').set('auctionCreated', false);
    this.controllerFor('my-team').set('errorMessage', false);
  }
});
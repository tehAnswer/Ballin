import Ember from 'ember';
import RequestMixin from 'blln/mixins/request';
import NewSessionMixin from 'blln/mixins/new-session';


export default Ember.Controller.extend(RequestMixin, NewSessionMixin, {
  afterModel: function () {
    var team = this.myTeam();
    this.set("team", team);
    return team;
  },
  model: function () {
    return this.myLeague();
  },
  isInvalid: Ember.computed('auction', 'salary', function() {
    var salary = this.get('salary') || 0;
    var auction = this.get('auction');
    if (auction == null) {
      return true;
    }
    var maxBid = auction.get('hasBids') ? auction.get('maxBid') : 0;
    return maxBid > (salary - 1000);
  }),
  record: function () {
    var record = { bid : { } };
    record["bid"]["salary"] = this.get("salary");
    record["bid"]["auction_id"] = this.get("auction.id");
    return record;
  }, 
  successHook: function(bid) {
    var that = this;
    return function (response) {
      that.store.pushPayload('bid', response);
      that.set('isSuccess', true);
    };
  },
  failureHook: function() {
    var that = this;
    return function () {
      that.set('isFailed', true);
    };
  },
  reset: function() {
    this.set('isFailed', false);
    this.set('isSuccess', false);
  },
  actions: {
    setAuction: function(auction) {
      this.set('auction', auction);
    },
    createBid: function() {
     var path = "/api/bids";
     this.reset();
     var successHook = this.successHook();
     var failureHook = this.failureHook();

     this.makeRequest(path, "POST", this.record(), successHook, failureHook);
    }
  }
});
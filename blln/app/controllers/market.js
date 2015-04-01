import Ember from 'ember';


export default Ember.Controller.extend({
  isInvalid: Ember.computed('auction', 'salary', function() {
    var salary = this.get('salary') || 0;
    var auction = this.get('auction');
    if (auction == null)
      return true;
    var maxBid = auction.get('hasBids') ? auction.get('maxBid') : 0;
    return maxBid > (salary - 1000);
  }),
  actions: {
    setAuction: function(auction) {
      this.set('auction', auction);
    }
  }
});
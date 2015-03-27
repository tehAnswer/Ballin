import DS from 'ember-data';
import Ember from 'ember';

export default DS.Model.extend({
  bids: DS.hasMany("bid", { async: true }),
  endTime: DS.attr(),
  player: DS.belongsTo("player", { async: true }),
  bidSalaries: Ember.computed.mapBy("bids", "salary"),
  maxBid: Ember.computed.max("bidSalaries"),
  hasBid: Ember.computed.empty('bidSalaries')
});
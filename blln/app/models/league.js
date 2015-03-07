import DS from 'ember-data';

export default DS.Model.extend({
  name: DS.attr("string"),
  numberOfTeams: DS.attr("number"),
  conferences: DS.hasMany("conference", {async: true}),
  sharpId: function () {
  	return "#" + this.get('id');
  }.property('sharpId'),
  contracts: DS.hasMany("contract", { async: true })
});

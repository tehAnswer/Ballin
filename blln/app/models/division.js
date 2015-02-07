import DS from 'ember-data';

export default DS.Model.extend({
  name: DS.attr("string"),
  teams: DS.hasMany("fantasticTeam"),
  conference: DS.belongsTo("conference"),
  hasFreeSpace: Ember.computed('teams', function() {
  	return this.get('teams.length') < 5;
  }),
  isFull: Ember.computed.not('hasFreeSpace')
});

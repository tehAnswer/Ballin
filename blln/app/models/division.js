import Ember from 'ember';
import DS from 'ember-data';

export default DS.Model.extend({
  name: DS.attr("string"),
  teams: DS.hasMany("fantasticTeam", { async: true }),
  conference: DS.belongsTo("conference", { async: true }),
  hasFreeSpace: Ember.computed('teams', function() {
  	return this.get('teams.length') < 5;
  }),
  isFull: Ember.computed.not('hasFreeSpace'),
  sortedProperties: ['score:desc'],
  sortedTeams: Ember.computed.sort('teams', 'sortedProperties')
});

import DS from 'ember-data';

export default DS.Model.extend({
  name: DS.attr("string"),
  number_of_teams: DS.attr("number"),
  eastern_conference: DS.belongsTo("conference"),
  western_conference: DS.belongsTo("conference")
});

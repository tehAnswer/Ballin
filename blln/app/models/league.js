import DS from 'ember-data';

export default DS.Model.extend({
  name: DS.attr("string"),
  numberOfTeams: DS.attr("number"),
  easternConference: DS.belongsTo("conference"),
  westernConference: DS.belongsTo("conference")
});

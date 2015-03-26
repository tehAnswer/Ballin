import DS from 'ember-data';

export default DS.Model.extend({
  salary: DS.attr("number"),
  team: DS.belongsTo("fantastic-team", { async: true }),
  auction: DS.belongsTo("auction", { async: true })
});
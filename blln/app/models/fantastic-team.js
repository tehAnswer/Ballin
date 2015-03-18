import DS from 'ember-data';

export default DS.Model.extend({
  name: DS.attr("string"),
  abbreviation: DS.attr("string"),
  hood: DS.attr("string"),
  headline: DS.attr("string"),
  score: DS.attr(),
  user: DS.belongsTo("user", { async: true }),
  division: DS.belongsTo("division", { async: true }),
  contracts: DS.hasMany("contracts", { async: true }),
  rotation: DS.belongsTo("rotation", { async: true })
});

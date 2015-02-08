import DS from 'ember-data';

export default DS.Model.extend({
  name: DS.attr("string"),
  abbreviation: DS.attr("string"),
  hood: DS.attr("string"),
  headline: DS.attr("string"),
  user: DS.belongsTo("user"),
  division: DS.belongsTo("division")
});

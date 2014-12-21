import DS from 'ember-data';

export default DS.Model.extend({
  name: DS.attr("string"),
  division_one: DS.belongsTo("division"),
  division_two: DS.belongsTo("division"),
  division_three: DS.belongsTo("division"),
  league: DS.belongsTo("league")

});

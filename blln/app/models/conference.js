import DS from 'ember-data';

export default DS.Model.extend({
  name: DS.attr("string"),
  //divisionOne: DS.belongsTo("division"),
  //divisionTwo: DS.belongsTo("division"),
  //divisionThree: DS.belongsTo("division"),
  league: DS.belongsTo("league")

});

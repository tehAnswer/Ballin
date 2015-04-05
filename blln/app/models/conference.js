import DS from 'ember-data';

export default DS.Model.extend({
  name: DS.attr("string"),
  divisions: DS.hasMany("division", {async: true}),
  league: DS.belongsTo("league", { async: true })
});

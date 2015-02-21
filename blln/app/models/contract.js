import DS from 'ember-data';

export default DS.Model.extend({
  salary: DS.attr(),
  player: DS.hasMany("player"),
  league: DS.belongsTo("league"),
  team: DS.belongsTo("fantastic-team", { async: true }),
  contracts: DS.hasMany("contracts", { async: true })

});

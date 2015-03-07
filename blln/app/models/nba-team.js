import DS from 'ember-data';

export default DS.Model.extend({
  name: DS.attr("string"),
  abbreviation: DS.attr("string"),
  city: DS.attr("string"),
  state: DS.attr("string"),
  teamId: DS.attr("string"),
  players: DS.hasMany("player", { async: true }),
  division: DS.attr("string"),
  conference: DS.attr("string"),
  games: DS.hasMany("game", { async: true })
});
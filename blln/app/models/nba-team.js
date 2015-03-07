import Ember from 'ember';
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
  awayGames: DS.hasMany("game", { async: true, inverse: "awayTeam" }),
  homeGames: DS.hasMany("game", { async: true, inverse: "homeTeam" }),
  nextGameid: DS.attr("number"),
  nextGame : Ember.computed('nextGameid', function () {
    return this.store.find('game', this.get("nextGameid"));
  })
});
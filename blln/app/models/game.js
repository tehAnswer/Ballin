import DS from 'ember-data';

export default DS.Model.extend({
  gameId: DS.attr("string"),
  awayScore: DS.attr("number"),
  homeScore: DS.attr("number"),
  awayTeam: DS.belongsTo('nba-team', { async: true }),
  homeTeam: DS.belongsTo('nba-team', { async: true }),
  status: DS.attr("string"),
  awayBoxScores: DS.hasMany('box-score', { async: true }),
  homeBoxScores: DS.hasMany('box-score', { async: true }),
  seasonType: DS.attr("string"),
  startDateTime: DS.attr(),
  dateFormatted: DS.attr("string")
});
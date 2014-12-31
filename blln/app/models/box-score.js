import DS from 'ember-data';

export default DS.Model.extend({
  points: DS.attr("number"),
  assists: DS.attr("number"),
  steals: DS.attr("number"),
  blocks: DS.attr("number"),
  ofr: DS.attr("number"),
  defr: DS.attr("number"),
  fga: DS.attr("number"),
  fgm: DS.attr("number"),
  lsa: DS.attr("number"),
  lsm: DS.attr("number"),
  fta: DS.attr("number"),
  ftm: DS.attr("number"),
  turnovers: DS.attr("number"),
  isStarter: DS.attr("boolean"),
  minutes: DS.attr("number"),
  faults: DS.attr("number"),
  finalScore: DS.attr("number"),
  player: DS.belongsTo("player", {async: true})
});
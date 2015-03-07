import DS from 'ember-data';
import PositionFormat from 'blln/mixins/positions';
import PlayerCharts from 'blln/mixins/player-charts';

export default DS.Model.extend(PositionFormat, PlayerCharts, {
  name: DS.attr('string'),
  heightFormatted: DS.attr('string'),
  heightCm: DS.attr('number'),
  weightLb: DS.attr('number'),
  weightKg: DS.attr('string'),
  birthplace: DS.attr('string'),
  birthdate: DS.attr('string'),
  position: DS.attr('string'),
  number: DS.attr('string'),
  stats: DS.attr(),
  nbaTeam: DS.belongsTo('nbaTeam', { async: true }),
  avgRebounds: function () {
    return (this.get('stats.defr') + this.get('stats.ofr')).toFixed(2);
  }.property('stats'),
  boxScores: DS.hasMany("box-score", { async: true }),
  contracts: DS.hasMany("contract", { async: true }),
  sharpId: function () {
    return "#" + this.get('id');
  }.property('sharpId'),
  positionLong: function () {
   return this.positionToWord(this.get('position'));
  }.property('position'),
  canPlay: function () {
    return this.positionsCanPlay(this.get('position'));
  }.property('position')
});
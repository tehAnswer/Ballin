import DS from 'ember-data';

export default DS.Model.extend({
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
  avgRebounds: function() {
    return (this.get('stats.defr') + this.get('stats.ofr')).toFixed(2);
  }.property('stats'),
  boxScores: DS.hasMany("box-score", { async: true }),
  contracts: DS.hasMany("contract", { async: true }),
  positions: function () {
    return ["PG", "G"];
  }.property('positions'),
  sharpId: function () {
    return "#" + this.get('id');
  }.property('sharpId'),
  positionLong: function() {
    var position = this.get('position');
    if (position == 'PG') {
      return "Point Guard";
    } else if (position == 'SG') {
      return "Shooting Guard";
    } else if (position == 'SF') {
      return "Small Forward";
    } else if (position == 'PF') {
      return "Power Forward";
    } else if (position == 'C') {
      return "Center";
    } else if (position == 'G') {
      return "Guard";
    } else {
      return "Forward";
    }
  }.property('positionLong')
  
});
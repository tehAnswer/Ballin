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
  contracts: DS.hasMany("contract", { async: true })
  
});
import DS from 'ember-data';

export default DS.Model.extend({
  name: DS.attr('string'),
  height_formatted: DS.attr('string'),
  height_cm: DS.attr('number'),
  weight_lb: DS.attr('number'),
  weight_kg: DS.attr('string'),
  birthplace: DS.attr('string'),
  birthdate: DS.attr('string'),
  position: DS.attr('string'),
  number: DS.attr('string'),
  faults: DS.attr('number'),
  stats: DS.attr(),
  avg_rebounds: function() {
    return (this.get('stats.defr') + this.get('stats.ofr')).toFixed(2);
  }.property('stats')
  
});
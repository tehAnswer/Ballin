import DS from 'ember-data';
import PositionFormat from 'blln/mixins/positions'

export default DS.Model.extend(PositionFormat, {
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
  }.property('position'),
  chartData: function() {
    var stats = this.get('stats');
    var that = this;

    return {
      labels: ['Points', 'Assits', 'Steals', 'Blocks', 'Offensive rebounds', 'Defensive rebounds'],
      datasets: [
        {
          label: that.get('name') + " avarage points made per stat",
          fillColor: "rgba(220,220,220,0.2)",
          strokeColor: "rgba(220,220,220,1)",
          pointColor: "rgba(220,220,220,1)",
          pointStrokeColor: "#fff",
          pointHighlightFill: "#fff",
          pointHighlightStroke: "rgba(220,220,220,1)",
          data: [stats.points, stats.assits * 1.75, stats.steals * 3, stats.blocks * 2, stats.ofr * 1.5, stats.defr * 1.25]
        }
      ]
    };
  }.property('stats') 
});
import Ember from 'ember';

export default Ember.Mixin.create({
  chartData: function () {
    var stats = this.get('stats');
    var that = this;

    return {
      labels: ['Points', 'Assists', 'Steals', 'Blocks', 'Of. rebounds', 'Def. rebounds'],
      datasets: [
        {
          label: that.get('name') + " avarage points made per stat",
          fillColor: "rgba(255,105,180,0.2)",
          strokeColor: "rgba(255,105,180)",
          pointColor: "rgba(255,105,180)",
          pointStrokeColor: "rgba(255,105,180)",
          pointHighlightFill: "rgba(255,105,180)",
          pointHighlightStroke: "rgba(220,220,220,1)",
          data: [stats.points, stats.assits * 1.75, stats.steals * 3, stats.blocks * 2, stats.ofr * 1.5, stats.defr * 1.25]
        }
      ]
    };
  }.property('stats'),

  chartPlayerOptions: function() {
    return {
       scaleShowLine : true,
       angleShowLineOut : true,
       animation: false,
       angleLineColor : "rgba(255,255,255,1)",
       scaleLineColor: "rgba(255,255,255,1)",
       scaleFontSize: 12,
       scaleFontStyle: "normal",
       scaleFontColor: "rgba(255,255,255,1)",

    };
  }.property('stats')

});
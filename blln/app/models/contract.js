import DS from 'ember-data';

export default DS.Model.extend({
  salary: DS.attr(),
  player: DS.belongsTo("player", { async: true }),
  league: DS.belongsTo("league", { async: true }),
  team: DS.belongsTo("fantastic-team", { async: true }),
  sharpId: function () {
    return "#" + this.get('id');
  }.property('sharpId')

});

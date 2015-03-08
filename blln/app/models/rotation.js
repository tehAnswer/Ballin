import DS from 'ember-data';

export default DS.Model.extend({
  playersId: DS.attr(),
  team: DS.belongsTo('fantastic-team', { async: true })
});
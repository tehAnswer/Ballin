import DS from 'ember-data';

export default DS.Model.extend({
  name: DS.attr("string"),
  number_of_teams: DS.attr("number")


});

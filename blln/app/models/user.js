import DS from 'ember-data';

export default DS.Model.extend({
  username: DS.attr("string"),
  email: DS.attr("string"),
  password: DS.attr("string"),
  repassword: DS.attr("string"),
  token: DS.attr("string"),
  fantasticTeam: DS.belongsTo("fantastic-team", {async: true})
});

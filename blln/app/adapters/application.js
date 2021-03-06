import DS from 'ember-data';

export default DS.ActiveModelAdapter.extend({
  namespace: 'api', 
  coalesceFindRequests: true,
  headers: function() {
  	var token = this.get('cookie').getCookie('token') || "";
  	return { "dagger": token };
  }.property().volatile()
});

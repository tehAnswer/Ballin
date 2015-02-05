import Ember from 'ember';

export default Ember.Route.extend({
	model: function() {
		var boxScores = this.modelFor('players/show').get('boxScores');
		return boxScores;
  }
});

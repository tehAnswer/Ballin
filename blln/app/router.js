import Ember from 'ember';
import config from './config/environment';

var Router = Ember.Router.extend({
  location: config.locationType
});

Router.map(function() {
  this.resource('players', function() {
    this.route('show', { path: '/:player_id' }, function() {

    	//this.route('box-scores');
    	this.resource('box-scores', function() { });
    });
   });
  this.resource('leagues', function() {
    this.route('show', { path: '/:league_id' });
  });
});

export default Router;

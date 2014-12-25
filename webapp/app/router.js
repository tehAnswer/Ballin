import Ember from 'ember';
import config from './config/environment';

var Router = Ember.Router.extend({
  location: config.locationType
});

Router.map(function() {
  this.resource('players', function() {
    this.resource('players.show', { path: '/:player_id' });
   });
  this.route('contact');
  this.resource('leagues', function() {
    this.resource('leagues.show', { path: '/:league_id' });
  });
});

export default Router;

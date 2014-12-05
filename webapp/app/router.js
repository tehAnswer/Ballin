import Ember from 'ember';
import config from './config/environment';

var Router = Ember.Router.extend({
  location: config.locationType
});

Router.map(function() {
  this.resource('players', function() {
    this.resource('player', { path: '/:player_id' });
   });
  this.route('contact');
});

export default Router;

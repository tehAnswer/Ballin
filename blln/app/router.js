import Ember from 'ember';
import config from './config/environment';

var Router = Ember.Router.extend({
  location: config.locationType
});

Router.map(function() {
  this.resource('players', function() {
    this.route('show', { path: '/:player_id' }, function() {
    	this.resource('box-scores', function() { });
    });
   });
  
  this.resource('sessions', function() {
    this.route('new');
  });

  this.route('dashboard');
  this.route('contact');
  this.route('learn_more');
  this.route('my_team');
  this.route('logout');
  
  this.resource('fantastic_teams', function() {
    this.route('show', { path: '/:fantastic_team' });
    this.route('new');
   });

  this.resource('users', function () {
    this.route('sign_up');
    this.route('show', { path: '/:user_id' });
  });

  this.resource('games', function () {
    this.route('show', { path: '/:games_id' }, function () {
      this.resource('box-scores', function() { });
    });
  });

  this.resource('league', function() {
    this.route('market');
    this.route('standings');
  });

});

export default Router;

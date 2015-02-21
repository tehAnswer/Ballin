import Ember from 'ember';
import NewSessionMixin from 'blln/mixins/new-session';
import AuthenticatedRoute from 'blln/mixins/authenticated-route';

export default Ember.Route.extend(NewSessionMixin, AuthenticatedRoute, {
  model: function() {
    var user = this.whoiam();
    return user;
  }
});
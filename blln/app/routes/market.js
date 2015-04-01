import Ember from 'ember';
import AuthenticatedRoute from 'blln/mixins/authenticated-route';
import NewSessionMixin from 'blln/mixins/new-session';


export default Ember.Route.extend(AuthenticatedRoute, NewSessionMixin, {
  model: function () {
    return this.myLeague();
  }
});
import Ember from 'ember';
import AuthenticatedRoute from 'blln/mixins/authenticated-route';
import NewSessionMixin from 'blln/mixins/new-session';
import RequestMixin from 'blln/mixins/request';


export default Ember.Route.extend(AuthenticatedRoute, RequestMixin, {
  model: function () {
    return this.makeRequest('my_league', 'GET', null, null, null);
  }
});
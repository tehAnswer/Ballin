import Ember from 'ember';
import RouteMixin from 'ember-cli-pagination/remote/route-mixin';

export default Ember.Route.extend(RouteMixin, {

  perPage: 15,
  model: function(params) {
    return this.findPaged('league',params);
  }
});

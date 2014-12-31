import Ember from 'ember';
import SortMixin from 'blln/mixins/sort';

export default Ember.ArrayController.extend(SortMixin, {
  // setup our query params
  queryParams: ["page"],

  // binding the property on the paged array 
  // to the query params on the controller
  pageBinding: "content.page",
  perPageBinding: "content.perPage",
  totalPagesBinding: "content.totalPages",

  // set default values, can cause problems if left out
  // if value matches default, it won't display in the URL
  page: 1,
  perPage: 15
});
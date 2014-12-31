import Ember from 'ember';
import SortMixin from 'blln/mixins/sort';

module('SortMixin');

// Replace this with your real tests.
test('it works', function() {
  var SortObject = Ember.Object.extend(SortMixin);
  var subject = SortObject.create();
  ok(subject);
});

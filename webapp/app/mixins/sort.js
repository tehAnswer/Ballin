import Ember from "ember";

export default Ember.Mixin.create({
  actions: {
    sortBy: function(property) {
      this.set('sortProperties', [property]);
      this.set('sortAscending', !this.get('sortAscending'));
    }
  }
});
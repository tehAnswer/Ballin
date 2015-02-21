import Ember from 'ember';

export default Ember.Component.extend({
  tagName: 'tr',
  contract: null,
  positions : null,
  actions: {
    saveContract : function(contract) {
      this.sendAction('save', contract);
    }
  }
});
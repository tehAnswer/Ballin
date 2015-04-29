import Ember from 'ember';
 
export default Ember.Component.extend({
  classNames: [''],
  isLoading: false,
  actions: {
    showLoading: function() {
      if(!this.get('isLoading')) {
        this.set('isLoading', true);
        this.sendAction('action');
      }
    }
  }
});
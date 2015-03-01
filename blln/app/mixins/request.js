import Ember from 'ember';
import ajax from 'ic-ajax';

export default Ember.Mixin.create({

  makeRequest: function (path, method, record, success, failure) {
    var request = ajax({
      url: path,
      type: method,
      headers: { 
        "Accept" : "application/json; charset=utf-8",
        "dagger" : this.get('cookie').getCookie('token')
      },
      data: record,
      dataType: "json"
    });

    request.then(success, failure);
  }
});
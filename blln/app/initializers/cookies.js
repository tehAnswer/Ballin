export default {
  name: 'cookies',
  after: ['cookie'],

  initialize: function(container, app) {
    app.inject('controller', 'cookie', 'cookie:main');
    app.inject('adapter', 'cookie', 'cookie:main');
    app.inject('route', 'cookie', 'cookie:main');
  }
};
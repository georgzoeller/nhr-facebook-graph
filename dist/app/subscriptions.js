// Generated by CoffeeScript 2.0.1
(function() {
  module.exports = function(context) {
    return {
      subscribe: function(json) {
        return context.createCall({
          endpoint: 'app/subscriptions'
        }).describe('Subscribing app to webhook.').authorizeByAppSecret().setMethod('POST').setJson(json);
      },
      checkSubscription: function() {
        return context.createCall({
          endpoint: 'app/subscriptions'
        }).describe('Querying app webhook subscription status.').authorizeByAppSecret().setMethod('GET');
      },
      unsubscribe: function(object) {
        return context.createCall({
          endpoint: 'app/subscriptions',
          qs: {
            object: object
          }
        }).describe(`unsubscribing app from webhook type ${object}`).authorizeByAppSecret().setMethod('DELETE');
      }
    };
  };

}).call(this);
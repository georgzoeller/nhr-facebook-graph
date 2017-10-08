// Generated by CoffeeScript 2.0.1
(function() {
  module.exports = {
    name: 'graph.facebook.com',
    url: 'https://graph.facebook.com/v2.10',
    limits: {
      rate: 20, // requests per interval,
      interval: 10, // interval for the rate, x
      backoffCode: 429, // back off when this status is returned
      backoffTime: 10, // back off for n seconds,
      maxWaitingTime: 120 // return errors for requests that will have to wait for n seconds or more.
    },
    imports: {
      app: [__dirname + '/app/app', __dirname + '/app/subscriptions', __dirname + '/me/subscribed_apps'],
      chat: [__dirname + '/me/messages'],
      messengerProfile: [__dirname + '/me/profile'],
      user: [__dirname + '/user/user'],
      workuser: [__dirname + '/user/workuser'],
      group: [__dirname + '/group/group'],
      post: [__dirname + '/post/post'],
      comment: [__dirname + '/comment/comment'],
      community: [__dirname + '/community/community'],
      album: [__dirname + '/album/album']
    },
    authCallbacks: {
      'token': function(msg) {
        return msg.addHeader('Authorization', `Bearer ${process.env.FB_PAGE_ACCESS_TOKEN}`);
      },
      'appsecret': function(msg) {
        return msg.addHeader('Authorization', `Bearer ${process.env.FB_APP_ID}|${process.env.FB_APP_SECRET}`);
      }
    },
    registerExtensions: function(api) {
      return {
        edge: function(id, edge, opts = {}) {
          if (opts.endpoint == null) {
            opts.endpoint = `${id}/${edge}`;
          }
          return api.createCall(opts);
        },
        node: function(id, opts = {}) {
          if (opts.endpoint == null) {
            opts.endpoint = id;
          }
          return api.createCall(opts);
        }
      };
    }
  };

}).call(this);
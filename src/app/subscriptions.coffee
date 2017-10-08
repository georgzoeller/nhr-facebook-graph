module.exports = (context) ->

  subscribe: (json) ->
    context.createCall endpoint: 'app/subscriptions'
      .describe 'Subscribing app to webhook.'
      .authorizeByAppSecret()
      .setMethod 'POST'
      .setJson json

  checkSubscription: () ->
    context.createCall endpoint: 'app/subscriptions'
      .describe 'Querying app webhook subscription status.'
      .authorizeByAppSecret()
      .setMethod 'GET'

  unsubscribe: (object) ->
    context.createCall endpoint: 'app/subscriptions', qs: {object: object}
      .describe "unsubscribing app from webhook type #{object}"
      .authorizeByAppSecret()
      .setMethod 'DELETE'


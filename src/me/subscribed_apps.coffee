module.exports = (context) ->

  subscribeAppToPage: ->
    context.createCall endpoint: 'me/subscribed_apps'
      .describe 'Subscribing app to page'
      .authorizeByToken()
      .setMethod 'POST'

  checkAppPageSubscription:  ->
    context.createCall endpoint: 'me/subscribed_apps'
      .describe 'Querying app page subscription'
      .authorizeByToken()
      .setMethod 'GET'


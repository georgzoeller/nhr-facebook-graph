
ALL_FIELDS = ['account_linking_url', 'persistent_menu', 'get_started', 'greeting',
  'whitelisted_domains', 'target_audience', 'home_url']

module.exports = (context) ->


  getFields: (fields = ALL_FIELDS) ->
    context.createCall endpoint: 'me/messenger_profile'
      .describe 'Querying profile fields'
      .authorizeByToken()
      .setFields fields
      .setMethod 'GET'

  updateField:  (fieldName, newValue) ->
    x = {}
    x[fieldName] = newValue
    context.createCall endpoint: 'me/messenger_profile'
      .describe "updating profile field #{fieldName} to #{newValue}"
      .authorizeByToken()
      .setJson x
      .setMethod 'POST'

  deleteField:  (fieldName) ->
    context.createCall endpoint: 'me/messenger_profile'
      .describe "DELETING profile field #{fieldName}"
      .authorizeByToken()
      .setJson  'fields' : [fieldName]
      .setMethod 'DELETE'

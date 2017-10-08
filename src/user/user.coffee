
module.exports = (context) ->

  getProfile: (user_id) ->
    context.createCall endpoint: "#{user_id}"
      .describe "Requesting profile for user #{user_id}"
      .setMethod 'GET'
      .authorizeByToken()
      .setFields ['id', 'first_name', 'last_name', 'profile_pic', 'locale', 'timezone', 'gender', 'is_payment_enabled']
      .setResultsTransform ((profile) ->
        profile.picture = profile.profile_pic
        profile
        )


  resolveEmail: (email) ->
    context.createCall endpoint: "#{email}"
      .describe "Resolving #{email} to id."
      .setMethod 'GET'
      .setFields ['id']

  getImpersonationToken: (user_id) ->
    context.createCall endpoint: "#{user_id}"
      .describe "Requesting impersonation token for for user #{user_id}"
      .setMethod 'GET'
      .authorizeByToken()
      .setFields ['id', 'impersonate_token']
      .setResultsTransform (resp) -> resp['impersonate_token']

  postToFeed: (user_id, {message, markdown = false}) ->
    formatting = 'PLAINTEXT'
    formatting = 'MARKDOWN' if markdown
    context.createCall endpoint: "#{user_id}/feed"
      .describe "creating post to (#{user_id}/feed"
      .authorizeByToken()
      .setMethod 'POST'
      .setJson {message:message, formatting:formatting}

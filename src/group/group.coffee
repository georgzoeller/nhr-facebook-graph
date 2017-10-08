
module.exports = (context) ->

  getMembers: (group_id) ->
    context.edge group_id, 'members'
      .describe "getting group(#{group_id})/members"
      .authorizeByToken()
      .setFields ['id']
      .setMethod 'GET'
      .allPages()

  getAdmins: (group_id) ->
    context.edge group_id, 'admins'
      .describe "getting group(#{group_id})/admins"
      .authorizeByToken()
      .setFields ['id']
      .setMethod 'GET'
      .allPages()

  addMember: (group_id, email) ->
    context.edge group_id, 'members'
      .describe "Adding #{email} to group #{group_id}"
      .authorizeByToken()
      .setMethod 'POST'
      .addQueryStringParams email: email

  promoteAdmin: (group_id, user_id) ->
    context.createCall endpoint: "#{user_id}/admins/#{user_id}"
      .describe "Promoting #{user_id} to admin of group #{group_id}"
      .authorizeByToken()
      .setMethod 'POST'


  ## TODO: rename to postToFeed
  addPost: (group_id, {message, markdown = false}) ->

    formatting = 'PLAINTEXT'
    formatting = 'MARKDOWN' if markdown

    context.createCall endpoint: "#{group_id}/feed"
      .describe "creating post to (#{group_id}"
      .authorizeByToken()
      .setMethod 'POST'
      .setJson {message:message, formatting:formatting}


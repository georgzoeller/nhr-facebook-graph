
module.exports = (context) ->

  ALL_FIELDS: ['id', 'attachment', 'can_comment', 'can_remove', 'can_hide', 'can_like',
    'comment_count', 'created_time', 'from', 'message', 'message_tags', 'object', 'parent']

  _get = (comment_id, fields=['id', 'message']) ->
    context.createCall endpoint: "#{comment_id}"
      .describe "getting comment #{comment_id}"
      .authorizeByToken()
      .setFields fields
      .setMethod 'GET'

  update: (comment_id, message) ->
    context.createCall endpoint: "#{comment_id}"
      .describe "updateing comment #{comment_id} #{message}"
      .authorizeByToken()
      .setMethod 'POST'
      .setJson {message: message, formatting: 'MARKDOWN'}

  # TODO: rename to 'single' and add 'many'
  single: _get

  add: (object_id, {message, attachment_url}) ->
    context.createCall endpoint: "#{object_id}/comments"
      .describe "commenting on #{object_id}: #{message}"
      .authorizeByToken()
      .setMethod 'POST'
      .setJson {message: message}
      .addJson 'attachment_url', attachment_url

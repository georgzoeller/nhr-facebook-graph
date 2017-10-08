
module.exports = (context) ->

  _get = (post_id, fields=['id', 'message']) ->
    context.createCall endpoint: "#{post_id}"
      .describe "getting post #{post_id}"
      .authorizeByToken()
      .setFields fields
      .setMethod 'GET'

  ALL_FIELDS:  ['id', 'created_time', 'formatting', 'from', 'icon', 'link', 'message',
    'name', 'place', 'status_type', 'with_tags', 'type', 'to', 'permalink_url']

  get: _get

  getPermalink: (post_id) -> _get(post_id, ['permalink_url']).setResultsTransform (res) -> res['permalink_url']

  ## TODO: Deprecate in favour of comment.add
  addComment: (post_id, message) ->
    context.debug '[Deprecated] post.addComment is deprecated. Use comment.add'
    context.createCall endpoint: "#{post_id}/comments"
      .describe "commenting on #{post_id}: #{message}"
      .authorizeByToken()
      .setMethod 'POST'
      .setJson {message: message}

  update: (post_id, {message}) ->
    context.debug '[Not Implemented on Workplace] - Updating posts is not implemented on Workplace'
    context.createCall endpoint: "#{post_id}"
      .describe "updating (#{post_id}: #{message}"
      .authorizeByToken()
      .setMethod 'POST'
      .setJson {message: message}

  delete: (post_id) ->
    context.createCall endpoint: "#{post_id}"
      .describe "deleting (#{post_id}"
      .authorizeByToken()
      .setMethod 'DELETE'
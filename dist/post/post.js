// Generated by CoffeeScript 2.0.1
(function() {
  module.exports = function(context) {
    var _get;
    _get = function(post_id, fields = ['id', 'message']) {
      return context.createCall({
        endpoint: `${post_id}`
      }).describe(`getting post ${post_id}`).authorizeByToken().setFields(fields).setMethod('GET');
    };
    return {
      ALL_FIELDS: ['id', 'created_time', 'formatting', 'from', 'icon', 'link', 'message', 'name', 'place', 'status_type', 'with_tags', 'type', 'to', 'permalink_url'],
      get: _get,
      getPermalink: function(post_id) {
        return _get(post_id, ['permalink_url']).setResultsTransform(function(res) {
          return res['permalink_url'];
        });
      },
      //# TODO: Deprecate in favour of comment.add
      addComment: function(post_id, message) {
        context.debug('[Deprecated] post.addComment is deprecated. Use comment.add');
        return context.createCall({
          endpoint: `${post_id}/comments`
        }).describe(`commenting on ${post_id}: ${message}`).authorizeByToken().setMethod('POST').setJson({
          message: message
        });
      },
      update: function(post_id, {message}) {
        context.debug('[Not Implemented on Workplace] - Updating posts is not implemented on Workplace');
        return context.createCall({
          endpoint: `${post_id}`
        }).describe(`updating (${post_id}: ${message}`).authorizeByToken().setMethod('POST').setJson({
          message: message
        });
      },
      delete: function(post_id) {
        return context.createCall({
          endpoint: `${post_id}`
        }).describe(`deleting (${post_id}`).authorizeByToken().setMethod('DELETE');
      }
    };
  };

}).call(this);

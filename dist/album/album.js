// Generated by CoffeeScript 2.3.2
(function() {
  module.exports = function(context) {
    return {
      create: function(object_id, {name, description = '', privacy = 'PUBLIC', make_shared_album = false}) {
        return context.createCall({
          endpoint: `${object_id}`
        }).describe(`creating album on object ${object_id}`).setMethod('POST').authorizeByToken().setJson({
          name: name,
          message: description,
          privacy: privacy,
          make_shared_album: make_shared_album
        });
      }
    };
  };

}).call(this);

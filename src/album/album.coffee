
module.exports = (context) ->


  create: (object_id, {name, description='', privacy='PUBLIC', make_shared_album=false}) ->
    context.createCall endpoint: "#{object_id}"
      .describe "creating album on object #{object_id}"
      .setMethod 'POST'
      .authorizeByToken()
      .setJson {name: name, message: description, privacy: privacy, make_shared_album: make_shared_album}
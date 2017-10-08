module.exports = (context) ->

  addGroup: (community_id, {name, description='', privacy='OPEN'}) ->
    context.edge "#{community_id}", 'groups'
      .describe "Creating group(#{name}) on #{community_id} with privacy #{privacy}"
      .authorizeByToken()
      .setMethod 'POST'
      .setJson {name: name, privacy: privacy, description: description}

  getAppCommunity: ->
    context.node 'community'
      .describe 'Retrieving community information'
      .authorizeByToken()
      .setMethod 'GET'

  getGroups: (community_id) ->
    context.edge community_id, 'groups'
      .describe 'getting groups'
      .authorizeByToken()
      .setMethod 'GET'
      .allPages()


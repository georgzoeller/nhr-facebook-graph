module.exports = (context) ->

  get: (id, opts = {}) ->
    context.node id, opts
      .describe 'Getting app info'
      .authorizeByToken()
      .setMethod 'GET'
      .setFields opts.fields || ['id','name','app_type','contact_email','link','description','monthly_active_users']


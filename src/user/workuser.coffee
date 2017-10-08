
module.exports = (context) ->

  user = require('./user')(context)

  user.getProfile = (user_id) ->
    context.createCall endpoint: "#{user_id}"
      .describe "Requesting profile for user #{user_id}"
      .setMethod 'GET'
      .authorizeByToken()
      .setFields ['id', 'first_name', 'last_name', 'picture', 'locale', 'timezone', 'gender', 'email']

  user
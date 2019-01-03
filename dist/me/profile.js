// Generated by CoffeeScript 2.3.2
(function() {
  var ALL_FIELDS;

  ALL_FIELDS = ['account_linking_url', 'persistent_menu', 'get_started', 'greeting', 'whitelisted_domains', 'target_audience', 'home_url'];

  module.exports = function(context) {
    return {
      getFields: function(fields = ALL_FIELDS) {
        return context.createCall({
          endpoint: 'me/messenger_profile'
        }).describe('Querying profile fields').authorizeByToken().setFields(fields).setMethod('GET');
      },
      updateField: function(fieldName, newValue) {
        var x;
        x = {};
        x[fieldName] = newValue;
        return context.createCall({
          endpoint: 'me/messenger_profile'
        }).describe(`updating profile field ${fieldName} to ${newValue}`).authorizeByToken().setJson(x).setMethod('POST');
      },
      deleteField: function(fieldName) {
        return context.createCall({
          endpoint: 'me/messenger_profile'
        }).describe(`DELETING profile field ${fieldName}`).authorizeByToken().setJson({
          'fields': [fieldName]
        }).setMethod('DELETE');
      }
    };
  };

}).call(this);

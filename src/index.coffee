{Plugin} = require 'inform-shared'

class AuthenticationError extends Error

class TropoSMSPlugin extends Plugin
  constructor: (@options) ->
    if !@options.token?
      throw new AuthenticationError 'No token provided.'

  receive: (message) -> console.log message

module.exports.Plugin = TropoSMSPlugin


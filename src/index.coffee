{TropoWebAPI} = require 'tropo-webapi'
{Plugin} = require 'inform-shared'

class AuthenticationError extends Error

class TropoSMSPlugin extends Plugin
  constructor: (@options) ->
    if !@options.tropo_token?
      throw new AuthenticationError 'No tropo_token provided.'

    @backend = new TropoWebAPI

  receive: (message) -> console.log message

module.exports.Plugin = TropoSMSPlugin


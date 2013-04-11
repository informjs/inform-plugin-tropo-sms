{Plugin} = require 'inform-shared'

class OptionsError extends Error

class TropoSMSPlugin extends Plugin
  constructor: (@options) ->
    if !@options.token?
      throw new Error 'No token provided.'

    if !@options.destination?
      throw new OptionsError 'No destination provided.'

  receive: (message) -> console.log message

module.exports.Plugin = TropoSMSPlugin


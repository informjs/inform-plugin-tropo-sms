{Plugin} = require 'inform-shared'

http = require 'http'
url = require 'url'

class OptionsError extends Error

class TropoSMSPlugin extends Plugin
  constructor: (@options) ->
    if !@options.token?
      throw new Error 'No token provided.'

    if !@options.destination?
      throw new OptionsError 'No destination provided.'

  buildURL: (message) =>
    return 'http://api.tropo.com/1.0/sessions?action=create&token=' +
           "#{ @options.token }&msg=#{ encodeURI message }&number=#{ @options.destination }"

  receive: (message) =>
    parsedURL = url.parse @buildURL message

    client = http.createClient 80, parsedURL.host

    request = client.request 'GET', parsedURL.path,
      host: parsedURL.host

    request.end()

module.exports.Plugin = TropoSMSPlugin


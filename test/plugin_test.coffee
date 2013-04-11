http = require 'http'
url = require 'url'

{Plugin} = require '../src'

sinon = require 'sinon'
{expect} = require 'chai'

exampleData =
  options:
    token: 'example'
    destination: '8018018080'

describe 'Plugin', ->
  it 'should define #receive', ->
    expect(Plugin.prototype.receive).to.not.equal undefined

  describe '#constructor', ->
    it 'should set options to the first provided argument', sinon.test ->
      plugin = new Plugin exampleData.options

      expect(plugin.options).to.deep.equal exampleData.options

    it 'should throw an error if authentication settings are not provided', sinon.test ->
      pluginFactory = -> new Plugin { destination: '8018018080' }

      expect(pluginFactory).to.throw Error

    it 'should throw an error if SMS destination setting is not provided', sinon.test ->
      pluginFactory = -> new Plugin { token: 'xxx' }

      expect(pluginFactory).to.throw Error

  describe '#buildURL', ->
    it 'should return a valid Tropo API v1.0 URL', sinon.test ->
      plugin = new Plugin exampleData.options

      result = plugin.buildURL 'message'

      expect(result).to.equal 'http://api.tropo.com/1.0/sessions?action=create&token=example&msg=message&number=8018018080'

  describe '#receive', ->
    it 'should send a properly formatted HTTP request to tropo', sinon.test ->
      requestEnd = @spy()
      request = @stub().returns { end: requestEnd }
      createClient = @stub(http, 'createClient').returns { request: request }

      plugin = new Plugin exampleData.options

      plugin.receive 'message'
      parsedURL = url.parse plugin.buildURL 'message'

      expect(createClient.calledOnce).to.be.true
      expect(createClient.calledWith 80, parsedURL.host).to.be.true

      expect(request.calledOnce).to.be.true
      expect(request.calledWith 'GET', parsedURL.path, {host: parsedURL.host}).to.be.true
      expect(request.calledAfter createClient).to.be.true

      expect(requestEnd.calledOnce).to.be.true
      expect(requestEnd.calledAfter request).to.be.true


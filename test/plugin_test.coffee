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


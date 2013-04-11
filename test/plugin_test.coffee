{Plugin} = require '../src'

sinon = require 'sinon'
{expect} = require 'chai'

exampleData =
  options:
    token: 'example'

describe 'Plugin', ->
  it 'should define #receive', ->
    expect(Plugin.prototype.receive).to.not.equal undefined

  describe '#constructor', ->
    it 'should set options to the first provided argument', sinon.test ->
      plugin = new Plugin exampleData.options

      expect(plugin.options).to.deep.equal exampleData.options

    it 'should throw an error if authentication settings are not provided', sinon.test ->
      pluginFactory = -> new Plugin {}

      expect(pluginFactory).to.throw Error


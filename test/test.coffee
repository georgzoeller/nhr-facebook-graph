assert = require 'assert'
should = require 'should'


describe 'Test Environment', ->
  describe 'API Keys', ->
    it 'node-rest-helper should be installed', ->
      (-> require 'node-rest-helper').should.not.throw()

    it 'FB_PAGE_ACCESS_TOKEN should be present in environment', ->
      process.env.should.have.property('FB_PAGE_ACCESS_TOKEN').which.is.not.empty()

    it 'should require without throwing', ->
      (->     lib = require('../dist/index')).should.not.throw()


describe 'Functional test', ->
  lib = require('../dist/index')
  api = require('node-rest-helper').create('fb-graph')

  it 'should load with api.load', ->
    (-> api.load lib).should.not.throw()
    api.loaded.should.be.true()

  it 'should have extended api with edge and node', ->
    api.should.have.property('edge').which.is.a.Function()
    api.should.have.property('node').which.is.a.Function()

  it 'should have the auth hooks token and appsecret', ->
    api.authHooks.should.have.property('token')
    api.authHooks.should.have.property('appsecret')




describe 'API test', ->

  lib = require('../dist/index')
  api = require('node-rest-helper').create('fb-graph')
  api.load lib


  before ->
    if not process.env.FB_PAGE_ACCESS_TOKEN?
      api.debug "Skipping Remote tests as no access is defined"
      @skip()


  it 'app.get should return the expected structure', ->
    val = await api.send api.app.get(process.env.FB_APP_ID)
    console.log JSON.stringify val, null, 8
    should.exists val
    val.should.have.property('id').which.is.a.String().match(process.env.FB_APP_ID)
    val.should.have.property('name').which.is.a.String().and.not.empty()




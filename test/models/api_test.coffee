ApiModel = require 'models/api'

describe 'ApiModel', ->
    beforeEach ->
        @model = new ApiModel()

    it 'should exist', ->
        expect(@model).to.be.ok

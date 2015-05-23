Api = require './api'
module.exports = class EngineModel extends Backbone.Model
    constructor: (reg)->
        @reg = reg
    fetch: ->
        @set(Api.getEngineData(@reg))

Api = require '../models/api'
module.exports = class TripCollection extends Backbone.Collection
    model: Trip
    constructor: (reg) ->
      @reg = reg
    fetch: (from, to) ->
      getTripsData @reg, from, to, (data) =>
        @reset(data)

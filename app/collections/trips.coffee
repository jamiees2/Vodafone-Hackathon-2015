Api = require '../models/api'
Trip = require '../models/trip'
module.exports = class TripCollection extends Backbone.Collection
    model: Trip
    constructor: (reg) ->
      @reg = reg
    fetch: (from, to) ->
      Api.getTripsData @reg, from, to, (data) =>
        @reset(data)

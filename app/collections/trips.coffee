Api = require '../models/api'
Trip = require '../models/trip'
module.exports = class TripCollection extends Backbone.Collection
    model: Trip
    initialize: (reg) ->
      @reg = reg
    fetch: (from, to) ->
      Api.getTripsData @reg, from, to, (data) =>
        console.log data
        @reset(data)

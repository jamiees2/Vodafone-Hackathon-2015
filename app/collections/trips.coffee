Api = require '../models/api'
Trip = require '../models/trip'
module.exports = class TripCollection extends Backbone.Collection
    model: Trip
    initialize: (reg) ->
      @reg = reg
      @fetch(moment().subtract(5, 'minutes').format("YYYY-MM-DD HH:mm"), moment().format("YYYY-MM-DD HH:mm"))
    fetch: (from, to) ->
        Api.getTripsData @reg, from, to, (data) =>
            @reset(data)

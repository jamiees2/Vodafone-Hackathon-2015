Api = require './api'
Engine = require './engine'
TripCollection = require 'collections/trips'
module.exports = class CarModel extends Backbone.Model
    initialize: (reg) =>
      @reg = reg
      @engine = new Engine(reg)
      @trips = new TripCollection(reg)
      @fetch()
      setInterval(@fetchLocation, 3000)
    fetch: (cb) =>
      Api.getVehicleInfo @reg, (data) =>
        @set(data)
        @fetchLocation(cb)
    fetchLocation: (cb) =>
      Api.getPosition @reg, (data) =>
        @set({position: data})
        cb() if cb?
      Api.getEngineData @reg, moment().subtract(5, 'minutes').format("YYYY-MM-DD HH:mm"), moment().format("YYYY-MM-DD HH:mm"), (data) =>
        console.log data

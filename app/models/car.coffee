Api = require './api'
Engine = require './engine'
module.exports = class CarModel extends Backbone.Model
    initialize: (reg) =>
      @reg = reg
      @engine = new Engine(reg)
      #@trips = new TripCollection(reg)
      #@positions = new PositionCollection(reg)
      @fetch()
      setInterval(@fetchLocation, 10000)
    fetch: (cb) =>
      Api.getVehicleInfo @reg, (data) =>
        @set(data)
        @fetchLocation(cb)
    fetchLocation: (cb) =>
      Api.getPosition @reg, (data) =>
        @set({position: data})
        cb() if cb?

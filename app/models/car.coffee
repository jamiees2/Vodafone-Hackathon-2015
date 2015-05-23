Api = require './api'
Engine = require './engine'
module.exports = class CarModel extends Backbone.Model
    initialize: (reg) =>
      @reg = reg
      @engine = new Engine(reg)
      #@trips = new TripCollection(reg)
      #@positions = new PositionCollection(reg)
      @fetch()
    fetch: (cb) =>
      Api.getVehicleInfo @reg, (data) =>
        @set(data)
        cb() if cb?

Api = require './api'
module.exports = class CarModel extends Backbone.Model
    events:
      "update": "fetchLocation"
    initialize: (reg) =>
      @reg = reg
      @fetch()
      
    fetch: (cb) =>
      Api.getVehicleInfo @reg, (data) =>
        @set(data)
        @fetchLocation(cb)
    fetchLocation: (cb) =>
      Api.getPosition @reg, (data) =>
        @set({position: data})
        cb() if cb?
      Api.getEngineData @reg, moment().subtract(5, 'minutes').format("YYYY-MM-DD HH:mm"), moment().format("YYYY-MM-DD HH:mm"), (data) =>
        console.log(data[0])
        @set({engine: data[0]})

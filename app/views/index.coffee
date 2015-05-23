CarModel = require '../models/car'
module.exports = class IndexView extends Backbone.View
    initialize: ->
      console.log 'Index View'
      car = new CarModel("OT380")
      car.fetch ->
          console.log(car.get("RegNumber"))

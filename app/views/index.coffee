CarModel = require '../models/car'
module.exports = class IndexView extends Backbone.View
    initialize: =>
      console.log 'Index View'
      @car = new CarModel("OT380")
      @car.on "change", =>
          console.log(@car.get("RegNumber"))

    template: require 'views/templates/index'

    render: =>
        @$el.html @template @car.toJSON()
        @loadMap()

        return @

    loadMap: () =>
        mapOptions =
            zoom: 8,
            center: new google.maps.LatLng(-34.397, 150.644)

        @map = new google.maps.Map(@$el.find("#map-canvas")[0], mapOptions)



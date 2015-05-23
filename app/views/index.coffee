CarModel = require '../models/car'
module.exports = class IndexView extends Backbone.View
    el: "section.app"
    initialize: =>
      console.log 'Index View'
      @car = new CarModel("OT380")
      @car.on "change", =>
          console.log(@car.get("position"))

    template: require 'views/templates/index'

    launch: =>
      @render()
    render: =>
        @$el.html @template @car.toJSON()
        @loadMap()

        return @

    loadMap: () =>
        mapOptions =
            zoom: 8,
            center: new google.maps.LatLng(@car.get("position").Lat, @car.get("position").Lon)

        @map = new google.maps.Map(@$el.find("#map-canvas")[0], mapOptions)



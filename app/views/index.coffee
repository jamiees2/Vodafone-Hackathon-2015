CarModel = require '../models/car'
module.exports = class IndexView extends Backbone.View
    el: "section.app"
    initialize: =>
      console.log 'Index View'
      @car = new CarModel("OT380")
      @car.on "change", =>
          console.log(@car.get("position"))
      @car.on "change:position", @reloadMap

    template: require 'views/templates/index'

    launch: =>
      @render()
    render: =>
      @$el.html @template @car.toJSON()
      @loadMap()

    loadMap: () =>
      mapOptions =
        zoom: 8,
        center: new google.maps.LatLng(64.135337, -21.895210)

      @map = new google.maps.Map(@$el.find("#map-canvas")[0], mapOptions)
      @marker = new google.maps.Marker
        map: @map
      @reloadMap()
    reloadMap: =>
      console.log "nooo", @car.get("position")
      return unless @marker? and @car.get("position")?
      l = new google.maps.LatLng(@car.get("position").Lat, @car.get("position").Lon)
      @marker.setPosition(l)
      @map.panTo(l)
      @map.setZoom(16)



CarModel = require '../models/car'
module.exports = class IndexView extends Backbone.View
    el: "section.app"
    initialize: =>
      console.log 'Index View'
      @car = new CarModel("SK014")
      @car.trips.fetch("2015-05-20 16:00", "2015-05-21 16:00")
      @car.on "change:position", @reloadMap
      @car.on "change", @updateMenu
      $(window).on "resize", @resizeMap
    remove: =>
      $(window).off "resize", @resizeMap
      super


    template: require 'views/templates/index'
    menuTemplate: require 'views/templates/index_menu'

    launch: =>
      @render()
    render: =>
      @$el.html @template @car.toJSON()
      @loadMap()
      @updateMenu()
    updateMenu: =>
      @$el.find(".menu").html @menuTemplate @car.toJSON()

    loadMap: () =>
      mapOptions =
        zoom: 8,
        center: new google.maps.LatLng(64.135337, -21.895210)

      @map = new google.maps.Map(@$el.find("#map-canvas")[0], mapOptions)
      @marker = new google.maps.Marker
        map: @map
      @youMark = new google.maps.Marker
        map: @map
      @reloadMap()
    reloadMap: =>
      return unless @marker? and @car.get("position")?
        navigator.geolocation.getCurrentPosition( (@location) =>
            youLat = new google.maps.LatLng(@location.coords.latitude, @location.coords.longitude)
            @youMark.setPosition(youLat)
        )
      l = new google.maps.LatLng(@car.get("position").Lat, @car.get("position").Lon)
      @marker.setPosition(l)
      @map.panTo(l)
      @map.setZoom(16)
    resizeMap: =>
      center = @map.getCenter()
      google.maps.event.trigger(@map, "resize")
      @map.setCenter(center)

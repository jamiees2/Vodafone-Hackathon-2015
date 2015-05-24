CarModel = require '../models/car'
module.exports = class IndexView extends Backbone.View
    el: "section.app"
    initialize: =>
      console.log 'Index View'
      @car = new CarModel(window.CAR)
      @car.on "change:position", @reloadMap
      @car.on "change", @updateMenu
      $(window).on "resize", @resizeMap

      @refreshCar()
    refreshCar: =>
      @car.fetchLocation()
      @timeout = setTimeout @refreshCar, 4000
    remove: =>
      console.log("clear")
      $(window).off "resize", @resizeMap
      clearTimeout @timeout
      @$el.empty().off()
      @stopListening()
      #super


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
        icon: '/images/car.png'
      @youMark = new google.maps.Marker
        map: @map
        icon: '/images/user.png'
      @reloadMap()
    reloadMap: =>
      return unless @marker? and @car.get("position")?
      bounds = new google.maps.LatLngBounds()
      fixBounds = _.after(2, => 
        @map.fitBounds(bounds)
        @map.setCenter(bounds.getCenter())
        )
      navigator.geolocation.getCurrentPosition( (@location) =>
          youLat = new google.maps.LatLng(@location.coords.latitude, @location.coords.longitude)
          bounds.extend(youLat)
          @youMark.setPosition(youLat)
          fixBounds()
      )
      l = new google.maps.LatLng(@car.get("position").Lat, @car.get("position").Lon)
      bounds.extend(l)
      @marker.setPosition(l)
      @map.panTo(l)
      @map.setZoom(16)
      fixBounds()
      # bounds = new google.maps.LatLngBounds()
      # markers = []
      # markers.push(@marker)
      # markers.push(@youMark)
      # for(i=0;i<markers.length;i++) {
      #      bounds.extend(markers[i].getPosition())
      # }
      # @map.fitBounds(bounds)

    resizeMap: =>
      center = @map.getCenter()
      google.maps.event.trigger(@map, "resize")
      @map.setCenter(center)

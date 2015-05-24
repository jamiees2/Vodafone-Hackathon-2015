TripCollection = require '../collections/trips'
module.exports = class TripsView extends Backbone.View
  el: "section.app"

  events: 
    "click .trips tbody tr": "selectItem"

  initialize: =>
    @trips = new TripCollection("SK014")
    @trips.fetchRecent()
    @selected_trips = new TripCollection("SK014")
    # @selected_trips.on "add", @reloadMap
    @selected_trips.on "update", @reloadMap
    @selected_trips.on "remove", @removeMap
    @trips.on "reset", =>
      # console.log(@trips.toJSON())
  remove: =>
    @$el.empty().off()
    @stopListening()
    #super

  selectItem: (e) =>
    $it = $(e.currentTarget)
    idx = $it.attr("data-item")
    if $it.hasClass("data-selected")
      @selected_trips.remove(@trips.at(idx))
      $it.removeClass("teal lighten-2 data-selected")
    else
      $it.addClass("teal lighten-2 data-selected")
      @selected_trips.add(@trips.at(idx))
  loadMap: () =>
    mapOptions =
      zoom: 12,
      center: new google.maps.LatLng(64.135337, -21.895210)
      mapTypeId : google.maps.MapTypeId.ROADMAP

    @map = new google.maps.Map @$el.find("#map-canvas")[0], mapOptions
    # @map.setCenter new google.maps.LngLat(-21.895210, 64.135337)
    # @reloadMap()
  reloadMap: =>
    bounds = new google.maps.LatLngBounds()

    @selected_trips.map (item) =>
      unless item.path?
        item.getPositions (positions) =>
          path = _.map positions, (it) =>
            l = new google.maps.LatLng(it.Lat, it.Lon)
            bounds.extend(l)
            return l
          item.path = @renderPath(path)
          item.path.setMap(@map)
      else
        item.path.setMap(@map)
    if not bounds.isEmpty()
      @map.fitBounds(bounds)
      @map.setCenter(bounds.getCenter())


  renderPath: (path) =>
    new google.maps.Polyline
      path: path,
      strokeColor: '#0000FF',
      strokeOpacity: 1.0,
      strokeWeight: 2
  removeMap: (item) =>
    item.path.setMap(null) if item.path?

  template: require 'views/templates/trips'

  launch: =>
    @render()

  render: =>
    @trips.on "reset", =>
      @$el.html @template {trips: @trips.toJSON()}
      @loadMap()

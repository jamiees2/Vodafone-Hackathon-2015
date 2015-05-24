TripCollection = require '../collections/trips'
module.exports = class TripsView extends Backbone.View
  el: "section.app"

  events: 
    "click .data .trips tbody tr": "selectItem"

  initialize: =>
    @trips = new TripCollection([], window.CAR)
    @trips.fetchRecent()
    @selected_trips = new TripCollection([], window.CAR)
    # @selected_trips.on "add", @reloadMap
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
      $it.removeClass("teal lighten-4 data-selected")
      @selected_trips.remove(@trips.at(idx))
    else
      $it.addClass("teal lighten-4 data-selected")
      @selected_trips.add(@trips.at(idx))
  loadMap: () =>
    mapOptions =
      zoom: 12,
      center: new google.maps.LatLng(64.135337, -21.895210)
      mapTypeId : google.maps.MapTypeId.ROADMAP

    @map = new google.maps.Map @$el.find("#map-canvas")[0], mapOptions
    @selected_trips.on "update", @reloadMap
    @selected_trips.on "remove", @removeMap
  reloadMap: =>
    bounds = new google.maps.LatLngBounds()

    @selected_trips.map (item) =>
      unless item.path?
        item.fetchPositions (positions) =>
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
  tableTemplate: require 'views/templates/trips_table'
  menuTemplate: require 'views/templates/trips_menu'

  launch: =>
    @render()

  render: =>
    @$el.html @template()
    @loadMap()
    loadTable = =>
      @$el.find(".data").html @tableTemplate {trips: @trips.toJSON()}
      if @$el.find('.data .table thead').length > 0
        @$el.find('.data .table thead').pushpin({ top: @$el.find('.data .table thead').offset().top });
    @trips.on "reset", loadTable
    @trips.on "change", loadTable
    loadTable()
    @selected_trips.on "update", =>
      @$el.find(".menu").html @menuTemplate {stats: @selected_trips.getStatistics()}


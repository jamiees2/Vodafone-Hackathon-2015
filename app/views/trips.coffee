TripCollection = require '../collections/trips'
module.exports = class TripsView extends Backbone.View
  el: "section.app"

  events: 
    "click .trips tbody tr": "selectItem"

  initialize: =>
    @trips = new TripCollection("SK014")
    @trips.on "reset", =>
      # console.log(@trips.toJSON())
  remove: =>
    @$el.empty().off()
    @stopListening()
    #super

  selectItem: (e) =>
    console.log $(e.currentTarget).attr("data-item")

  template: require 'views/templates/trips'

  launch: =>
    @render()

  render: =>
    @trips.on "reset", =>
      @$el.html @template {trips: @trips.toJSON()}

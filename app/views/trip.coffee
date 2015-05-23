TripCollection = require '../collections/trips'
module.exports = class TripView extends Backbone.View
    el: "section.app"
    initialize: =>
        @trip = new TripModel("SK014", )
        @trips.on "reset", =>
            # console.log(@trips.toJSON())


    template: require 'views/templates/trip'

    launch: =>
      @render()

    render: =>
        @trips.on "reset", =>
            @$el.html @template @trip.toJSON()

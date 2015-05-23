TripCollection = require '../collections/trips'
module.exports = class TripView extends Backbone.View
    el: "section.app"
    initialize: =>
        @trips = new TripCollection("SK014")
        @trips.on "change", =>
            console.log(@trips.toJSON())


    template: require 'views/templates/trips'

    launch: =>
      @render()

    render: =>
        @$el.html @template {trips: @trips.toJSON()}

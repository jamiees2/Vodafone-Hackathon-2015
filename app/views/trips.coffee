TripsCollection = require '../collections/trips'
module.exports = class TripModel extetds Backbone.View
    el: "section.app"
    initialize: =>
        @trips = new TripsCollection("SK014")

    render: =>
        @$el.html @template @trips.toJSON()

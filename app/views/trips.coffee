TripCollection = require '../collections/trips'
module.exports = class TripView extends Backbone.View
    el: "section.app"
    initialize: =>
        @trips = new TripCollection("SK014")
        console.log(@trips)

    template: require 'views/templates/trips'

    render: =>
        @$el.html @template {trips: @trips.toJSON()}

class MainRouter extends Backbone.Router
    routes:
        '': 'index'
        '/trips': 'trips'

    index: ->
        IndexView = require 'views/index'
        index = new IndexView()
        index.launch()

    trips: ->
        TripsView = require 'views/trips'
        trips = new TripView()
        trips.launch()

main = new MainRouter()
module.exports = main

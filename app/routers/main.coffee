class MainRouter extends Backbone.Router
    routes:
        '': 'index'
        'trips': 'trips'
        'stats': 'stats'
    execute: (cb, args, name) =>
        @current.remove() if @current? and @current.remove?
        cb.apply(@,args) if cb?

    index: ->
        IndexView = require 'views/index'
        index = new IndexView()
        @current = index
        index.launch()

    trips: ->
        TripsView = require 'views/trips'
        trips = new TripsView()
        @current = trips
        trips.launch()

    stats: ->
        StatView = require 'views/stats'
        stats = new StatView()
        @current = stats
        stats.launch()

main = new MainRouter()
module.exports = main





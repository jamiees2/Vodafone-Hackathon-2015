class MainRouter extends Backbone.Router
    routes:
        '': 'index'
        'trips': 'trips'

    index: ->
        IndexView = require 'views/index'
        index = new IndexView()
        index.launch()

    trips: ->
        TripsView = require 'views/trips'
        trips = new TripsView()
        trips.launch()

main = new MainRouter()
module.exports = main


# Fix the tab stupidness
$ ->
    $(".tabs a:not([href^=#])").on 'click', ->
        main.navigate($(this).attr('href'), true)

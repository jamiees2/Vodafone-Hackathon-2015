CarModel = require '../models/car'
module.exports = class StatView extends Backbone.View
    el: "section.app"
    initialize: =>
        console.log 'Stat View'
        @car = new CarModel("SK014")
        @car.on "change", @updateStats

        @refreshCar()
        @updateSpeed()


    refreshCar: =>
        @car.fetchLocation()
        @timeout = setTimeout @refreshCar, 4000

    remove: =>
      @$el.empty().off()
      @stopListening()
      #super

    template: require 'views/templates/stats'

    launch: =>
      @render()

    render: =>
        @trips.on "reset", =>
            @$el.html @template {trips: @trips.toJSON()}

    updateStats: =>
        @$el.html @template @car.toJSON()

    @plotSpeed = $.plot("#speedChart", [ [1,1,1] ], {
        series: {
            shadowSize: 2
        },
        yaxis: {
            min: 0,
            max: 100
        },
        xaxis: {
            show: false
        }
    })

    updateSpeed: =>
        @plotSpeed.setData([getRandomData()])

        @plotSpeed.draw()
        setTimeout(update, 4000)


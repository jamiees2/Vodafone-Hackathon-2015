CarModel = require '../models/car'
module.exports = class StatView extends Backbone.View
    el: "section.app"
    initialize: =>
        console.log 'Stat View'
        @car = new CarModel("SK014")
        @car.on "change", @updateStats


        @refreshCar()

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
        # @car.on "reset", =>
        @$el.html @template @car.toJSON()

    updateStats: =>
        @$el.html @template @car.toJSON()
        @updateSpeed()

    # @plotSpeed = $.plot("#speedChart",  [[[0, 12], [7, 12], null, [7, 2.5], [12, 2.5]] ], {
    #     series: {
    #         shadowSize: 2
    #     },
    #     yaxis: {
    #         min: 0,
    #         max: 100
    #     },
    #     xaxis: {
    #         show: false
    #     }
    # })

    # updateSpeed: =>
    #     @plotSpeed.setData([[[0, 12], [7, 12], null, [7, 2.5], [12, 2.5]]])

    #     @plotSpeed.draw()
    #     setTimeout(update, 4000)
    updateSpeed: =>
        d = [[0, 12], [7, 12], null, [7, 2.5], [12, 2.5]]
        $.plot("#speedChart", [ d ])

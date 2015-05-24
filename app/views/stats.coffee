CarModel = require '../models/car'
Api = require '../models/api'
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


    getEngineData: (cb) =>
        Api.getEngineData "SK014", moment().subtract(24, 'hours').format("YYYY-MM-DD HH:mm"), moment().format("YYYY-MM-DD HH:mm"), (data) =>
            ret = []
            for x in data
                ret.push({time: x.GPStime, rpm: x.RPM})
            cb(ret) 

    updateSpeed: =>
        @getEngineData (data) =>
            new Morris.Line({
                element: 'myfirstchart',
                data: data,
                xkey: 'time',
                ykeys: ['rpm'],
                labels: ['Value']
            })

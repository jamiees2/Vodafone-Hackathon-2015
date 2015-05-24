CarModel = require '../models/car'
Api = require '../models/api'
module.exports = class StatView extends Backbone.View
    el: "section.app"
    initialize: =>
        console.log 'Stat View'
        @car = new CarModel("SK014")
        @updateSpeed()
        @updateAvgFuel()
        @updateFuelCost()

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

    getEngineData: (cb) =>
        Api.getEngineData "SK014", moment().subtract(24, 'hours').format("YYYY-MM-DD HH:mm"), moment().format("YYYY-MM-DD HH:mm"), (data) =>
            ret = []
            for x in data
                ret.push({time: x.GPStime, rpm: x.RPM})
            cb(ret)

    updateSpeed: =>
        @getEngineData (data) =>
            new Morris.Line({
                element: 'rpmchart',
                data: data,
                xkey: 'time',
                ykeys: ['rpm'],
                labels: ['RPM']
            })

    getAvgFuel: (cb) =>
        Api.getTripsData "SK014", moment().subtract(3, 'days').format("YYYY-MM-DD HH:mm"), moment().format("YYYY-MM-DD HH:mm"), (data) =>
            ret = []
            for x in data
                ret.push({time: x.StartTime, avgfuel: x.AvgFuel})
            cb(ret)

    updateAvgFuel: =>
        @getAvgFuel (data) =>
            new Morris.Line({
                element: 'avgfuelchart',
                data: data,
                xkey: 'time',
                ykeys: ['avgfuel'],
                labels: ['Average']
            })

    getFuelCost: (cb) =>
        Api.getTripsData "SK014", moment().subtract(3, 'days').format("YYYY-MM-DD HH:mm"), moment().format("YYYY-MM-DD HH:mm"), (data) =>
            ret = []
            sumCost = 0
            sumKm = 0
            sumTimeMs = 0
            for x in data
                ms = moment(x.EndTime,"DD/MM/YYYY HH:mm:ss").diff(moment(x.StartTime,"DD/MM/YYYY HH:mm:ss"))
                sumTimeMs += moment.duration(ms)
                sumCost += x.Fuel * 221
                sumKm += parseInt(x.Km)
                ret.push({time: x.StartTime, cost: Math.round(x.Fuel * 221), km: x.Km})
            cb({"sumCost": Math.round(sumCost), "sumKm": sumKm, "sumTime": moment.utc(sumTimeMs).format("HH:mm:ss"), "data": ret})

    updateFuelCost: =>
        @getFuelCost (data) =>
            new Morris.Line({
                element: 'fuelcostchart',
                data: data.data,
                xkey: 'time',
                ykeys: ['cost', 'km'],
                labels: ['ISK', 'KM']
            })
            $("#sumCost").text("Total Cost: " + data.sumCost + "Kr")
            $("#sumKm").text("Total KM Driven: " +data.sumKm)
            $("#sumTime").text("Total Drive Time: " + data.sumTime)

    getSpeed: (cb) =>
        Api.getPositionHistory "SK014", moment().subtract(24, 'hours').format("YYYY-MM-DD HH:mm"), moment().format("YYYY-MM-DD HH:mm"), (data) =>
            ret = []
            points = 0
            sum = 0
            max = -1
            for x in data
                if max == -1 or x.Speed > max
                    max = x.Speed
                if x.Speed != "0"
                    sum += parseInt(x.Speed)
                    points++
                ret.push({time: x.GPStime, speed: x.Speed})
            cb({"maxSpeed": max, "avgSpeed": Math.round(sum/points),"data": ret})

    updateSpeed: =>
        @getSpeed (data) =>
            new Morris.Line({
                element: 'speedchart',
                data: data.data,
                xkey: 'time',
                ykeys: ['speed'],
                labels: ['KM/H']
            })
            $("#maxSpeed").text("Top Speed: " + data.maxSpeed)
            $("#avgSpeed").text("Average Speed: " + data.avgSpeed)

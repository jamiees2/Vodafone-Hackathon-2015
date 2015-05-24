Api = require '../models/api'
Trip = require '../models/trip'
module.exports = class TripCollection extends Backbone.Collection
    model: Trip
    initialize: (args, reg) =>
      @reg = reg
    fetchRecent: =>
      @fetch(moment().subtract(15, 'hours').format("YYYY-MM-DD HH:mm"), moment().format("YYYY-MM-DD HH:mm"))
    fetch: (from, to) =>
        Api.getTripsData @reg, from, to, (data) =>
            @reset(data)
    getStatistics: =>
        sum = (seq) => _.reduce(seq, ((a,b) => a+b), 0)
        mul = (seq) => _.reduce(seq, ((a,b) => a*b), 1)
        jmul = (seq, seq2) => _.map(_.zip(seq, seq2), mul)
        average = (seq) => sum(seq) / seq.length
        waverage = (seq, seq2) => sum(jmul(seq, seq2)) / sum(seq2)
        console.log 218 * (sum @map (i) => parseFloat i.get("Fuel"))
        return {
            totalDistance: sum @map (i) => parseFloat i.get("Km")
            totalFuel: sum @map (i) => parseFloat i.get("Fuel")
            avgFuel: waverage (@map (i) => (parseFloat i.get("AvgFuel"))), @map (i) => parseFloat i.get("Km")
            totalCost: 221 * (sum @map (i) => parseFloat i.get("Fuel"))
        }

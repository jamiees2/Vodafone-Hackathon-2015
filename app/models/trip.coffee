Api = require "./api"
module.exports = class TripModel extends Backbone.Model
    getPositions: (cb) =>
        console.log(@toJSON())
        return cb(@positions) if @positions?
        @reg = @get("RegNumber")
        from = @get("StartTime")
        to = @get("EndTime")
        Api.getPositionHistory @reg, from, to, (data) =>
            @positions = data
            cb(data)

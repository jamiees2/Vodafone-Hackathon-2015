Api = require "./api"
module.exports = class TripModel extends Backbone.Model
    initialize: =>
        @on("change:positions", @updateGeocoding)
        @fetchPositions()
        @geocoder = new google.maps.Geocoder()
    updateGeocoding: =>
        return unless @get("positions")? and @get("positions").length > 0
        startPos = @get("positions")[0]
        endPos = @get("positions")[@get("positions").length - 1]
        l = new google.maps.LatLng(startPos.Lat, startPos.Lon)
        @geocoder.geocode {'latLng': l}, (results, s) =>
            return console.log("Error geocoding") unless s == google.maps.GeocoderStatus.OK
            if results[1]?
                @set("ToAddress", results[1].formatted_address)

        l = new google.maps.LatLng(endPos.Lat, endPos.Lon)
        @geocoder.geocode {'latLng': l}, (results, s) =>
            return console.log("Error geocoding") unless s == google.maps.GeocoderStatus.OK
            if results[1]?
                @set("FromAddress", results[1].formatted_address)

    fetchPositions: (cb) =>
        return cb(@get("positions")) if cb? and @get("positions")?
        @reg = @get("RegNumber")
        from = @get("StartTime")
        to = @get("EndTime")
        return unless from? and to?
        @once("change:positions", cb)
        Api.getPositionHistory @reg, from, to, (data) =>
            @set("positions", data)

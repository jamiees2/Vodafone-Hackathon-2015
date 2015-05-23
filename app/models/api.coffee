class ApiModel
    constructor: () ->

    key: "LLqRyv3hB427bIyRkiUg=="
    base: "https://insolica.com/API/"

    url: (@request) ->
        return base + @request + "&key=" + key

    getPosition: (@regNumber) ->
        $.get(url("getposition?RegNumber=#{@regNumber}"), (data) ->
            return data
        )

    getEngineData: (@regNumber, @from, @to) ->
        $.get(url("getenginedata?RegNumber=#{@regNumber}&from=#{@from}&to=#{@to}"), (data) ->
            return data
        )

    getTripsData: (@regNumber, @from, @to) ->
        $.get(url("gettripsdata?RegNumber=#{@regNumber}&from=#{@from}&to=#{@to}"), (data) ->
            return data
        )

    getPositionHistory: (@regNumber, @from, @to) ->
        $.get(url("getpositionhistory?RegNumber=#{@regNumber}&from=#{@from}&to=#{@to}"), (data) ->
            return data
        )

    getGeofenceEvents: (@regNumber, @from, @to) ->
        $.get(url("getgeofenceevents?RegNumber=#{@regNumber}&from=#{@from}&to=#{@to}"), (data) ->
            return data
        )

    getGeofenceStatus: (@regNumber) ->
        $.get(url("getgoefencestatus?RegNumber=#{@regNumber}"), (data) ->
            return data
        )

    setGeofenceStatus: (@regNumber, @geofence1) ->
        $.get(url("setgeofencestatus?RegNumber=#{@regNumber}&GeoFence1=@geofence1"), (data) ->
            return data
        )

    getVehicleInfo: (@regNumber) ->
        $.get(url("getvehicleinfo?RegNumber=#{@regNumber}"), (data) ->
            return data
        )

module.exports = new ApiModel

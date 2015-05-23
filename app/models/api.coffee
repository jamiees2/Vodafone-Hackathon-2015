class ApiModel
    constructor: () ->

    key: "LLqRyv3hB427bIyRkiUg=="
    base: "https://insolica.com/API/"

    url: (@request) ->
        return @base + @request + "&key=" + @key + "&cache_bust=" + Date.now()

    getPosition: (@regNumber, cb) ->
        $.getJSON(@url("getposition/?RegNumber=#{@regNumber}"), (data) ->
            cb(data)
        )

    getEngineData: (@regNumber, @from, @to, cb) ->
        $.getJSON(@url("getenginedata/?RegNumber=#{@regNumber}&from=#{@from}&to=#{@to}"), (data) ->
            cb(data)
        )

    getTripsData: (@regNumber, @from, @to, cb) ->
        $.getJSON(@url("gettripsdata/?RegNumber=#{@regNumber}&from=#{@from}&to=#{@to}"), (data) ->
            cb(data)
        )

    getPositionHistory: (@regNumber, @from, @to, cb) ->
        $.getJSON(@url("getpositionhistory/?RegNumber=#{@regNumber}&from=#{@from}&to=#{@to}"), (data) ->
            cb(data)
        )

    getGeofenceEvents: (@regNumber, @from, @to, cb) ->
        $.getJSON(@url("getgeofenceevents/?RegNumber=#{@regNumber}&from=#{@from}&to=#{@to}"), (data) ->
            cb(data)
        )

    getGeofenceStatus: (@regNumber, cb) ->
        $.getJSON(@url("getgoefencestatus/?RegNumber=#{@regNumber}"), (data) ->
            cb(data)
        )

    setGeofenceStatus: (@regNumber, @geofence1, cb) ->
        $.getJSON(@url("setgeofencestatus/?RegNumber=#{@regNumber}&GeoFence1=@geofence1"), (data) ->
            cb(data)
        )

    getVehicleInfo: (@regNumber, cb) ->
        $.getJSON(@url("getvehicleinfo/?RegNumber=#{@regNumber}"), (data) ->
            cb(data)
        )

module.exports = new ApiModel

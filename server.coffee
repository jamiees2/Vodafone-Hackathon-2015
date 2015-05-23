express = require 'express'
app = express()
exports
app.use express.static "#{__dirname}/public"

app.get '/', (req, res) -> 
    res.sendfile 'index.html'
exports.startServer = (port,path,callback) ->
    app.listen port, ->
        console.log "Listening on port #{port}"
        callback()

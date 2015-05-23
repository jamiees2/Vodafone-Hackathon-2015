express = require 'express'
app = express()
app.use express.static "#{__dirname}/public"

app.get '*', (req, res) -> 
    res.sendFile 'index.html'
exports.startServer = (port,path,callback) ->
    app.listen port, ->
        console.log "Listening on port #{port}"
        callback()

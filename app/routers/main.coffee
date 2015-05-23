class MainRouter extends Backbone.Router
    routes:
        '': 'index'

    index: ->
        App = require 'views/app'
        app = new App()

main = new MainRouter()
module.exports = main

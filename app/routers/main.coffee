class MainRouter extends Backbone.Router
    routes:
        '': 'index'

    index: ->
        IndexView = require 'views/index'
        index = new IndexView()
        index.launch()

main = new MainRouter()
module.exports = main

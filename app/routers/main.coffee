class MainRouter extends Backbone.Router
    routes:
        '': 'index'

    index: ->
        IndexView = require 'views/index'
        index = new IndexView()
        $("section.app").html(index.render().$el)

main = new MainRouter()
module.exports = main

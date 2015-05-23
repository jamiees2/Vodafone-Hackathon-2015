module.exports = class AppView extends Backbone.View
    el: 'section.app'

    initialize: ->
        Index = require 'views/index'
        @IndexView = new Index()
        @IndexView.render()

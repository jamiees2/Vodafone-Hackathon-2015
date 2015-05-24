# Load App Helpers
require 'lib/helpers'

# Initialize Router
main = require 'routers/main'

window.CAR = "SK014"

$ ->
    # Initialize Backbone History
    Backbone.history.start pushState: yes
    console.log "screw you :3"
    # Fix the tab stupidness
    $(".tabs").tabs("select_tab",Backbone.history.fragment)
    $(".tabs a").on 'click', ->
        main.navigate($(this).attr('data-href'), true)


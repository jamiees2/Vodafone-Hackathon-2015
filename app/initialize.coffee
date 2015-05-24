# Load App Helpers
require 'lib/helpers'

# Initialize Router
main = require 'routers/main'

localStorage["CAR"] = "SK014" unless localStorage["CAR"]
window.CAR = localStorage["CAR"] if localStorage["CAR"]?

$ ->
    # Initialize Backbone History
    Backbone.history.start pushState: yes
    console.log "screw you :3"
    # Fix the tab stupidness
    $(".tabs").tabs("select_tab",Backbone.history.fragment)
    $(".tabs a").on 'click', ->
        main.navigate($(this).attr('data-href'), true)


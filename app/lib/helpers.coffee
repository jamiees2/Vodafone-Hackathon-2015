# Tell Swag where to look for partials
Swag.Config.partialsPath = '../views/templates/'
Swag.registerHelpers()

# Put your handlebars.js helpers here.
Handlebars.registerHelper 'fromNow', (context, block) ->
    return moment(context).fromNow()

Handlebars.registerHelper 'duration', (a, b) ->
    moment.duration(moment(a).diff(moment(b))).humanize()

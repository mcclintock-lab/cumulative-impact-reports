OverviewTab = require './overview.coffee'
AdjustedImpactsTab = require './adjustedImpacts.coffee'


window.app.registerReport (report) ->
  report.tabs [OverviewTab, AdjustedImpactsTab]
  # path must be relative to dist/
  report.stylesheets ['./cumulativeImpact.css']

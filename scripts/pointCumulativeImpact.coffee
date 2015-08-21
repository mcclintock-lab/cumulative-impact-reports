PointOverviewTab = require './pointOverview.coffee'


window.app.registerReport (report) ->
  report.tabs [PointOverviewTab]
  # path must be relative to dist/
  report.stylesheets ['./cumulativeImpact.css']

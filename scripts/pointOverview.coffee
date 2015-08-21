ReportTab = require 'reportTab'
templates = require '../templates/templates.js'



class PointOverviewTab extends ReportTab
  name: 'Cell Value for Cumulative Impacts'
  className: 'pointOverview'
  timeout: 120000
  template: templates.pointOverview
  dependencies: ['BSRCumulativeImpactsPointSummary']

  render: () ->
    isCollection = @model.isCollection()
    split_scores = @recordSet('BSRCumulativeImpactsPointSummary', 'SplitScores').toArray()
    summed_scores = @recordSet('BSRCumulativeImpactsPointSummary', 'Scores').toArray()
    console.log("split: ", split_scores)
    console.log("summed: ", summed_scores)
    # setup context object with data and render the template from it
    context =
      sketch: @model.forTemplate()
      sketchClass: @sketchClass.forTemplate()
      attributes: @model.getAttributes()
      admin: @project.isAdmin window.user
      split_scores: split_scores

    @$el.html @template.render(context, templates)

module.exports = PointOverviewTab
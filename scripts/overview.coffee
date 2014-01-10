ReportTab = require 'reportTab'
templates = require '../templates/templates.js'



class OverviewTab extends ReportTab
  name: 'Overview'
  className: 'overview'
  timeout: 120000
  template: templates.overview
  dependencies: ['CumulativeImpact']

  render: () ->
    isCollection = @model.isCollection()
    cumulativeImpact = @recordSet('CumulativeImpact', 'CumulativeImpact').toArray()

    console.log("here!!!!", cumulativeImpact)
    # setup context object with data and render the template from it
    context =
      sketch: @model.forTemplate()
      sketchClass: @sketchClass.forTemplate()
      attributes: @model.getAttributes()
      admin: @project.isAdmin window.user
      cumulativeImpact: cumulativeImpact

    @$el.html @template.render(context, templates)

module.exports = OverviewTab
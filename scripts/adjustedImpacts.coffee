ReportTab = require 'reportTab'
templates = require '../templates/templates.js'



class AdjustedImpactsTab extends ReportTab
  name: 'Adjusted Impacts'
  className: 'adjustedImpactsTab'
  timeout: 240000
  template: templates.adjustedImpacts 
  dependencies: ['AdjustedCumulativeImpact']

  render: () ->
    isCollection = @model.isCollection()
    
    try
      adjustedCumulativeImpact = @recordSet('AdjustedCumulativeImpact', 'AdjustedCumulativeImpact').toArray()
      console.log("aci:", adjustedCumulativeImpact)
      hasAdjustedCumulativeImpacts = adjustedCumulativeImpact?.length >= 1
      console.log("has adus:", hasAdjustedCumulativeImpact)
    catch e
      hasAdjustedCumulativeImpact = false
      console.log("boom", e)
    # setup context object with data and render the template from it
    context =
      sketch: @model.forTemplate()
      sketchClass: @sketchClass.forTemplate()
      attributes: @model.getAttributes()
      admin: @project.isAdmin window.user
      adjustedCumulativeImpact: adjustedCumulativeImpact
      hasAdjustedCumulativeImpacts: hasAdjustedCumulativeImpacts

    @$el.html @template.render(context, templates)

module.exports = AdjustedImpactsTab
ReportTab = require 'reportTab'
templates = require '../templates/templates.js'



class PointOverviewTab extends ReportTab
  name: 'Cell Value for Cumulative Impacts'
  className: 'pointOverview'
  timeout: 120000
  template: templates.pointOverview
  dependencies: ['BSRImpacts']

  render: () ->
    isCollection = @model.isCollection()
    split_scores = @recordSet('BSRImpacts', 'SplitScore').toArray()
    summed_scores = @recordSet('BSRImpacts', 'Score').toArray()
    stressor_names = { "DDF_IMP":"Demersal destructive fishing","DND_HB_IMP":"Demersal nondestuctive high bycatch","DND_LB_IMP":"Demersal nondestructive low bycatch", "NI_IMP":"Fertilizer","OP_IMP":"Pesticides","OA_IMP":"Ocean acidification", "PHB_IMP":"Pelaigc low bycatch","CA_IMP":"Shipping", "CC_SST_IMP":"Climate change, sea surface temperature","CC_UV_IMP": "Climate change, uv", "CC_SLR_IMP":"Climate change, sea level rise","MP_IMP": "Marine plastics"}
    habitat_names = {"BCH_ECO":"Beach", "SFR_ECO":"Suspension Feeder Reef","SM_ECO":"Salt Marsh","SSLOPE_ECO":"Soft Slope","RI_ECO":"Rocky Intertidal","IM_ECO":"Intertidal Mud","RR_ECO":"Rocky Reef","HS_ECO":"Hard Shelf","SBSB_ECO":"Subtidal soft bottom","SSHELF_ECO":"Soft Shelf","SW_ECO":"Surface waters","DW_ECO":"Deep waters"}

    found_stressors = {}
    stressor_scores = {}

    for score in split_scores
      score.SNAME = stressor_names[score.STRESS]
      score.HNAME = habitat_names[score.HAB]
      score.SCORE = Number(score.SCORE).toFixed(2)
      currfs = found_stressors[score.SNAME]


      if isNaN(currfs)
        found_stressors[score.SNAME] = 1
        stressor_scores[score.SNAME] = Number(score.SCORE)
        score.first = true
      else
        curr_num = found_stressors[score.SNAME]
        found_stressors[score.SNAME] = Number(curr_num)+1
        curr_score = stressor_scores[score.SNAME]
        stressor_scores[score.SNAME] = Number(curr_score)+Number(score.SCORE)
        score.first = false

    
    for score in split_scores
      currnum = found_stressors[score.SNAME]
      currscore = stressor_scores[score.SNAME]
      score.NUM_STRESSORS = currnum
      score.STRESSOR_SCORE = Number(currscore).toFixed(2)

    total_score = 0.0
    keys = Object.keys(stressor_scores)
    for key in keys
      total_score+=Number(stressor_scores[key])

    total_score = Number(total_score).toFixed(2)
    # setup context object with data and render the template from it
    context =
      sketch: @model.forTemplate()
      sketchClass: @sketchClass.forTemplate()
      attributes: @model.getAttributes()
      admin: @project.isAdmin window.user
      split_scores: split_scores
      total_score: total_score

    @$el.html @template.render(context, templates)


module.exports = PointOverviewTab
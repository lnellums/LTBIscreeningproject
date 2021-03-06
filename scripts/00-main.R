# ********************************
# project: LTBI screening
# N Green
# Oct 2016
#
# high-level script


# set-up ---------------------------------------------------------------

source("scripts/01aa-data-prep_constants-GLOBAL.R", echo = TRUE)
source("scripts/01cc-data-prep_modelling-GLOBAL.R", echo = TRUE)


# modelling ------------------------------------------------------------

if (!cluster) source("scripts/02-parallel-decision-tree.R", echo = TRUE)
if (cluster)  source("Q:/R/cluster--LTBI-decision-tree/cluster-master.R")

source("scripts/04c-cost-effectiveness_QALY-costs.R", echo = TRUE)
source("scripts/04-combine_dectree_and_cmprk_model_output.R", echo = TRUE)


# output plots/tables --------------------------------------------------

source("scripts/05b-output-plots_cost-effectiveness.R")
source("scripts/05i-output-tables.R")
source("scripts/05-ceac-plot.R")
source("scripts/05-net-benefit.R")
source("scripts/05-netbenefit-threshold-analysis.R")
# source("scripts/05-ternary plots.R")
source("scripts/05f-tornado_plots.R")
source("scripts/05-bayesglm_predictions.R")
# source("scripts/05-stan_predictions.R")
source("scripts/05-partial_correlation_coefficients.R")
source("scripts/05-num_subset_dectree.R")
source("scripts/05-CE_plane_trajectories.R")
source("scripts/05-upper_triangle_contour_INMB.R")

# source("scripts/05-aTB_histograms.R")
# source("scripts/05a-output-plots_competing-risks.R")
# source("scripts/05e-output-plots_cost-effectiveness_active-TB-cases.R")
# source("scripts/05g-INMB_ICER_histograms.R")
# source("scripts/05h-CE_summary_stats.R")
# source("scripts/05j-stat_pop_year_plots.R")
# source("scripts/05k-other-C-E-plots.R")
# source("scripts/05l-output-plots_twoway-sensitivity-analysis.R")
# source("scripts/05-pop_count_histograms.R")
# source("scripts/05-plot-pop_QALYloss_over_time.R")


# clean-up session -----------------------------------------------------
# if (grepl("temp", diroutput, ignore.case = TRUE))
#   unlink(diroutput)

#**************************************************************************
# project: LTBI screening
# N Green
# Oct 2016
#
# simulation specific constants


# global sensitivity parameters -------------------------------------------

# or read in scenarios environments
if (exists("global_run")) {

  incidence_grps_screen <- get("incidence_grps_screen", envir = eval(parse(text = global_params_scenarios_ls[global_run])))
  min_screen_length_of_stay <- get("min_screen_length_of_stay", envir = eval(parse(text = global_params_scenarios_ls[global_run])))
  ENDPOINT_cost <- get("ENDPOINT_cost", envir = eval(parse(text = global_params_scenarios_ls[global_run])))

}else{

  # select which paramter file for decision tree
  study <-  "QFT" #"twoway" #"oneway" "TSPOT" "HALT"

  # which incidence groups to screen
  incidence_grps_screen <- c("(0,50]", "(50,150]", "(150,250]", "(250,350]", "(350,1e+05]") #full set
  # incidence_grps_screen <- c("(150,250]", "(250,350]", "(350,1e+05]")
  # incidence_grps_screen <- c("(250,350]", "(350,1e+05]")

  min_screen_length_of_stay <- 0 #years #5

  # include costs for individuals once they've left (i.e. to death)?
  ENDPOINT_cost <- "exit uk" #"death"
}


# folder locations --------------------------------------------------------

# parameter_values_file <- system.file("data", sprintf("scenario-parameter-values_%s.xlsx", study),
#                                      package = "LTBIscreeningproject")

parameter_values_file <- system.file("data", "scenario-parameter-values.xlsx",
                                     package = "LTBIscreeningproject")

# # create permanent output folder
parent_folder <- sprintf("ext-data/%d_to_%d_in_%s", min(screen_age_range), max(screen_age_range), year_cohort)
diroutput <- sprintf("%s/%s", parent_folder, global_params_scenarios_ls[global_run])
dir.create(parent_folder, showWarnings = FALSE)
dir.create(diroutput, showWarnings = FALSE)

# create temporary output folder
# diroutput <- tempdir()

plots_folder <- system.file("output", "plots",
                            package = "LTBIscreeningproject")
plots_folder_scenario <- sprintf("%s/%s", plots_folder, global_params_scenarios_ls[global_run])
dir.create(plots_folder_scenario, showWarnings = FALSE)

cluster_output_filename <- sprintf("decisiontree-results_%s_%s.rds", global_params_scenarios_ls[global_run],
                                   format(Sys.time(), "%Y-%m-%d %I-%p"))

#**********************************************
# LTBI screening
# N Green
#
# create environments for each set of global
# parameter values in scenarios as inputs


incidence_list <-  list(c("(0,50]", "(50,150]", "(150,250]", "(250,350]", "(350,1e+05]"),
                        c("(150,250]", "(250,350]", "(350,1e+05]"),
                        c("(250,350]", "(350,1e+05]"))

endpoints <- c("death", "exit uk")

programme_scenarios_lookup <- data.frame()
programme_level <- 1

for (min_screen_length_of_stay in c(0,5)) {
  for (incidence in 1:length(incidence_list)) {
      for (endpoint_cost in endpoints) {

        programme_scenarios_lookup <- rbind(programme_scenarios_lookup,
                                            cbind(scenario = formatC(programme_level, width = 3, format = "d", flag = "0"),
                                                  min_screen_length_of_stay,
                                                  incid_grps = as.character(incidence_list[incidence]),
                                                  endpoint_cost))

        environ_name <- sprintf("programme_level_scenario_%s", formatC(programme_level, width = 3, format = "d", flag = "0"))

        assign(x = environ_name, value = new.env())
        assign(x = "min_screen_length_of_stay", value = min_screen_length_of_stay, envir = eval(parse(text = environ_name)))
        assign(x = "incidence_grps_screen", value = incidence_list[[incidence]], envir = eval(parse(text = environ_name)))
        assign(x = "ENDPOINT_cost", value = endpoint_cost, envir = eval(parse(text = environ_name)))

        programme_level %<>%  add(1)
    }
  }
}


write.csv(programme_scenarios_lookup, file = "ext-data/programme-level-scenarios-inputs.csv")

rm(list = ls()[!ls() %in% ls(pattern = "programme_level_scenario")])

save.image(file = "data/global-parameters-scenarios.RData")

global_params_scenarios_ls <- ls()
save(global_params_scenarios_ls, file = "data/global-parameters-scenarios_ls.RData")


# generate a fixed cohort
# only need to run this once

data("051206 - IMPUTED_sample")

# 1) define and clean data ---------------------------------------------

source("scripts/01a-data-prep_simulation-constants.R", echo = TRUE)
source("scripts/01b-data-prep_cost-effectiveness.R", echo = TRUE)
source("scripts/01c-data-prep_modelling.R", echo = TRUE)

# 4) event times estimation --------------------------------------------

source("scripts/04a_1-active-TB-extrapolation.R")
source("scripts/04a_2-active-TB-imputation.R")
source("scripts/04a_3-include-new-tb-events.R")

save.image(file = "ext-data/LTBI_input_workspace.RData")

#' Calculate QALYs for UK Active TB Cases
#'
#' Calculate the QALYs for each active TB individuals for each of 3 alternatives:
#'  * diseasefree: to all-cause death
#'  * fatality: case-fatality 12 months from notification
#'  * cured: successfully treated
#'
#' Assume that death if it happens is within the first year of active TB.
#' Assume that active TB cases when treated and survive first year are fully cured.
#'
#' Consider person-perspective (death) or NHS-perspective (exit uk)
#' by defining the particular time-to-event end point.
#'
#' @param timetoevent Time (in years) from notification to final event (death)
#' @param utility.disease_free Utility value of non-diseased individual
#' @param utility.case Utility value of diseased individual
#' @param age Ages in years
#' @param start_delay What time delay to origin, to shift discounting
#' @param ... Additional arguments
#'
#' @return list of diseasefree, death, cured QALYs
#' @export
#'
#' @examples
#'
calc_QALY_tb <- function(timetoevent,
                         utility.disease_free = 1,
                         utility.case,
                         age,
                         start_delay = 0,
                         ...){

  if (utility.disease_free < 0 | utility.disease_free > 1)
    stop("Utility of disease free must be between 0 and 1")

  if (utility.case < 0 | utility.case > 1)
    stop("Utility of cases must be between 0 and 1")

  if (is.list(timetoevent)) {
    timetoevent <- unlist(timetoevent) %>% unname()
  }

  timetoevent[timetoevent < 0] <- 0

  diseasefree <- QALY::calc_QALY_population(utility = utility.disease_free,
                                            time_horizons = timetoevent,
                                            age = age,
                                            start_delay = start_delay)

  fatality <- QALY::calc_QALY_population(utility = utility.case,
                                         time_horizons = pmin(timetoevent, 0.5), #ie 6 months
                                         age = age,
                                         start_delay = start_delay)


  cured <- QALY::calc_QALY_population(utility = c(utility.case, utility.disease_free),
                                      time_horizons = timetoevent,
                                      age = age,
                                      start_delay = start_delay)

  #otherwise cured is better than disease_free
  for (i in seq_along(timetoevent)) {

    cured[i] <-
      if (timetoevent[i] < 1) {
        fatality[i]
      } else {
        cured[i]
      }
  }

  return(list(diseasefree = diseasefree,
              fatality = fatality,
              cured = cured))
}

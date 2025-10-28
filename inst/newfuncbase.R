
# 1) Check ggplot code and see which geom/stat are used

# 2) If stat is used, Make new R file with:
#  --------- STAT ---------

#' @importFrom ggplot2 ggproto Stat***
#' @rdname geom_***_sample
#' @format NULL
#' @usage NULL
#' @export
Stat***Sample <- ggplot2::ggproto("Stat***Sample", ggplot2::Stat***,
                                  setup_data = function(data, params) {
                                    sample_expand(data, params$times) 
                                    },
                                  
                                  extra_params = c("na.rm", "times")
)

#' @export
#' @rdname geom_count_sample
#' @inheritParams ggplot2::stat_sum
#' @param times A parameter used to control the number of values sampled from each distribution. By default, times is set to 30.
stat_sum_sample <- make_constructor(StatSumSample, geom = "point", times = 10)




# 3) Make new geom in a new R file with:

#  --------- GEOM ---------

#' Uncertain ***
#' 
#' Identical to geom_***, except that it will accept a distribution in place of any of the usual aesthetics.
#' 
#' @inheritParams ggplot2::geom_***
#' @importFrom ggplot2 make_constructor Geom***
#' @param times A parameter used to control the number of values sampled from each distribution.
#' @examples
#' print("replace me")
#' @export
geom_***_sample <- make_constructor(ggplot2::Geom***, stat = "***_sample", times=10)


# 4) Test function. First open a test file with
# usethis::use_test()

# Get geom examples with ?geom_* and populate test file

# ################ PASS #################
# ############### FAIL #################
# ############## UNTESTED #################

# Once sorted, properly write passing tests up in:

# ---------- TEST FILE ---------
library(vdiffr)

test_that("geom_**_sample tests", {

  set.seed(***)
  
  p* <- ggplot()
  expect_doppelganger("example1", p1)

}
)



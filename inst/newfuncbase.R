
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
                                    dibble_to_tibble(data, params) 
                                    },
                                  
                                  extra_params = c("na.rm", "times")
)

#' @export
#' @rdname geom_***_sample
#' @inheritParams ggplot2::stat_***
#' @param times A parameter used to control the number of values sampled from each distribution.
stat_***_sample <- make_constructor(Stat***Sample, geom = "***", times = 10)


### IF THE STAT USES SETUP DATA ADD
ggproto_parent(Stat**, self)$setup_data(data, scales)

### REMEMBER TO ADD PARAMS TO EXTRA PARAMS!!!


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
  expect_doppelganger("Example 1", p1)

}
)



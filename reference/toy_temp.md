# A toy data set that has the ambient temperature as measured by a collection of citizen scientists for each Iowa county

There are several measurements for each county, with no location marker
for individual scientists to preserve anonyminity. Counties can have
different numbers of observations as well as a different levels of
variance between the observations in the county.

## Format

A tibble with 99 observations and 4 variables

- county_name:

  the name of each Iowa county

- recorded_temp:

  the ambient temperature recorded by the citizen scientist

- scientistID:

  the ID number for the scientist who made the recording

- county_geometry:

  the shape file for each county of Iowa

- county_longitude:

  the centroid longitude for each county of Iowa

- county_latitude:

  the centroid latitude for each county of Iowa

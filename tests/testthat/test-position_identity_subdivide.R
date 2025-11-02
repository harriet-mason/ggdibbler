library(ggplot2)
library(distributional)
library(dplyr)
ids <- factor(c("1.1", "2.1", "1.2", "2.2", "1.3", "2.3"))

values <- data.frame(
  id = ids,
  value = c(3, 3.1, 3.1, 3.2, 3.15, 3.5)
)
positions <- data.frame(
  id = rep(ids, each = 4),
  x = c(2, 1, 1.1, 2.2, 1, 0, 0.3, 1.1, 2.2, 1.1, 1.2, 2.5, 1.1, 0.3,
        0.5, 1.2, 2.5, 1.2, 1.3, 2.7, 1.2, 0.5, 0.6, 1.3),
  y = c(-0.5, 0, 1, 0.5, 0, 0.5, 1.5, 1, 0.5, 1, 2.1, 1.7, 1, 1.5,
        2.2, 2.1, 1.7, 2.1, 3.2, 2.8, 2.1, 2.2, 3.3, 3.2)
)
#' Currently we need to manually merge the two together
datapoly <- merge(values, positions, by = c("id"))
# Make uncertain version of datapoly
 uncertain_datapoly <- datapoly |>
  mutate(value = dist_uniform(value-0.1, value + 0.1))

#' ggplot(datapoly, aes(x = x, y = y)) +
#'   geom_polygon_sample(aes(group = id), fill=NA, colour="black",
#'                       position = "identity_subdivide")
#' 
#' ggplot(uncertain_datapoly, aes(x = x, y = y)) +
#'   geom_polygon_sample(aes(fill = value, group = id), alpha=0.1,
#'                       position = "identity_subdivide")


# simple case
simple <- uncertain_datapoly |> filter(id=="1.1")
ggplot(simple, aes(x = x, y = y)) +
  geom_polygon_sample(aes(fill = value, group = id), alpha=0.1,
                      position = "identity_subdivide")


library(sf)
set.seed(999)
xy = data.frame(x=runif(24), y=runif(24))
xy$ID = rep(1:6, each = 4)
head(xy)

xys = st_as_sf(xy, coords=c("x","y"))

polys = xys %>% 
  dplyr::group_by(ID) %>% 
  dplyr::summarise() %>%
  st_cast("POLYGON")

####################################################################################################
# Check
times = 10
d = square_grid(times)

check <- sample_expand(simple, times) |>
  dplyr::mutate(sub_group = 
                as.factor(1 + as.numeric(drawID) %% as.numeric(id)))

values <- check |>
  select(-c(x,y))

base_polygon <- check|>
  dplyr::filter(drawID==1) |>
  dplyr::group_by(sub_group) |>
  sf::st_as_sf(coords=c("x","y")) |>
  summarise(do_union=FALSE) |>
  sf::st_cast("POLYGON") 

grid_points <- base_polygon |>
  dplyr::reframe(
    geometry = subdivide(geometry, d=d)) |>
  sf::st_as_sf() |>
  sf::st_coordinates() |>
  as_tibble() |>
  rename("x" = "X", "y" = "Y",
         "sub_group" = "L1", "drawID" = "L2") |>
  mutate(sub_group = factor(x = sub_group, levels = levels(values$sub_group)),
         drawID = factor(x= drawID, levels = levels(values$drawID)))


plot_data <- grid_points |>
  left_join(values, by = c("sub_group", "drawID"))

ggplot(data = plot_data) + geom_polygon(aes(x,y, group=drawID, fill=value), alpha=0.5)

ggplot(data = new_check) + geom_sf(aes(geometry=geometry))

check2 <- datapoly |>
  dplyr::filter(id=="1.1") 
new_check2 <- check2 |>
  dplyr::group_by(id) |>
  #dplyr::arrange(x, -y) |>
  sf::st_as_sf(coords=c("x","y")) |>
  dplyr::summarise(do_union=FALSE) |>
  sf::st_cast("POLYGON") #|>
  #sf::st_convex_hull()

ggplot(data = new_check2) + geom_sf()

#st_convex_hull()
# |>
#   dplyr::reframe(
#     geometry = subdivide(geometry, d=d), 
#     sub_group = sub_group,
#     dplyr::across(dplyr::everything())
#   ) 


#sf::st_as_sfc() |>
#sf::st_cast("POLYGON") |>
#sf::st_sf() #|>
#sf::st_zm()
#st_cast("POLYGON") #|>
#dplyr::mutate(drawID = hold_drawID)

plot(polys)

polys = polys %>% 
  st_convex_hull()

plot(polys)

simple <- filter(polys, ID == 1)
plot(simple)

sub_simple <- subdivide(simple$geometry, d= c(2,2))
plot(sub_simple)
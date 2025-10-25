# geom_sf_sample
GeomSfSample <- ggproto("GeomSfSample", GeomSf,
                        required_aes = "geometry",
                        draw_panel = function(data, panel_params, coord, ...) {
                          
                          # which aes are only inner or outer
                          inner <- c("fill")
                          outer <- c("colour", "stroke", "linetype", "linewidth")
                          
                          # Set inner and outer SF aesthetics
                          all_names <- names(data)
                          inner_names <- all_names[!all_names %in% outer]
                          outer_names <- all_names[!all_names %in% inner]
                          
                          # make internal and external data
                          inner_df <- data |> select(any_of(inner_names))
                          outer_df <- data |> select(any_of(outer_names))
                          
                          # Return all three components
                          grid::gList(
                            GeomSf$draw_panel(inner_df, panel_params, coord, 
                                              colour=NULL, stroke=0, linetype=NULL, linewidth=0 ...),
                            GeomSf$draw_panel(outer_df, panel_params, coord, fill=NULL, ...)
                          )
                        }
                        
)

#' @export
GeomDensitySample <- ggproto(
  "GeomDensitySample", ggplot2::GeomDensity,
  default_aes = aes(
    colour = from_theme(colour %||% ink),
    fill   = from_theme(fill %||% NA),
    weight = 1,
    alpha  = NA,
    linewidth = from_theme(linewidth),
    linetype  = from_theme(linetype)
  )
)
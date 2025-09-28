# replace warning filter with ggplot filter
# Code that gives warning in ggplot2
extra_aes <- setdiff(
  mapped_aesthetics(mapping),
  c(geom$aesthetics(), stat$aesthetics(), position$aesthetics())
)
# Take care of size->linewidth aes renaming
if (geom$rename_size && "size" %in% extra_aes && !"linewidth" %in% mapped_aesthetics(mapping)) {
  extra_aes <- setdiff(extra_aes, "size")
  deprecate_warn0("3.4.0", I("Using `size` aesthetic for lines"), I("`linewidth`"), user_env = user_env)
}
if (check.aes && length(extra_aes) > 0) {
  cli::cli_warn("Ignoring unknown aesthetics: {.field {extra_aes}}", call = call_env)
}
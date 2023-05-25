# explorando os resultados de omniscape. ----
library(terra)
library(here)
# resistencia original
res_bra <- terra::rast("scripts/2_omniscape_julia/resistencia_resampled.tif")
plot(res_bra, col = viridis::viridis(8, direction = -1))
plot(bra_res, col = viridis::viridis(8, direction = -1))


# new tests for the whole of Brazil
test <- "1_Brasil_900_50_3" #nome da pasta
test <- "1_Brasil_900_50_5" #nome da pasta
test <- "1_Brasil_900_100_11" #nome da pasta
cumulative_current_file <- here::here("scripts", "2_omniscape_julia", test, "cum_currmap.tif")
cummulative_current <- terra::rast(cumulative_current_file)
plot(cummulative_current,col = viridis::viridis(100))

normalized_current_file <- here::here("scripts", "2_omniscape_julia", test, "normalized_cum_currmap.tif")
normalized_current <- terra::rast(normalized_current_file)
plot(normalized_current, col = viridis::viridis(100))

norm_cut <- normalized_current
norm_cut[norm_cut > 5] <- NA
plot(norm_cut, col = viridis::viridis(4))

flow_potential_file <- here::here("scripts", "2_omniscape_julia",test, "flow_potential.tif")
flow_potential <- terra::rast(flow_potential_file)
plot(flow_potential, col = viridis::viridis(100))


omniscape_format <- function(omni_raster) {
  vals <- values(omni_raster)
  SD <- sd(vals, na.rm = T)
  MEAN <- mean(vals, na.rm = T)
  omni_reclass <- classify(omni_raster,
                           c(0,
                             MEAN - (SD/2),
                             MEAN + SD,
                             MEAN + 2 * SD,
                             max(vals,na.rm = T)))
  return(omni_reclass)
}
# Impeded
# Diffused
# Intensified
# Channelized
pal <- c("#cccccc", "#85c0cc", "#8c8c4d", "#f20000")
cum_format <- omniscape_format(cummulative_current)
norm_format <- omniscape_format(normalized_current)
plot(cum_format)
plot(norm_format)

# resistencia original

bra_res <- rast("scripts/2_omniscape_julia/Biomas_resistencia_NA.tif")

library(tmap)
tmap_mode("view")
tmap_mode("view")
#tm_shape(bra_res, name = "Resistencia original") +
 # tm_raster(palette = "Greens", style = "quantile") +
tm_shape(res_bra, name = "Resistencia reamostrada") +
  tm_raster(palette = "Greens", style = "quantile") +
  tm_shape(cummulative_current,
           name = "Cummulative") +
  tm_raster(palette = pal) +
  tm_shape(flow_potential,
           name = "Flow potential") +
  tm_raster(palette = pal) +
  tm_shape(normalized_current,
           name = "Normalized") +
  tm_raster(palette = pal)


tm_shape(res_bra, name = "Resistencia original") +
  tm_raster(palette = "Greens", style = "quantile")

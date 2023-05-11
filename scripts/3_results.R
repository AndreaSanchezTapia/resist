
#########test area default options-----
library(terra)
res <- terra::rast("scripts/2_omniscape_julia/resistencia_test_area.tif")
plot(res)
# the only test with flow potential
#test <- "test2_rad100_block_5_cutoff300"
#test <- "test2_rad200_block_5_cutoff300"
test <- "test2_rad300_block_5_cutoff300"

currmap <- terra::rast("scripts/2_omniscape_julia/output/test2_default_options/cum_currmap.tif")

cumulative_current_file <- here::here("scripts", "2_omniscape_julia", "output", test, "cum_currmap.tif")
cummulative_current <- terra::rast(cumulative_current_file)

normalized_current_file <- here::here("scripts", "2_omniscape_julia", "output", test, "normalized_cum_currmap.tif")
normalized_current <- terra::rast(normalized_current_file)

flow_potential_file <- here::here("scripts", "2_omniscape_julia", "output", test, "flow_potential.tif")
flow_potential <- terra::rast(flow_potential_file)



#map ----
library(tmap)
tmap_mode("view")
style <- "equal"

tm_basemap(c(StreetMap = "OpenStreetMap")) +
  tm_shape(res, name = "resistencia") +
    tm_raster(palette = "Greens",
              style = style
                ) +
    tm_shape(currmap,
             name = "Block 5 Cutoff 50 Raio 100"
             ) +
    tm_raster(palette = "Reds",
              style = style) +
    tm_shape(cummulative_current,
             name = "cummulative_current") +
    tm_raster(palette = "Reds",
              style = style) +
    tm_shape(normalized_current) +
    tm_raster(palette = "Reds",
              style = style) +
tm_shape(flow_potential,
         name = "Flow") +
  tm_raster(palette = "Reds",
  style = style)


vals <- values(normalized_current)
SD <- sd(vals, na.rm = T)
MEAN <- mean(vals, na.rm = T)
curr_class <- classify(normalized_current,
                       c(0,
                         MEAN - (SD/2),
                         MEAN + SD,
                         MEAN + 2 * SD,
                         max(vals,na.rm = T)))
par(mfrow = c(1,1))
plot(curr_class)
values(curr_class$normalized_cum_currmap)
# Impeded
# Diffused
# Intensified
# Channelized

#
library(terra)
res <- terra::rast("scripts/2_omniscape_julia/Biomas_resistencia.tif")
area <- terra::rast("scripts/2_omniscape_julia/resistencia_test_area.tif")
res_mask <- crop(res, area)
#max(values(res_mask), na.rm = T)

res_mask[res_mask > 120] <- NA

plot(res_mask)
#writeRaster(res_mask, "scripts/2_omniscape_julia/Biomas_resistencia_mask.tif")
res_mask2 <- terra::rast("scripts/2_omniscape_julia/Biomas_resistencia_mask.tif")

# la resistencia con kernel
kernel <- terra::rast("raw_data/new_test_area_kernel.tif")
plot(kernel)
plot(norm_resist)

norm_resist <- terra::rast("scripts/2_omniscape_julia/output/test2_default_options/normalized_cum_currmap.tif")
crop(norm_resist, area)
crop(kernel, area)
crop(kernel, area)
plot(kernel)
ke <- values(kernel)
re <- values(norm_resist)
sf::st_crs(kernel) == sf::st_crs(norm_resist)

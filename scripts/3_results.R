# explorando os resultados de omniscape. ----
## primeira rodada----
#########test area default options-----
library(terra)
# resistencia original
res <- terra::rast("scripts/2_omniscape_julia/resistencia_test_area.tif")
png("figs/resistencia_test.png")
plot(res_new, col = viridis::viridis(8, direction = -1))
dev.off()

#com kernel
res_new <- terra::rast("scripts/2_omniscape_julia/Biomas_resistencia_mask.tif")
png("figs/resistencia_test.png")
plot(res_new, col = viridis::viridis(8, direction = -1))
dev.off()

# the only test with flow potential
cumulative_current_file <- here::here("scripts", "2_omniscape_julia", "1_Biomas_resistencia_100", "cum_currmap.tif")
cummulative_current <- terra::rast(cumulative_current_file)

png("figs/current.png")
plot(cummulative_current,col = viridis::viridis(100))
dev.off()

normalized_current_file <- here::here("scripts", "2_omniscape_julia", "1_Biomas_resistencia_100", "normalized_cum_currmap.tif")
normalized_current <- terra::rast(normalized_current_file)
norm_cut <- normalized_current
norm_cut[norm_cut > 8] <- NA
png("figs/normalized.png")
plot(norm_cut, col = viridis::viridis(100))
dev.off()
flow_potential_file <- here::here("scripts", "2_omniscape_julia","1_Biomas_resistencia_100","flow_potential.tif")
flow_potential <- terra::rast(flow_potential_file)
plot(flow_potential, col = viridis::viridis(100))


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
par(mfrow = c(1,1))
plot(curr_class)
values(omni_reclass$normalized_cum_currmap)
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
res <- terra::rast("raw_data/new_test_area.tif")
kernel <- terra::rast("raw_data/new_test_area_kernel.tif")
ke <- values(kernel)
re <- values(res)
normm <- values(norm_resample)
cor.test(ke, normm)
cor.test(ke, re)
library(ggplot2)
library(tidyr)
library(dplyr)
re |> tibble() |> rename(resistance = b1)
df <- tidyr::tibble(resistance = re, kernel = ke, norm = normm)
df |> ggplot(aes(x = kernel, y = resistance)) +
  geom_point() +
  theme_bw()
ggsave("fig1.png")
df |> ggplot(aes(x = kernel, y = normm)) +
  geom_point() +
  theme_bw()
ggsave("fig2.png")

norm_resist <- terra::rast("scripts/2_omniscape_julia/1_Biomas_resistencia_100/normalized_cum_currmap.tif")
norm_val <- values(norm_resist)
length(norm_val)
length(re)

kernel <- terra::rast("raw_data/new_test_area_kernel.tif")
plot(kernel)
kernel_vals <- values(kernel)
plot(norm_val, kernel_vals)
res(norm_resist)
res(kernel)
norm_resample <- resample(norm_resist, kernel)
plot(, kernel_vals)
hist(kernel_vals)

library(terra)
library(tmap)
res <- terra::rast("scripts/2_omniscape_julia/baf_resistencia.tif")
plot(res)

currmap <- terra::rast("scripts/2_omniscape_julia/output/baf/cum_currmap.tif")

plot(currmap)

norm <- terra::rast("scripts/2_omniscape_julia/output/baf/normalized_cum_currmap.tif")
plot(norm)

par(mfrow = c(1, 3))
plot(res, main = "Original resistance, test area")
plot(currmap, main = "Cumulative current map")
plot(norm, main = "Normalized cumulative current map")
par(mfrow = c(1, 1))

par(mfrow = c(1, 3))
plot(hist(values(res)), main = "Original resistance, test area")
plot(hist(values(currmap)), main = "Cumulative current map")
plot(hist(values(norm)), main = "Normalized cumulative current map")
par(mfrow = c(1, 1))

#########test area default options-----
library(terra)
res <- terra::rast("scripts/2_omniscape_julia/resistencia_test_area.tif")
plot(res)

currmap <- terra::rast("scripts/2_omniscape_julia/output/test2_default_options/cum_currmap.tif")
currmap2 <- terra::rast("scripts/2_omniscape_julia/output/test2_radius200/cum_currmap.tif")
currmap3 <- terra::rast("scripts/2_omniscape_julia/output/test2_radius300/cum_currmap.tif")
currmap4 <- terra::rast("scripts/2_omniscape_julia/output/test2_radius200_block10/cum_currmap.tif")
currmap5 <- terra::rast("scripts/2_omniscape_julia/output/test2_rad100_block_5_cutoff300/cum_currmap.tif")
currmap6 <- terra::rast("scripts/2_omniscape_julia/output/test2_rad200_block_5_cutoff300/cum_currmap.tif")
currmap7 <- terra::rast("scripts/2_omniscape_julia/output/test2_rad300_block_5_cutoff300/cum_currmap.tif")
currmap8 <- terra::rast("scripts/2_omniscape_julia/output/reclass_radius300/cum_currmap.tif")
par(mfrow = c(3, 3))
plot(currmap)
plot(currmap2)
plot(currmap3)
plot(currmap4)
plot(currmap5)
plot(currmap6)
plot(currmap7)
plot(currmap8)

par(mfrow = c(2,1))
hist(values(currmap3))
hist(values(currmap8))

norm <- terra::rast("scripts/2_omniscape_julia/output/test2_default_options/normalized_cum_currmap.tif")
norm2 <- terra::rast("scripts/2_omniscape_julia/output/test2_radius200/normalized_cum_currmap.tif")
norm3 <- terra::rast("scripts/2_omniscape_julia/output/test2_radius300/normalized_cum_currmap.tif")
norm4 <- terra::rast("scripts/2_omniscape_julia/output/test2_radius200_block10/normalized_cum_currmap.tif")
norm5 <- terra::rast("scripts/2_omniscape_julia/output/test2_rad100_block_5_cutoff300/normalized_cum_currmap.tif")
norm6 <- terra::rast("scripts/2_omniscape_julia/output/test2_rad200_block_5_cutoff300/normalized_cum_currmap.tif")
norm7 <- terra::rast("scripts/2_omniscape_julia/output/test2_rad300_block_5_cutoff300/normalized_cum_currmap.tif")
norm8 <- terra::rast("scripts/2_omniscape_julia/output/reclass_radius300/normalized_cum_currmap.tif")

par(mfrow = c(3, 3))
plot(norm)
plot(norm2)
plot(norm3)
plot(norm4)
plot(norm5)
plot(norm6)
plot(norm7)
plot(norm8)
par(mfrow = c(1, 1))


par(mfrow = c(3, 3))
hist(values(currmap))
hist(values(norm))

hist(values(currmap2))
hist(values(norm2))


png("figs/example.png", width = 550, height = 400)
par(mfrow = c(1, 3))
plot(res, main = "Original resistance, test area")
plot(currmap, main = "Cumulative current map")
plot(norm, main = "Normalized cumulative current map")
dev.off()

tmap_mode("view")
tm_basemap(c(StreetMap = "OpenStreetMap")) +
  tm_shape(res, name = "Resistencia") +
    tm_raster(palette = "Greens") +
    tm_shape(currmap,
             name = "Block 5 Cutoff 50 Raio 100"
             ) +
    tm_raster(palette = "Reds") +
    tm_shape(currmap2,
             name = "Raio 200") +
    tm_raster(palette = "Reds") +
    tm_shape(currmap3,
             name = "Raio 300") +
    tm_raster(palette = "Reds") +
    tm_shape(currmap4,
             name = "Block 11, Raio 100") +
    tm_raster(palette = "Reds") +
    tm_shape(currmap5,
             name = "Block 5, Raio 100, Cutoff 300") +
    tm_raster(palette = "Reds") +
    tm_shape(currmap6,
             name = "Block 5, Raio 200, Cutoff 300") +
    tm_raster(palette = "Reds") +
    tm_shape(currmap7,
             name = "Block 5, Raio 300, Cutoff 300") +
    tm_raster(palette = "Reds") +
    tm_shape(currmap8,
             name = "Block 5, Raio 300, Reclass") +
    tm_raster(palette = "Reds")



    tm_shape(norm) +
    tm_raster(palette = "Reds") +
    tm_shape(norm2) +
    tm_raster(palette = "Reds") +
    tm_shape(norm3) +
    tm_raster(palette = "Reds") +
    tm_shape(norm4) +
    tm_raster(palette = "Reds") +
    tm_shape(norm5) +
    tm_raster(palette = "Reds") +
NULL

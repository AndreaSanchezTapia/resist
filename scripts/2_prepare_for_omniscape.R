#downsample resistance file

library(terra)
bra_res <- rast("scripts/2_omniscape_julia/Biomas_resistencia.tif")
#bra_res[bra_res > 128] <- NA
#writeRaster(bra_res, "scripts/2_omniscape_julia/Biomas_resistencia_NA.tif")
bra_res <- rast("scripts/2_omniscape_julia/Biomas_resistencia_NA.tif")
res(bra_res)

res_kernel <- rast("scripts/2_omniscape_julia/Biomas_resistencia_kernel.tif")
# downsamplear para 900m (factor 10)
resampled_bra <- aggregate(bra_res, 10, cores = 15)
plot(resampled_bra) #blz
writeRaster(resampled_bra, "scripts/2_omniscape_julia/resistencia_resampled.tif")


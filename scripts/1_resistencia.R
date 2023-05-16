#Load packages----
library(terra)
library(sf)
library(dplyr)
library(readr)

# read raw_data----
# they should be factors
## mapbiomas----
mapbiomas2020 <- terra::rast("raw_data/brasil_coverage_2020.tif")
## reamostrado
mapbiomas <- terra::rast("raw_data/00_Brasil_coverage_2020_col_07_90m/brasil_coverage_2020_col_07_90m.tif") |>
  as.factor()
levels(mapbiomas)
## biomas ----
biomas_shp <- sf::st_read("raw_data/00_Biomas_shp/lm_bioma_250.shp")
## biomas reamostrado a 90
biomas <- terra::rast("raw_data/02a_Biomas_90m/Biomas_90m.tif")
levels(biomas)
## estradas----
estradas <- terra::rast("raw_data/00a_Estradas/Estradas.tif")
is.factor(estradas)

# BAF----
## baf shape and raster----
baf <- biomas == "MataAtlantica"
plot(baf, asp = 1)
baf_polygon <- biomas_shp |>
  filter(Bioma == "Mata Atlântica")

## mapbiomas----
mapbiomas_baf <- mapbiomas |>
  crop(baf_polygon) |> trim()
plot(mapbiomas_baf)
## estradas----
estradas_baf <- estradas |>
  mask(baf_polygon)
estradas_baf <- estradas_baf |>
  crop(baf_polygon)

# resistencia----
## resistencia values----
legenda <- read_csv("raw_data/mapbiomas_legenda.csv")
## reclassificar os valores pela resistencia----

test <- sum(estradas_baf, mapbiomas_baf)



# mascara
masked <- terra::rast("raw_data/01_Brasil_coverage_2020_col_07_90m_estradas/brasil_coverage_2020_col_07_90m_estradas.tif")
mask_baf <- masked |>
  mask(baf_polygon)
mask_baf <- mask_baf |>
  crop(baf_polygon)

# install.packages("tmap")
library(tmap)
tmap_mode("view")
tm_shape(baf_polygon) +
  tm_bubbles()
  tm_basemap()

# ressistencia
  resistencia <- terra::rast("raw_data/03_Combine_Biomas_Classes_resis")

#resistencia kernel
resistencia <- terra::rast("raw_data/04_brasil_coverage_2020_col_07_90m_estradas_resistencia_Kernel/brasil_coverage_2020_col_07_90m_estradas_resistencia_Kernell.tif")


resistencia_baf <- resistencia |>
  crop(baf)
resistencia_baf <- resistencia_baf |>
  mask(baf_polygon)
resistencia_baf <- trim(resistencia_baf)
plot(resistencia_baf)
dir.create("processed_data")
terra::writeRaster(resistencia_baf, "processed_data/baf_resistencia.tif",
                   overwrite = T)

res <- as.factor(resistencia_baf)
levels(res)
library(tmap)
tm_shape(res) +
  tm_grid() +
  tm_raster(palette = terrain.colors(300), legend.show = TRUE) +
NULL

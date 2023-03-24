# fonte dos dados usados para calcular a resistência da paisagem e esquema preliminar da metodologia seguida
# Mapbiomas----
download.file(
  "https://storage.googleapis.com/mapbiomas-public/brasil/collection-7/lclu/coverage/brasil_coverage_202.tif",
  destfile =  "raw_data/brasil_coverage_col7_2020.tif")
#legenda----
download.file(
  "https://mapbiomas-br-site.s3.amazonaws.com/downloads/_EN__Códigos_da_legenda_Coleção_7.pdf",
  destfile = "raw_data/_EN__Códigos_da_legenda_Coleção_7.pdf")

# estradas
# BCIM250 2021 de estradas
# reamostradas a 90m
# reclassificadas, pavimentadas 2000, nao pavimentadas 1000, o resto 0

# tabela de resistencia para reclassificar
readr::read_csv("raw_data/mapbiomas_legenda.csv")

# reclassificacao de mapbiomas para valores de resistencia
#
# soma de valores de resistencia e raster de estradas
#
# kernel de 90m (raw_data/kernel_23x23.txt)

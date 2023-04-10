library(readxl)
library(readr)
library(tidyr)
library(dplyr)
classes <- read_xlsx("raw_data/03_Combine_Biomas_Classes_resistencia/Combine_Biomas_Classes_resistencia.xlsx")
comparison <- classes |>
  select(-Value, -Count, -Class_Code, -biomas_250) |>
  pivot_wider(id_cols = Classes, names_from = Biomas, values_from = Resistence)
comparison  |> View()
write_csv(comparison, "processed_data/comparison_resistencias.csv")

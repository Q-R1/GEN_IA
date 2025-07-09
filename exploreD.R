#Cargar libreria
library(tidyverse)

# Import dataset ---------------------------------------------------------
docentes <- read_csv("docentes.csv")

#Cargar libreria
library(funModeling)
#Explore vars ------------------------------------------------------------
#Inspecting Variables in R
glimpse(docentes)

#Exploring Variables and Saving Plots with funModeling
freq(docentes, path_out='my_folder')

# Table cross -----------------------------------------------------------
library(flextable)
library(gtsummary)

theme_gtsummary_compact()  # Estilo compacto para tablas

## Reordering levels of the variable
docentes$`¿Usas herramientas de inteligencia artificial (como ChatGPT, Gemini, DeepSeek, etc.)?` <- docentes$`¿Usas herramientas de inteligencia artificial (como ChatGPT, Gemini, DeepSeek, etc.)?` |>
  fct_relevel(
    "Sí, ir al cuestionario", "A veces, ir al cuestionario", "No, salir"
  )
 docentes %>%
  tbl_cross (row = 2, col = 3, percent = "cell") %>%
  bold_labels() %>%
  modify_header(
    all_stat_cols = "**{level}**\nN = {n}",
    stat_1 = "**Femenino**\nN = {n}",
    stat_2 = "**Masculino**\nN = {n}",
    stat_3 = "**No, salir**\nN = {n}"
  )#%>%
 #as_flex_table() %>%
 #save_as_docx(path = "doce.docx")

# variables of interest --------------------------------------------

vars_interest_docente <- docentes %>%
  select(-`Marca temporal`, -Municipio)

#Exploring Selected Variables with funModeling

library(funModeling)# Filtering Pipeline with funModeling----------

status <- df_status(vars_interest_docente)

# Filtrar columnas problemáticas (ej. las con >10% NAs)
cols_con_NA <- status %>%
  filter(p_na > 10) %>%
  pull(variable)

#filter cols_con_NA
vars_interest_docente_filtrado <- vars_interest_docente %>%
  filter(across(all_of(cols_con_NA), ~!is.na(.)))

#workflow:Open and Run code from another script-------------
source("analiceD.R");file.edit("analiceD.R")







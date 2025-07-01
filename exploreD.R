#Cargar libreria
library(tidyverse)

# Import data set ---------------------------------------------------------
docentes <- read_csv("docentes.csv")

#Cargar libreria
library(funModeling)
# Explore vars ------------------------------------------------------------
glimpse(docentes)


# Table cross -----------------------------------------------------------
#Cargar librerias
library(flextable)
library(bstfun)
library(ggstats)
library(gtsummary)

theme_gtsummary_compact()  # Estilo compacto para tablas

#theme_gtsummary_language(language = "es")   # Idioma español

theme_gtsummary_journal("nejm")           # Estilo de revista QJEconomics

docentes %>%
  # 1. Filter NA in the AI variable (assuming column 2)
  filter(!is.na(.[[2]])) %>%
  # 3. Create table_cross (IA vs. Sexo)
  tbl_cross(
    row = 2,       # Columna de IA (sin NA)
    col = 3,       # Columna de Sexo
    percent = "cell"
  ) %>%

  # 4. Formatear negritas y encabezados
  bold_labels() %>%
  modify_header(all_stat_cols() ~ "**{level}**\nN = {n}"  # Cols: man, women, etc. + count
  ) %>%
  modify_header(update = list(
    stat_3 ~ "**No, salir**\nN = {n}"
  ))%>%
  as_flex_table() %>%
  save_as_docx(path = "doce.docx")


# select variables of interest --------------------------------------------

select_doce <- docentes %>%
  select(
    -`Marca temporal`,
    -Municipio,
    -`¿Usas herramientas de inteligencia artificial (como ChatGPT, Gemini, DeepSeek, etc.)?`,  # ¡Cierre de paréntesis y signo de interrogación!
    -`Años de servicio`
  )
#Explore vars selected
df_status(select_doce)

freq(select_doce)

#Source and file edit Analytics.R ------------------------------------------
source("analiceD.R");file.edit("analiceD.R")


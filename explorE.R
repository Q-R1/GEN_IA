#Load package
library(tidyverse)


# Import dataset ---------------------------------------------------------
estudiantes <- read_csv("estudiantes.csv")

#Load a library
library(funModeling)
# Explore vars ------------------------------------------------------------
glimpse(estudiantes)
freq(estudiantes)

# Table cross -----------------------------------------------------------

library(flextable)
library(gtsummary)

theme_gtsummary_compact()  # Estilo compacto para tablas

## Reordering levels of the variable

estudiantes$`¿Usas herramientas de inteligencia artificial (como ChatGPT, Gemini, DeepSeek, etc.)?` <- estudiantes$`¿Usas herramientas de inteligencia artificial (como ChatGPT, Gemini, DeepSeek, etc.)?` %>%
  fct_relevel(
    "Sí, ir al cuestionario", "A veces, ir al cuestionario", "No, salir"
  )

 estudiantes %>%
  #filter(across(c(2, 3), ~ !is.na(.))) %>%
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


 # select variables of interest --------------------------------------------
seleccionar_vars <- estudiantes %>% select(-`Marca temporal`, -Municipio )

#Explore vars selected
df_status(select_est)

freq(select_est)

#Source and file edit ------------------------------------------
source("analicE.R");file.edit("analicE.R")


















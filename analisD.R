
# Means -------------------------------------------------------------------

#Remove variables with missing values
omitir_na <- select_vars %>%
  filter(!is.na(Sexo))

mean_pienso <- omitir_na %>%
  summarise(
    across(c(2:5), ~ mean(.x, na.rm = TRUE)),
    mean_general = mean(c_across(c(3:6)), na.rm = TRUE))


mean_siento <- omitir_na %>%
  summarise(
    across(c(6:12), ~ mean(.x, na.rm = TRUE)),
    mean_general = mean(c_across(c(6:12)), na.rm = TRUE))

mean_hago <- omitir_na %>%
  summarise(
    across(c(13:23), ~ mean(.x, na.rm = TRUE)),
    mean_general = mean(c_across(c(13:23)), na.rm = TRUE))

# Reordena y crea el data frame
valores <- data.frame(
  Grupo = factor(c("Pienso", "Hago", "Siento"), levels = c("Pienso", "Hago", "Siento")),
  MediaGeneral = c(mean_pienso$mean_general, mean_hago$mean_general, mean_siento$mean_general)
)

library(ggplot2)

ggplot(valores, aes(x = Grupo, y = MediaGeneral, group = 1)) +
  geom_line(color = "steelblue", size = 1) +              # Línea
  geom_point(color = "red", size = 3) +                   # Puntos
  geom_text(aes(label = round(MediaGeneral, 3)),          # Etiquetas como capa extra
            vjust = -1, size = 4, color = "black") +
  labs(title = "Comparación",
       x = "Dimensión",
       y = "Media general") +
  theme_minimal()









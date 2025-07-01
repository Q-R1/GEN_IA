
# Means -------------------------------------------------------------------

#Remove variables with missing values
omitir_na_est <- select_est %>%
  filter(!is.na(Sexo))

mean_pienso <- omitir_na_est %>%
  summarise(
    across(c(2:5), ~ mean(.x, na.rm = TRUE)),
    mean_general = mean(c_across(c(3:6)), na.rm = TRUE))


mean_siento <- omitir_na_est %>%
  summarise(
    across(c(6:12), ~ mean(.x, na.rm = TRUE)),
    mean_general = mean(c_across(c(6:12)), na.rm = TRUE))

mean_hago <- omitir_na_est %>%
  summarise(
    across(c(13:23), ~ mean(.x, na.rm = TRUE)),
    mean_general = mean(c_across(c(13:23)), na.rm = TRUE))

# Reordena y crea el data frame
valores <- data.frame(
  Grupo = factor(c("Pienso", "Hago", "Siento"), levels = c("Pienso", "Hago", "Siento")),
  MediaGeneral = c(mean_pienso$mean_general, mean_hago$mean_general, mean_siento$mean_general)
)

# Plot --------------------------------------------------------------------

library(tidyverse)

# Datos (asegúrate de que mean_pienso, mean_hago y mean_siento existen)
valores <- data.frame(
  Grupo = factor(c("Pienso", "Hago", "Siento"), levels = c("Pienso", "Hago", "Siento")),
  MediaGeneral = c(mean_pienso$mean_general, mean_hago$mean_general, mean_siento$mean_general)
)

# Gráfico usando pipe (%>%)
valores %>%
  ggplot(aes(x = Grupo, y = MediaGeneral, group = 1)) +
  geom_line(color = "steelblue", linewidth = 1) +
  geom_point(color = "red", size = 3) +
  geom_text(
    aes(label = round(MediaGeneral, 2)),
    vjust = -1, size = 5, color = "black"
  ) +
  labs(
    title = "Comparación",
    x = "Dimensión",
    y = "Media general"
  ) +
  theme_minimal() +
  ylim(0, max(valores$MediaGeneral) * 1.1)

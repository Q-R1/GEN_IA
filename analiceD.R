
# Means -------------------------------------------------------------------

#Remove variables with missing values
omitir_na_doce <- select_doce %>%
  filter(!is.na(Sexo))

TK_doce <- omitir_na_doce %>%
  summarise(
    across(c(2:8), ~ mean(.x, na.rm = TRUE)),
    mean_general = mean(c_across(c(2:8)), na.rm = TRUE))


TCK_doce <- omitir_na_doce %>%
  summarise(
    across(c(9:10), ~ mean(.x, na.rm = TRUE)),
    mean_general = mean(c_across(c(9:10)), na.rm = TRUE))

TPK_doce <- omitir_na_doce %>%
  summarise(
    across(c(11:15), ~ mean(.x, na.rm = TRUE)),
    mean_general = mean(c_across(c(11:15)), na.rm = TRUE))

TPACK_doce <- omitir_na_doce %>%
  summarise(
    across(c(16:20), ~ mean(.x, na.rm = TRUE)),
    mean_general = mean(c_across(c(16:20)), na.rm = TRUE))

# Crear el data frame con los nombres correctos de objetos----
valores <- data.frame(
  Grupo = factor(c("TK", "TCK", "TPK", "TPACK"),
                 levels = c("TK", "TCK", "TPK", "TPACK")),
  MediaGeneral = c(TK_doce$mean_general,
                   TCK_doce$mean_general,
                   TPK_doce$mean_general,
                   TPACK_doce$mean_general)  # Corregido: usamos _doce
)
# Plot --------------------------------------------------------------------

ggplot(valores, aes(x = Grupo, y = MediaGeneral, group = 1)) +
  geom_line(color = "steelblue", size = 1) +              # Línea
  geom_point(color = "red", size = 3) +                   # Puntos
  geom_text(aes(label = round(MediaGeneral, 3)),          # Etiquetas como capa extra
            vjust = -1, size = 5, color = "black") +
  labs(title = "Comparación",
       x = "Dimensión",
       y = "Media general") +
  theme_minimal()


# Plot expand_limits y = 0 ------------------------------------------------

ggplot(valores, aes(x = Grupo, y = MediaGeneral, group = 1)) +
  geom_line(color = "steelblue", linewidth = 1) +              # Línea
  geom_point(color = "red", size = 3) +                       # Puntos
  geom_text(
    aes(label = round(MediaGeneral, 2)),                     # Etiquetas (2 decimales)
    vjust = -1, size = 5, color = "black"
  ) +
  labs(
    title = "Comparación",
    x = "Dimensión",
    y = "Media general"
  ) +
  theme_minimal() +
  expand_limits(y = 0)  # ⭐ Forzar eje Y desde cero




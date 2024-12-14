# Crear el vector de tipo de energía (10 renovables y 10 no renovables)
energia <- c(rep("Renovable", 10), rep("No Renovable", 10))

# Crear el vector de consumo con valores NA
set.seed(123)  # Para reproducibilidad
consumo <- c(sample(c(50, 55, 60, NA), 10, replace = TRUE),
             sample(c(75, 80, 85, NA), 10, replace = TRUE))

# Crear el vector de costos por kWh
costo_kwh <- c(rep(0.15, 10), rep(0.25, 10))


# Función para reemplazar los NA con la mediana de cada grupo
consumo[is.na(consumo) & energia == "Renovable"] <- median(consumo[energia == "Renovable"], na.rm = TRUE)
consumo[is.na(consumo) & energia == "No Renovable"] <- median(consumo[energia == "No Renovable"], na.rm = TRUE)

# Crear el dataframe
df_consumo <- data.frame(
  energia = energia,
  consumo = consumo,
  costo_kwh = costo_kwh
)


# Calcular el costo total
df_consumo$costo_total <- df_consumo$consumo * df_consumo$costo_kwh

# Calcular el total de consumo y costo total por tipo de energía
total_consumo <- aggregate(consumo ~ energia, data = df_consumo, sum)
total_costo <- aggregate(costo_total ~ energia, data = df_consumo, sum)

# Calcular la media del consumo diario por tipo de energía
media_consumo <- aggregate(consumo ~ energia, data = df_consumo, mean)

# Simulación de aumento de precio del 10%
df_consumo$ganancia <- df_consumo$costo_total * 1.1


# Ordenar el dataframe por costo_total (descendente)
df_consumo_ordenado <- df_consumo[order(-df_consumo$costo_total),]

# Calcular el total de consumo y costo por tipo de energía
resumen_consumo <- aggregate(consumo ~ energia, data = df_consumo, sum)
resumen_costo <- aggregate(costo_total ~ energia, data = df_consumo, sum)

# Extraer las 3 filas con mayor costo
top_3_costos <- head(df_consumo_ordenado, 3)

# Mostrar el resumen completo
resumen_energia <- list(
  resumen_consumo = resumen_consumo,
  resumen_costo = resumen_costo,
  top_3_costos = top_3_costos
)

# Mostrar el resumen
print(resumen_energia)


# Inicializar repositorio y añadir archivo demo
git init
echo "# Proyecto" >> README.md

# Añadir archivos al repositorio
git add .

# Hacer commit
git commit -m "Primer commit"

# Crear rama main
git branch -M main

# Añadir repositorio remoto
git remote add origin https://github.com/usuario/repositorio.git

# Subir código
git push -u origin main
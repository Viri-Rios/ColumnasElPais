clear all
set more off

*** folder con la base de datos
cd "C:\ "

**Se carga la base de datos con las variables de análisis del modelo
use ResultadosPresidenciaMunicipio2018_2024


**** MODELO DE REGRESIÓN OLS CON ERRORES ROBUSTOS ****
reg cambio_mor pct_morena2018 ing_lab2022 ing_gob2022 cambio_ing_lab cambio_ing_gob i.gob_estado, robust


**** SE GENERAN LAS GRÁFICAS DEL MODELO DE REGRESIÓN ****
margins, at(cambio_ing_lab=(0 25 50 75 100 125 150 175 200))
marginsplot, recast(line) recastci(rarea) ciopt(color(maroon)) plotopts(lc(black))

margins, at(pct_morena2018=(35 40 45 50 55 60 65))
marginsplot, recast(line) recastci(rarea) ciopt(color(maroon)) plotopts(lc(black))

summ cambio_mor pct_morena2018 ing_lab2022 ing_gob2022 cambio_ing_lab cambio_ing_gob, detail

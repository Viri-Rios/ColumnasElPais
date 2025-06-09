clear all
set more off
cd C:\ResultadosEleccionJudicial

** Se carga la base de datos con clusters
use clusters

** Para cada grupo de clusters, se colapsa la base obteniendo el porcentaje de votación por candidato en cada cluster
forvalues i = 1/6 {
	preserve
	collapse (mean) Aguirre-Tortolero [fw=votos_val], by(_clus_`i')
	export excel using "Cluster`i'.xlsx", firstrow(variables) replace
	restore
	}
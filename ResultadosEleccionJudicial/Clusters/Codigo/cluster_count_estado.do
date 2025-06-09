clear all
set more off
cd C:\ResultadosEleccionJudicial

** Se carga la base de datos con clusters
use clusters

** Se eliminan las variables clus_1 a clus_5, correspondientes a 3 a 7 clusters
forvalues i = 1/5 {
	drop _clus_`i'
	}

rename _clus_6 cluster8

keep ent id_ent cluster8 secc

** Se genera una cuenta de secciones por cada cluster y estado
bysort id_ent cluster8: gen cuenta_secc = _n
bysort id_ent cluster8: egen tot_secc = max(cuenta_secc)

bysort id_ent: gen cuenta_tot = _n
bysort id_ent: egen tot_tot = max(cuenta_tot)

** Se genera el porcentaje de secciones por cluster y estado
gen pct = tot_secc/tot_tot

** Se colapsa la base por cluster y estado
collapse (first) pct, by(id_ent ent cluster8)
sort id_ent
replace ent = proper(ent)
drop id_ent
replace cluster8 = 9 if cluster8 == .

** Se ordena la base en forma horizontal
reshape wide pct, i(ent) j(cluster8)
forvalues i = 1/9 {
 	rename pct`i' pct_secciones`i'
	}
rename pct_secciones9 pct_seccionesNA
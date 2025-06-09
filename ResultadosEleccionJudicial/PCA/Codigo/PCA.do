clear all
set more off

**Carpeta con la base de datos
cd C:\ResultadosEleccionJudicial
use ResultadosEleccionJudicial

**Se eliminan los 0s de las variables de candidatos para poder correr un loop
rename cand01 cand1
rename cand02 cand2
rename cand03 cand3
rename cand04 cand4
rename cand05 cand5
rename cand06 cand6
rename cand07 cand7
rename cand08 cand8
rename cand09 cand9

** Convertir los votos a valores numericos
	forvalues i = 1/64 {
		replace cand`i' = "0" if cand`i' == "-"
		destring cand`i', replace
		}

** Se colapsa la base por seccion
collapse (sum) cand* lista_nom, by(id_ent ent id_distrito_federal distrito_federal seccion)

** Se suma el total de votos por todos los candidatos
egen votos_val = rowtotal(cand*)

** Se obtiene el porcentje de votos por cada candidato
forvalues i = 1/64 {
	gen cand`i'_pct = cand`i' / votos_val
	}

** Se renombran los porcentajes con los apellidsos
rename cand1_pct Aguirre
rename cand2_pct Aladro
rename cand3_pct Batres
rename cand4_pct Bonilla
rename cand5_pct Castañeda
rename cand6_pct Cruz
rename cand7_pct Escudero
rename cand8_pct Esquivel
rename cand9_pct Estrada
rename cand10_pct Fuentes
rename cand11_pct Garcia
rename cand12_pct GarciaVillegas
rename cand13_pct Gonzalez
rename cand14_pct GonzalezTirado
rename cand15_pct Güicho
rename cand16_pct Herrerias
rename cand17_pct Ibarra
rename cand18_pct Madrigal
rename cand19_pct Martinez
rename cand20_pct Morales
rename cand21_pct Mosri
rename cand22_pct Ortiz
rename cand23_pct OrtizMonroy
rename cand24_pct Perez
rename cand25_pct Reyes
rename cand26_pct Rios
rename cand27_pct Rojas
rename cand28_pct Rosillo
rename cand29_pct Santos
rename cand30_pct Tapia
rename cand31_pct Tellez
rename cand32_pct Ucaranza
rename cand33_pct Zarza
rename cand34_pct Aguilar
rename cand35_pct Allier
rename cand36_pct Anaya
rename cand37_pct Carlin
rename cand38_pct Corzo
rename cand39_pct Davila
rename cand40_pct DePaz
rename cand41_pct Espinosa
rename cand42_pct Espinoza
rename cand43_pct Figueroa
rename cand44_pct Flores
rename cand45_pct GarciaGonzalez
rename cand46_pct GarciaGuerra
rename cand47_pct Garduño
rename cand48_pct Guerrero
rename cand49_pct Gutierrez
rename cand50_pct Hernandez 
rename cand51_pct Illanes
rename cand52_pct Jimenez
rename cand53_pct Lopez
rename cand54_pct Luna
rename cand55_pct Molina
rename cand56_pct Molinar
rename cand57_pct Odriozola
rename cand58_pct Olmedo
rename cand59_pct Regis
rename cand60_pct Santillan
rename cand61_pct Sodi
rename cand62_pct Sorela
rename cand63_pct Torres
rename cand64_pct Tortolero

** se calcula el modelo de componentes principales, y se obtienen las gráficas
pca Aguilar	Anaya	Batres	Carlin	DePaz	Espinosa	Esquivel	Estrada	Figueroa	Flores	Fuentes	GarciaGue	GarciaVil	Guerrero	Gutierrez	Herrerias	Ibarra	Martinez	Molina	Morales	Mosri	Ortiz	Reyes	Rios	Sodi	Tellez	Aguirre	Aladro	Allier	Bonilla	Castañeda	Corzo	Cruz	Davila	Escudero	Espinoza	Garcia	GarciaGonz	Gonzalez	GonzalezTir	Güicho, components(10)

estat kmo

screeplot, ytitle("Component") title("") xtitle("") neigen(10)
graph export Scree.png, replace

loadingplot
graph export Loading.png, replace

mat eigenvalues = e(Ev)
gen eigenvalues = eigenvalues[1,_n]
egen pct=total(eigenvalues) if !mi(eigenvalues)
replace pct=sum((eigenvalues/pct)*100) if !mi(eigenvalues)
g component =_n if !mi(eigenvalues)
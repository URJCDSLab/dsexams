library(exams)
exams2pdf(file = "inst/questions/EJ_ED2_COR_BIO_001_pesoaltura.Rmd", encoding = "utf8", name = "Ejercicio")
exams2pdf(file = "inst/questions/EJ_ED2_COR_GEN_001_XY.Rmd", encoding = "utf8", name = "Ejercicio")
exams2pdf(file = "inst/questions/originales/EEE/matrizcov.Rmd", encoding = "utf8", name = "Ejercicio")
exams2pdf(file = "inst/questions/originales/MDS/ED1_Frecuencias_semillas.Rnw", encoding = "utf8")
exams2moodle(file = "inst/questions/originales/MDS/ED1_Frecuencias_semillas.Rnw", encoding = "utf8")
exams2pdf(file = "inst/questions/originales/EEE/PR_tabla_condicionada.Rmd")
exams2moodle(file = "inst/questions/test.Rmd")
exams2moodle(file = "inst/questions/originales/MDS/VA_exp_pois.Rnw", n = 10, name = "VA_EXP_POIS_FIXED")

# Bioest parcial 2
exams2moodle(file = "inst/questions/EJ_IN_T_GEN_001_AB.Rmd", n = 20, encoding = "utf8")


genMyexam(iformat = "sweave", nq = 10)


## GBIO examen
exams2moodle(file = "inst/questions/EJ_ED2_COR_GEN_001_XY.Rmd", n = 20, name = "bioexamen")
exams2moodle(file = c("inst/questions/originales/MDS/PR_bayes_seguro.Rnw",
                      "inst/questions/originales/EEE/VA_poisson_explotacionganadera.Rnw",
                      "inst/questions/originales/EEE/VA_normal_latarefrescos.Rnw",
                      "inst/questions/originales/EEE/examen_binomial.Rmd",
                      "inst/questions/originales/EEE/examen_exponencial_bio.Rmd"), n = 20, name = "bioexamen")

ejpr <- dir("inst/questions/", full.names = TRUE, pattern = "Rmd$")
exams2moodle(file = ejpr[4], encoding = "utf8", name = "prueba_marina", n = 1)

# GIA HOJA PR
exams2moodle(file = ejpr, encoding = "utf8", name = "PR_GBIO", n = 20)

# ejpr <- dir("inst/questions/originales/MDS", pattern = "PR_.*.Rnw$", full.names = TRUE)
# GIA HOJA VA
ejva <- c("inst/questions/originales/MDS/VA_exp_pois.Rnw",
          "inst/questions/originales/MDS/VA_uniforme_bacterias.Rnw",
          "inst/questions/originales/MDS/VA_binom_geometrica_cereales.Rnw",
          "inst/questions/originales/EEE/examen_poisson_camiones.Rmd")
ejva <- c("inst/questions/originales/MDS/VA_normal_binom.Rnw")
exams2moodle(file = ejva, encoding = "utf8", name = "VA_GIA", n = 20)

# GIA INFERENCIA

ejinf <- c("inst/questions/originales/MDS/INF_IC_azucar.Rnw",
          "inst/questions/originales/MDS/INF_IC_fibras.Rnw",
          "inst/questions/originales/MDS/TH_1M_botellasleche.Rnw",
          "inst/questions/originales/MDS/TH_2Md_ruido.Rnw")
exams2moodle(file = ejinf, encoding = "utf8", name = "INF_GIA", n = 20)



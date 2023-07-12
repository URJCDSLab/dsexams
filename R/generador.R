genMyexam <- function(n1, n2, n3, n4,
                      iformat = "rmarkdown",
                      oformat = "moodle_xml",
                      nq = 1,
                      odir = ".",
                      ofile = paste0("exam_", Sys.Date()),
                      myconv = "tth"){

  if (iformat == "rmarkdown"){
    ifiles <- list.files(system.file("questions",
                                     package = "myexams"),
                         "\\.Rmd$",
                         full.names = TRUE)
  } else if (iformat == "sweave"){
    ifiles <- list.files(system.file("questions",
                                     package = "myexams"),
                         "\\.Rnw$",
                         full.names = TRUE)
  }
  if (oformat == "moodle_xml"){
    exams2moodle(file = ifiles, n = nq,
                 dir = odir,
                 name = ofile,
                 converter = myconv)
  }

}

#
# ficheros_tex <- dir(".", ".Rnw$", full.names = TRUE)
# ficheros_md <- c("07-PR_bienes.Rmd"
#                  # , "07-PR_urna.Rmd"
#                  # , "07-PR_tabla_condicionada.Rmd"
#                  )
# # ficheros <- "test_auto.Rmd"
# ficheros_tex <- c("07-PR_bayes_seguro.Rnw", "07-PR_bayes_valvulas.Rnw")
#
# exams2moodle(file = ficheros_md, n = 10,
#              dir = "autoevaluacion",
#              name = "autoevaluacion-estadistica-empresarial-rmd",
#              converter = "tth" )
#
# exams2moodle(file = ficheros_tex, n = 10,
#              dir = "autoevaluacion",
#              name = "autoevaluacion-estadistica-empresarial-tex",
#              converter = "tth" )
#
#
# exams2moodle(file = "./ejercicios_moodle/matrizcov.Rmd", n = 20,
#              dir = "ejercicios_moodle",
#              name = "ejercicios-moodle-rmd",
#              converter = "tth" )
#

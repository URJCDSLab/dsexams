library(exams)
library(yaml)
library(testthat)

## Read_metadata ----

# Evaluates if the result is a list original type.
test_that("expect_type_matcov_read_metadata", {
  matcov_type <- read_metadata("matrizcov_en.Rmd")
  expect_type(matcov_type, "list")
})

# Evaluates if the result is a dataframe (s3 class).
test_that("expect_s3_class_matcov_read_metadata", {
  matcov_type <- read_metadata("matrizcov_en.Rmd")
  expect_s3_class(matcov_type, "data.frame")
})


## Is_valid_metadata ----

# Evaluates that the YAML heading appears in the file.
test_that("matcov_is_valid_metadata", {
  matcov_is_valid_metadata <- is_valid_metadata("matrizcov_en.Rmd")
  expect_type(matcov_is_valid_metadata, "logical")
})

# Evaluates that the function return a logical type TRUE.
test_that("matcov_is_valid_metadata_values", {
  matcov_is_valid_metadata <- is_valid_metadata("matrizcov_en.Rmd")
  expect_true(matcov_is_valid_metadata)
})

# Evaluates that the YAML heading appears in the file FALSE.
# Uses a modified file Rmd.
test_that("matcov_is_valid_metadata_values", {
  matcov_is_valid_metadata <- is_valid_metadata("matrizcov_2_en.Rmd")
  expect_false(matcov_is_valid_metadata)
})

## Questionnaries ----

# Evaluates if the result is a list original type.
test_that("expect_type_matcov_read_metadata", {
  matcov_type <- questions("matrizcov_en.Rmd")
  expect_type(matcov_type, "list")
})

# Evaluates if the result is a dataframe (s3 class).
test_that("expect_s3_class_matcov_read_metadata", {
  matcov_type <- questions("matrizcov_en.Rmd")
  expect_s3_class(matcov_type, "data.frame")
})

# Evaluates if all the questionnaries are found.
test_that("num_questionnaries_matcov", {
  list_questionnaries <- c("matrizcov_en.Rmd")
  matcov_num <- questions(list_questionnaries)
  expect_equal(nrow(matcov_num),length(list_questionnaries))
})


## Wordcloud ----

# Evaluates if the wordcloud does not produce warnings, messages or errors.
test_that("silent_matcov_wordcloud", {
  matcov_wordcloud <- word_cloud("matrizcov_en.Rmd")
  expect_silent(matcov_wordcloud)
})

## Generate_exam ----

# Evaluates if an exam file is created in a temporal folder
test_that("file_created_generate_exam", {
  testFolder <- tempdir()
  generate_exam(
    qpath="inst/questions/",
    nquest = 1,
    edir = testFolder,
    ename = "dsexams_Exam",
    output_format = "moodle"
  )
  exam_files <- list.files(path = testFolder, pattern = "^dsexams_Exam")
  exists_exam <- any(file.exists(path = testFolder, exam_files))
  expect_true(exists_exam)
})


# Evaluates if the result is a dataframe (s3 class).
test_that("expect_s3_class_generate_exam", {
  testFolder <- tempdir()
  exam_type <- generate_exam(
    qpath="inst/questions/",
    nquest = 1,
    edir = testFolder,
    ename = "dsexams_Exam",
    output_format = "moodle"
  )
  expect_s3_class(exam_type, "data.frame")
})


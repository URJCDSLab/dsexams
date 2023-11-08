#
#' @title READ_METADATA
#'
#' @description
#'
#' @param file A string with file path of the exercise
#' @return A data frame with metadata of exercise
#'
#' @importFrom yaml yaml.load
#'
read_metadata <- function(file){
  require(yaml)
  texto <- readLines(file)
  posicionesDatos <- which(texto == "---") + c(1, -1)
  metadata <- ""
  if(length(posicionesDatos) == 2){
    info <- texto[posicionesDatos[1]:posicionesDatos[2]]
    metadata <- yaml::yaml.load(info)
  }
  return(as.data.frame(cbind(rbind(metadata), file)))
}

#
#' @title IS_VALID_METADATA
#'
#' @description
#'
#' @param file A string of file path of the exercise
#' @return A boolean with TRUE if file contains valid metadata; FALSE in other case
#'
#' @keywords internal
#'
is_valid_metadata <- function(file){
  texto <- readLines(file)
  posicionesDatos <- which(texto == "---") + c(1, -1)
  isValid <- length(posicionesDatos) == 2

  return(isValid)
}

#
#' @title WORD_CLOUD
#'
#' @description
#'
#' @param exercises A string or vector of strings with file path of the
#' exercises or dataframe with metadata of exercises
#' @return A word cloud with keywords of exercises
#'
#' @importFrom tm TermDocumentMatrix
#' @importFrom wordcloud wordcloud
#'
word_cloud <- function(exercises){
  require(wordcloud)
  # require(dplyr)
  require(tm)

  words <- ""
  if(is.data.frame(exercises)){
    if("keywords" %in% colnames(exercises)){
      words <- paste(unlist(exercises$keywords), collapse = " ")
    }else{
      stop("Dataframe is not valid.")
    }

  }else{
    questions <- questions(exercises)
    words <- paste(unlist(questions$keywords), collapse = " ")
  }

  doc_mat <- tm::TermDocumentMatrix(words)
  doc_mat <- data.frame("words" = doc_mat$dimnames$Terms, "freq" = doc_mat$v)

  wordcloud::wordcloud(words = doc_mat$words,
                       freq = doc_mat$freq,
                       min.freq = 1,
                       max.words = 100,
                       random.order = FALSE,
                       colors = brewer.pal(4, "Set1"),
                       scale=c(2, .5))
}

#
#' @title QUESTIONS
#'
#' @description
#'
#' @param quest A string with directory path, a vector of strings with path of
#' exercises or a dataframe with metadata of exercises
#' @return A data frame with metadata of exercises
#'
questions <- function(quest){
  if(length(quest) == 1 && dir.exists(quest)){
    files <- list.files(quest, pattern = "*\\.Rmd$", ignore.case = TRUE)
    quest <- paste0(quest, files)
  }else{
    quest <- quest[grepl("*\\.Rmd$", quest)]
  }

  well_formed <- sapply(quest, is_valid_metadata)
  quest <- quest[well_formed]

  df <- data.frame()
  if(!is.null(quest)){
    df <- lapply(quest, read_metadata)
    df <- as.data.frame(do.call("rbind", df))
  }

  return(df)

}

#
#' @title GENERATE_EXAM
#'
#' @description
#'
#' @param qpath A string with directory path, a vector of strings with path of
#' exercises or a dataframe with metadata of exercises
#' @param n An integer with the number of copies to be compiled from each execise
#' @param n_questios An integer with the number of questions to be included in
#' the exam
#' @param edir A string specifying the path of the directory in which the exam
#' file is stored
#' @param ename A string with the name for the resulting exam file
#' @param i.language A string with the language code of the questions to be
#' included in the exam
#' @param i.level A string with the level of the questions to be included in
#' the exam
#' @param i.type A string with the type of the questions to be included in
#' the exam
#' @param i.domain A string with the domain of the questions to be included in
#' the exam
#' @param i.keywords A vector of keywords. If a question contains any
#' of the keywords in the vector, the question will be included in the exam
#' @param i.lesson A vector of lessons. If a question contains any
#' of the lessons in the vector, the question will be included in the exam
#' @return A data frame with the exercises of exam
#'
#'@importFrom exams exams2moodle
generate_exam <- function(qpath, n_questions, n = 1, edir = ".", ename = NULL,
                          i.language = NULL,
                          i.level = NULL,
                          i.type = NULL,
                          i.domain = NULL,
                          i.keywords =  NULL,
                          i.lesson = NULL){

  result <- questions(qpath)

  if (!is.null(i.language)) {
    result <- subset(result, language == i.language)
  }

  if (!is.null(i.level)) {
    result <- subset(result, level == i.level)
  }

  if (!is.null(i.type)) {
    result <- subset(result, type == i.type)
  }

  if (!is.null(i.domain)) {
    result <- subset(result, domain == i.domain)
  }

  if (!is.null(i.keywords)) {
    result <- subset(result, grepl(paste(i.keywords, collapse = "|"), keywords))
  }
  if (!is.null(i.lesson)) {
    result <- subset(result, grepl(paste(i.lesson, collapse = "|"), lesson))
  }

  print(nrow(result))

  if (nrow(result) == 0){
    warning("No questions matched the search criteria")
    return(NULL)

  } else if (nrow(result) < n_questions){
    warning("The number of questions matching the search criteria is less than
            the n_questions parameter.")

  } else {
    result <- result[sample(nrow(result), n_questions),  ]
  }

  exams::exams2moodle(file = unlist(result$file), n = n, dir=edir, name = ename)

  return(result)

}


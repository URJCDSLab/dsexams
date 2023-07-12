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

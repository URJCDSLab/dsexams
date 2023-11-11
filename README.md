# Data Science Exams


Check [the presentation at EDULEARN23](https://www.lcano.com/p/edulearn23/#/title-slide).

A vignette and more documentation will be available soon.


## Installation

````
remotes::install_github("git@github.com:URJCDSLab/dsexams.git")
````


## Basic use

````
library(dsexams)
ex <- dir(system.file("questions/", package = "dsexams"), full.names = TRUE)
df <- generate_exam(qpath=ejercicios, 
                    n_questions = 2, 
                    edir="misexamenes",
                    ename = "Exam-1",
                    i.language = "es",
                    i.level = "exam", 
                    i.lesson = c("descriptive statistics"))
word_cloud(df)
````





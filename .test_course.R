library(methods)
library(yaml)
library(swirl)

argv <- if (interactive()) "commit" else commandArgs(TRUE)
stopifnot(length(argv) == 1)
stopifnot(argv %in% c("commit", "push"))

test_lesson = function(lesson_dir){
  print(paste("####Begin testing", lesson_dir))
  .e <- environment(swirl:::any_of_exprs)
  attach(.e)
  on.exit(detach(.e))
  e = new.env()
  e$path <- lesson_dir
  e$lesPath <- lesson_dir
  # Since the initLesson might change working directory, load lesson yaml first before that happens.
  lesson = yaml.load_file(paste0(lesson_dir,"/lesson.yaml"))
  stopifnot(lesson[[1]]$Lesson == lesson_dir)
  
  for(R_file in c("/../.initCourse.R", "/initLesson.R", "/customTests.R")){
    R_file_path = paste0(lesson_dir, R_file)
    if(file.exists(R_file_path)) source(R_file_path,local = e)
  }
  
  for(.i in seq_along(lesson)) {
    question <- lesson[[.i]]
    if(question$Class %in% c("cmd_question", "mult_question", "script")) {
      cat(sprintf("(%d) > %s\n", .i, question$CorrectAnswer))
      switch(question$Class, 
        "cmd_question" = {
          suppressWarnings({
            e$val <- eval(parse(text=question$CorrectAnswer), envir = e)
            e$expr <- parse(text = question$CorrectAnswer)[[1]]
            tryCatch({
              attach(e)
              stopifnot(eval(parse(text=question$AnswerTests), envir = e))
            }, finally = {
              detach(e)
            })
          })
          if (grepl("correctVal", question$AnswerTests) && grepl("omnitest", question$AnswerTests)) {
            # Test if correctVal only compare with character or numeric vector of length 1
            stopifnot(is.character(e$val) || is.numeric(e$val))
            if (mode(e$val) == "numeric") stopifnot(length(e$val) == 1)
          }
        },
        "mult_question" = {
          e$val <- as.character(question$CorrectAnswer)
          stopifnot(eval(parse(text = question$AnswerTests), envir = e))
        },
        "script" = {
          question$correctScript <- file.path(lesson_dir, "scripts", paste(tools::file_path_sans_ext(question$Script), "-correct.R", sep = ""))
          if (file.exists(question$correctScript)) {
            cat("Testing script...\n")
            file.copy(question$correctScript, e$script_temp_path <- file.path(tempdir(), question$Script), overwrite = TRUE)
            tryCatch({
              attach(e)
              source(question$correctScript, local = globalenv())
              stopifnot(eval(parse(text = question$AnswerTests), envir = e))
            }, finally = {
              detach(e)
            })
          }
        }
      )
    } 
  }
  
  print(paste("-----Testing", lesson_dir, "Done"))
}

course_name <- basename(getwd())
setwd("..");install_course_directory(course_name);setwd(course_name)
course_list <- list.dirs(".", recursive = FALSE)
course_list <- grep("^\\./(\\d{2})|(Project)|(Optional)-", course_list, value = TRUE)
course_list <- substring(course_list, 3, nchar(course_list))
course_list <- grep("^[^\\.]", course_list, value = TRUE)
course_list <- setdiff(course_list, c("Project-ROpenData-DataTaipei", "Optional-RDataMining-01-Clustering", 
                                      "Optional-RDataMining-02-Classification", "Optional-RDataMining-03-Association-Rule",
                                      "Optional-RDataMining-04-Text-Mining"))

result.path <- ".result.csv"
result <- if (file.exists(result.path) && argv == "commit") {
  read.csv(result.path, header = TRUE, stringsAsFactors = FALSE)
} else {
  data.frame(course = course_list, result = FALSE, hash = "", stringsAsFactors = FALSE)
}
for(course in setdiff(course_list, result$course)) {
  result <- rbind(result, data.frame(course = course, result = FALSE, hash = "", stringsAsFactors = FALSE))
}

for(course in course_list) {
  course.result <- result[course == result$course,]
  ## check result
  if (course.result$result) {
    ## check hash
    if (tools::md5sum(file.path(course, "lesson.yaml")) == course.result$hash) {
      cat(sprintf("course: %s is passed! \n", course))
      next
    }
  }
  if (course %in% "Optional-RDataMining-02-Classification") {
    if (Sys.info()["sysname"] == "Windows") {
      Sys.setlocale(locale = "cht")
    } 
    test_lesson(course)
  } else {
    if (Sys.info()["sysname"] == "Windows") {
      for(locale in c("Chinese", "cht")) {
        Sys.setlocale(locale = locale)
        test_lesson(course)
      }
    } else {
      test_lesson(course)
    }
  }

  ## update result
  result$hash[result$course == course] <- tools::md5sum(file.path(course, "lesson.yaml"))
  result$result[result$course == course] <- TRUE
  write.csv(result, file = result.path, row.names = FALSE)
}


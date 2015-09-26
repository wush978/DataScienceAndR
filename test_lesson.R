library(methods)
library(yaml)
library(swirl)

test_lesson = function(lesson_dir){
  print(paste("####Begin testing", lesson_dir))
  .e <- environment(swirl:::any_of_exprs)
  attach(.e)
  on.exit(detach(.e))
  e = new.env()

  # Since the initLesson might change working directory, load lesson yaml first before that happens.
  lesson = yaml.load_file(paste0(lesson_dir,"/lesson.yaml"))
  
  
  for(R_file in c("/customTests.R", "/initLesson.R")){
    R_file_path = paste0(lesson_dir, R_file)
    if(file.exists(R_file_path)) source(R_file_path,local = e)
  }
  
  for(question in lesson){
    if(!is.null(question$CorrectAnswer) && question$Class=="cmd_question"){
      print(paste(">", question$CorrectAnswer))
      suppressWarnings({
        eval(parse(text=question$CorrectAnswer), envir = e)
        e$expr <- parse(text = question$CorrectAnswer)[[1]]
        stopifnot(eval(parse(text=question$AnswerTests), envir = e))
      })
    } 
  }
  
  print(paste("-----Testing", lesson_dir, "Done"))
}


course_list <- list.dirs(".", recursive = FALSE)
course_list <- substring(course_list, 3, nchar(course_list))
course_list <- grep("^[^\\.]", course_list, value = TRUE)
for(course in course_list) {
  test_lesson(course)
}

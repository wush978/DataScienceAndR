#install.packages("swirlify")
#install.packages("devtools")
#source("http://wush978.github.io/R/init-swirl.R")
library(devtools)
library(swirlify)
#new_lesson("Demo",".")
#set_lesson("Demo/lesson.yaml")
setwd("./DataScienceAndR/Project-ROpenData-Four-Asian-Tigers/lesson.yaml")
#可以協助編寫使用
source("./DataScienceAndR/.transform.R")
testit()
#Rscript .test_course.R push full test
#Rscript .test_course.R commit partial test

library(swirl)
uninstall_all_courses()
#setwd(paste(getwd(),"/../",sep=""))
#setwd("./github/")
#要跳離專案目錄位置到上一層
#install_course_directory("./")
#install_course_github("TaiwanRUserGroup",course_name = "DataScienceAndR",branch = "course")

swirl()

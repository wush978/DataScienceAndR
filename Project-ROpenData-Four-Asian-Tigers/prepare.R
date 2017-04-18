#install.packages("swirlify")
#install.packages("devtools")
source("http://wush978.github.io/R/init-swirl.R")
library(devtools)
library(swirlify)
install.packages('swirl', repos = 'http://wush978.github.io/R')
#new_lesson("Demo",".")
#set_lesson("Demo/lesson.yaml")
#setwd("./DataScienceAndR/Project-ROpenData-Four-Asian-Tigers/")
setwd("/Volumes/AhaStorage/A_Project/24_Swirl/DataScienceAndR/Project-ROpenData-Four-Asian-Tigers/")
#可以協助編寫使用
source("../.transform.R")
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

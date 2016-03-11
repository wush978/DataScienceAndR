# Code placed in this file fill be executed every time the
# lesson is started. Any variables created here will show up in
# the user's working directory and thus be accessible to them
# throughout the lesson.

wiki_join <- function() {
  browseURL("https://github.com/wush978/DataScienceAndR/wiki/dplyr-JOINS")
}

df1 <- data.frame(x = c(1, 2), y = 2:1)

df2 <- data.frame(x = c(1, 3), a = 10, b = "a", stringsAsFactors = FALSE)

df3 <- data.frame(x = c(1, 1, 2, 2), a = c(1, 1, 2, 2), b = 1:4)

df4 <- data.frame(x = c(1, 1, 3, 3), c = c(1, 1, 2, 2), d = 1:4)

assign("cl_info",
       read.table(file=file(.get_path("cl_info_other.csv"), encoding = "UTF-8"),
         sep=",",stringsAsFactors=FALSE,header=TRUE),
       envir = globalenv())

assign("gdp_path",
       .get_path("GDP.txt"),
       envir = globalenv())

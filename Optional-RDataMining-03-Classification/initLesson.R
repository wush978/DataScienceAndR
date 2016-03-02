# Code placed in this file fill be executed every time the
# lesson is started. Any variables created here will show up in
# the user's working directory and thus be accessible to them
# throughout the lesson.
e <- environment()
data(iris3, envir = e)
assign("X.train", 
       rbind(iris3[1:25,,1], iris3[1:25,,2], iris3[1:25,,3]),
       envir = globalenv())
assign("y.train",
       rep(c("setosa", "versicolor", "virginica"), each = 25),
       envir = globalenv())
assign("X.test",
       rbind(iris3[26:50,,1], iris3[26:50,,2], iris3[26:50,,3]),
       envir = globalenv())
assign("y.test",
       rep(c("setosa", "versicolor", "virginica"), each = 25),
       envir = globalenv())

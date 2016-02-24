# Code placed in this file fill be executed every time the
# lesson is started. Any variables created here will show up in
# the user's working directory and thus be accessible to them
# throughout the lesson.
assign2 <- function(name, value) {
  assign(name, value, envir = globalenv())
}

check_then_install("mlbench", "2.1.1")
.e <- new.env()
data(LetterRecognition, package = "mlbench", envir = .e)
set.seed(1)
index.group <- sample(1:3, nrow(.e$LetterRecognition), TRUE, c(0.4, 0.4, 0.2))
#' 依照index.group，對每一筆LetterRecognition的資料進行分組
group <- split(seq_len(nrow(.e$LetterRecognition)), index.group)

#' 接著，我們利用training.index建立training dataset和testing dataset
assign2("LetterRecognition.train", .e$LetterRecognition[group[[1]],])
assign2("LetterRecognition.tune", .e$LetterRecognition[group[[2]],])
test <- .e$LetterRecognition[group[[3]],]
test$lettr <- NULL
assign2("LetterRecognition.test", test)
rm(LetterRecognition, envir = .e)

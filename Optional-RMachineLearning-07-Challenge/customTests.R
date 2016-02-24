# Put custom tests in this file.

# Uncommenting the following line of code will disable
# auto-detection of new variables and thus prevent swirl from
# executing every command twice, which can slow things down.

# AUTO_DETECT_NEWVAR <- FALSE

# However, this means that you should detect user-created
# variables when appropriate. The answer test, creates_new_var()
# can be used for for the purpose, but it also re-evaluates the
# expression which the user entered, so care must be taken.
checker <- local({
  .e <- new.env()
  check_then_install("mlbench", "2.1.1")
  data(LetterRecognition, package = "mlbench", envir = .e)
  set.seed(1)
  index.group <- sample(1:3, nrow(.e$LetterRecognition), TRUE, c(0.4, 0.4, 0.2))
  test <- .e$LetterRecognition[group[[3]],]
  gen_checker <- function(y) {
    y <- as.character(y)
    force(y)
    function(p) {
      stopifnot(length(y) == length(p))
      mean(y == as.character(p))
    }
  }
  gen_checker(test$lettr)
})


ml_07 <- function() {
  tryCatch({
    answer_07 <- get("answer_07", envir = globalenv())
    if (answer_07 != "I give up! I will try this challenge next time.") {
      score <- checker(answer_07)
      tryCatch({
        stopifnot(score > 0.95)
      }, error = function(e) {
        message(sprintf("Your accuracy reaches %f!", score))
        stop("Let's try to make the accuracy reach 0.95")
      })
    }
    TRUE
  }, error = function(e) {
    FALSE
  })
}
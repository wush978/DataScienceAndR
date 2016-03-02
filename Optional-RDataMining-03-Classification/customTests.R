# Put custom tests in this file.

# Uncommenting the following line of code will disable
# auto-detection of new variables and thus prevent swirl from
# executing every command twice, which can slow things down.

# AUTO_DETECT_NEWVAR <- FALSE

# However, this means that you should detect user-created
# variables when appropriate. The answer test, creates_new_var()
# can be used for for the purpose, but it also re-evaluates the
# expression which the user entered, so care must be taken.

script_test_prefix <- function(n = 2) {
  e <- get("e", parent.frame(n = n))
  source_result <- try(source(e$script_temp_path, local = new.env(), encoding = "UTF-8"), silent = TRUE)
  if (class(source_result)[1] == "try-error") stop(sprintf("Syntax error: %s", conditionMessage(attr(source_result, "condition"))))
  e
}
dm_03_01 <- function() {
  tryCatch({
    e <- script_test_prefix()
    d <- get("d", envir = globalenv())
    m <- as.matrix(d)
    stopifnot(dim(m) == c(351, 351))
    i <- seq_len(301)
    j <- 301 + seq_len(50)
    m2 <- m[i,j]
    i.1nn <- apply(m2, 2, which.min)
    y.train <- get("y.train", envir = globalenv())
    y.test <- get("y.test", envir = globalenv())
    stopifnot(mean(y.train[i.1nn] == y.test) > 0.95)
    TRUE
  }, error = function(e) {
    message(conditionMessage(e))
    FALSE
  })
}

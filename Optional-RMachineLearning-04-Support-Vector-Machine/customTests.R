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

ml_04 <- function() {
  tryCatch({
    e <- script_test_prefix()
    answer_04 <- get("answer_04", envir = globalenv())
    logloss <- function(y, p, tol = 1e-4) {
      # tol 的用途是避免對0取log所導致的數值問題
      p[p < tol] <- tol
      p[p > 1 - tol] <- 1 - tol
      -sum(y * log(p) + (1 - y) * log(1-p))
    }
    stopifnot("svm" %in% class(answer_04))
    stopifnot(local({
      p <- predict(answer_04, df.test, probability = TRUE)
      logloss(df.test$Class == "good", attr(p, "probabilities")[,"good"]) < 4
    }))
    TRUE
  }, error = function(e) {
    message(conditionMessage(e))
    FALSE
  })
}

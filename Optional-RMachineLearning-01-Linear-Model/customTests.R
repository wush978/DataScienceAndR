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

ml_01_01 <- function() {
  tryCatch({
    e <- script_test_prefix()
    answer_01 <- get("answer_01", envir = globalenv())
    stopifnot(is.data.frame(answer_01))
    stopifnot(colnames(answer_01) == c("Species", "mean(Sepal.Length)"))
    stopifnot(sum(answer_01[[2]]) == 17.53)
    TRUE
  }, error = function(e) {
    message(conditionMessage(e))
    FALSE
  })
}

ml_01_02 <- function() {
  tryCatch({
    e <- script_test_prefix()
    answer_02 <- get("answer_02", envir = globalenv())
    stopifnot(is.numeric(answer_02))
    stopifnot(length(answer_02) == 1)
    stopifnot(answer_02 == sum(residuals(lm(Sepal.Length ~ .^3, iris))^2))
    TRUE
  }, error = function(e) {
    message(conditionMessage(e))
    FALSE
  })
}

ml_01_03 <- function() {
  tryCatch({
    e <- script_test_prefix()
    tryCatch({
      answer_03_01 <- get("answer_03_01", envir = globalenv())
      stopifnot(isTRUE(all.equal(answer_03_01, "medv")))
    }, error = function(e) {
      stop(sprintf("answer_03_01 is incorrect (%s)", conditionMessage(e)))
    })
    tryCatch({
      answer_03_02 <- get("answer_03_02", envir = globalenv())
      stopifnot(class(answer_03_02) == "lm")
      if (!isTRUE(all.equal(answer_03_02$model[,attr(answer_03_02$terms, "response")], BostonHousing$medv))) {
        stop("Response variable is incorrect")
      }
      stopifnot(summary(answer_03_02)$r.squared > 0.9)
    }, error = function(e) {
      stop(sprintf("answer_03_02 is incorrect (%s)", conditionMessage(e)))
    })
    tryCatch({
      answer_03_03 <- get("answer_03_03", envir = globalenv())
      stopifnot(class(answer_03_03) == "lm")
      if (!isTRUE(all.equal(answer_03_03$model[,attr(answer_03_03$terms, "response")], BostonHousing$medv))) {
        stop("Response variable is incorrect")
      }
      stopifnot(extractAIC(answer_03_03)[2] < 1089)
    }, error = function(e) {
      stop(sprintf("answer_03_03 is incorrect (%s)", conditionMessage(e)))
    })
    TRUE
  }, error = function(e) {
    message(conditionMessage(e))
    FALSE
  })
}
# 
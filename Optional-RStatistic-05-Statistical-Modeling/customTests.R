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

rstatistics_07 <- function() {
  tryCatch({
    e <- script_test_prefix()
    score2.train <- score2[,1:9]
    score2.test <- score2[,10]
    score2.predict1.ref <- rowMeans(score2.train)
    score2.predict1.bias.ref <- mean(score2.predict1.ref - score2.test)
    score2.predict1.var.ref <- var(score2.predict1.ref - score2.test)
    score2.predict2.ref <- local({
      df2 <- prepare_data(score2.train)
      g2 <- lm(after ~ before, df2)
      coef(g2)[1] + coef(g2)[2] * score2.train[,9]
    })
    score2.predict2.bias.ref <- mean(score2.predict2.ref - score2.test)
    score2.predict2.var.ref <- var(score2.predict2.ref - score2.test)
    name.list <- c("score2.predict1.bias", "score2.predict1.var",
                   "score2.predict2.bias", "score2.predict2.var")
    for(name in name.list) {
      value <- get(name, envir = globalenv())
      value.ref <- get(sprintf("%s.ref", name))
      if (abs(value - value.ref) > 1e-8) {
        stop(sprintf("%s is incorrect", name))
      }
    }
    TRUE
  }, error = function(e) {
    message(conditionMessage(e))
    FALSE
  })  
}
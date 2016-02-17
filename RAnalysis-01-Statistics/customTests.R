# Put custom tests in this file.

# Uncommenting the following line of code will disable
# auto-detection of new variables and thus prevent swirl from
# executing every command twice, which can slow things down.

# AUTO_DETECT_NEWVAR <- FALSE

# However, this means that you should detect user-created
# variables when appropriate. The answer test, creates_new_var()
# can be used for for the purpose, but it also re-evaluates the
# expression which the user entered, so care must be taken.

rstatistics_02 <- function() {
  e <- get("e", parent.frame())
  source_result <- try(source(e$script_temp_path, local = new.env(), encoding = "UTF-8"), silent = TRUE)
  if (class(source_result)[1] == "try-error") return(FALSE)
  mode <- function(x) {
    as.numeric(names(sort(-table(x))[1]))
  }
  name.list.raw <- expand.grid(c("x1", "x2", "x3"), c("mean", "median", "mode"), stringsAsFactors = FALSE)
  tryCatch({
    for(i in seq_len(nrow(name.list.raw))) {
      var.name <- name.list.raw$Var1[i]
      var.f <- name.list.raw$Var2[i]
      var <- get(var.name, envir = globalenv())
      f <- get(var.f)
      answer.ref <- f(var)
      answer <- get(sprintf("%s.%s", var.name, var.f), envir = globalenv())
      if (length(answer) != length(answer.ref)) {
        stop(sprintf("The length of %s.%s is incorrect", var.name, var.f))
      }
      if (answer != answer.ref) {
        stop(sprintf("%s.%s is incorrect", var.name, var.f))
      }
    }
    TRUE
  }, error = function(e) {
    message(conditionMessage(e))
    FALSE
  })
}

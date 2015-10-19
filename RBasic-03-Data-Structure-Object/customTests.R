# Put custom tests in this file.

# Uncommenting the following line of code will disable
# auto-detection of new variables and thus prevent swirl from
# executing every command twice, which can slow things down.

# AUTO_DETECT_NEWVAR <- FALSE

# However, this means that you should detect user-created
# variables when appropriate. The answer test, creates_new_var()
# can be used for for the purpose, but it also re-evaluates the
# expression which the user entered, so care must be taken.

rbasic_03_hw_test <- function() {
  e <- get("e", parent.frame())
  source_result <- try(source(e$script_temp_path, local = new.env(), encoding = "UTF-8"), silent = TRUE)
  if (class(source_result)[1] == "try-error") return(FALSE)
  name.list <- c("pca", "answer1", "answer2", "answer3", "answer4", "answer5")
  pca.ref <- prcomp(USArrests, scale = TRUE)
  answer1.ref <- "list"
  answer2.ref <- length(pca.ref)
  answer3.ref <- names(pca.ref)
  answer4.ref <- pca.ref$sdev
  answer5.ref <- pca.ref$center
  tryCatch({
    for(name in name.list) {
      if (!isTRUE(all.equal(
        get(name),
        get(sprintf("%s.ref", name))
      ))) stop(sprintf("%s is wrong! Try again.\n", name))
    }
    TRUE
  }, error = function(e) {
    cat(conditionMessage(e))
    FALSE
  })
}
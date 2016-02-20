# Put custom tests in this file.

# Uncommenting the following line of code will disable
# auto-detection of new variables and thus prevent swirl from
# executing every command twice, which can slow things down.

# AUTO_DETECT_NEWVAR <- FALSE

# However, this means that you should detect user-created
# variables when appropriate. The answer test, creates_new_var()
# can be used for for the purpose, but it also re-evaluates the
# expression which the user entered, so care must be taken.

rbasic_05_hw_test <- function() {
  e <- get("e", parent.frame())
  source_result <- try(source(e$script_temp_path, local = new.env(), encoding = "UTF-8"), silent = TRUE)
  if (class(source_result)[1] == "try-error") return(FALSE)
  name.list <- c("X", "beta", "y", "epsilon", "beta.hat")
  X.ref <- cbind(x1 = 1, x2 = 1:10, x3 = sin(1:10))
  beta.ref <- c(0.5, -1, 4.3)
  y.ref <- X.ref %*% beta.ref
  epsilon.ref <- c(-1.24462014500259, 0.146172987456978, 1.56426869006839, -0.856920339050681, 
               -1.15277300953772, 0.717919832604741, -0.270623615316431, -1.66281578024014, 
               -1.15557078461633, -0.730253254897595)
  y.ref <- y.ref + epsilon.ref
  beta.hat.ref <- solve(t(X.ref) %*% X.ref, t(X.ref) %*% y.ref)
  tryCatch({
    for(name in name.list) {
      if (!isTRUE(all.equal(
        get(name, envir = globalenv()),
        get(sprintf("%s.ref", name))
      ))) stop(sprintf("%s is wrong! Try again.\n", name))
    }
    TRUE
  }, error = function(e) {
    cat(conditionMessage(e))
    FALSE
  })
}
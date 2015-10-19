# Put custom tests in this file.

# Uncommenting the following line of code will disable
# auto-detection of new variables and thus prevent swirl from
# executing every command twice, which can slow things down.

# AUTO_DETECT_NEWVAR <- FALSE

# However, this means that you should detect user-created
# variables when appropriate. The answer test, creates_new_var()
# can be used for for the purpose, but it also re-evaluates the
# expression which the user entered, so care must be taken.

rbasic_06_hw_test <- function() {
  e <- get("e", parent.frame())
  source_result <- try(source(e$script_temp_path, local = new.env(), encoding = "UTF-8"), silent = TRUE)
  if (class(source_result)[1] == "try-error") return(FALSE)
  name.list <- c("answer1", "answer2", "answer3", "answer4", "answer5", 
                 "answer6", "answer7", "answer8", "X", "y", "beta.hat",
                 "answer11", "g", "g.s", "answer12")
  CO2.ref <- datasets::CO2
  answer1.ref <- nrow(CO2.ref)
  answer2.ref <- ncol(CO2.ref)
  answer3.ref <- colnames(CO2.ref)
  answer4.ref <- mean(CO2.ref$uptake)
  answer5.ref <- CO2.ref[CO2.ref$uptake > answer4.ref,]
  answer6.ref <- length(levels(CO2.ref$Type))
  answer7.ref <- mean(CO2.ref[CO2.ref$Type == "Quebec", "uptake"])
  answer8.ref <- mean(CO2.ref[CO2.ref$Type == "Mississippi", "uptake"])
  X.ref <- model.matrix(~ Type + Treatment + conc, CO2.ref)
  y.ref <- CO2.ref$uptake
  beta.hat.ref <- solve(t(X.ref) %*% X.ref, t(X.ref) %*% y.ref)
  answer11.ref <- cor(X.ref %*% beta.hat.ref, y.ref)
  CO2 <- datasets::CO2
  g.ref <- lm(uptake ~ Type + Treatment + conc, CO2)
  g.s.ref <- summary(g.ref)
  answer12.ref <- "r.squared"
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
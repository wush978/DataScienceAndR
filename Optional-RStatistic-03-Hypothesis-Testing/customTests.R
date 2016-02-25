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

rstatistics_05_01 <- function() {
  tryCatch({
    e <- script_test_prefix()
    e2 <- new.env()
    cat("Generating your result...\n")
    set.seed(1)
    source(e$script_temp_path, local = e2, encoding = "UTF-8")
    cat("Generating expected result of X.sample...\n")
    set.seed(1)
    X.sample <- sapply(1:10000, function(i) {
      # 請在這裡填入適當的參數，讓R從population.Kinmen中抽出20個樣本
      x <- sample(c(TRUE, FALSE), size = 10, replace = TRUE)
      sum(x)
    })
    if (!isTRUE(all.equal(X.sample, e2$X.sample))) {
      stop("The generation of X.sample is unexpected")
    }
    TRUE
  }, error = function(e) {
    message(conditionMessage(e))
    FALSE
  })
}

rstatistics_05_02 <- function() {
  tryCatch({
    e <- script_test_prefix()
    e2 <- new.env()
    cat("Generating your result...\n")
    set.seed(1)
    source(e$script_temp_path, local = e2, encoding = "UTF-8")
    cat("Generating expected result of X.sample...\n")
    set.seed(1)
    X.sample <- sapply(1:10000, function(i) {
      # 請在這裡填入適當的參數，讓R從population.Kinmen中抽出20個樣本
      x <- rnorm(20, 40.45, sqrt(417.94))
      median(x)
    })
    if (!isTRUE(all.equal(X.sample, e2$X.sample))) {
      stop("The generation of X.sample is unexpected")
    }
    TRUE
  }, error = function(e) {
    message(conditionMessage(e))
    FALSE
  })
}



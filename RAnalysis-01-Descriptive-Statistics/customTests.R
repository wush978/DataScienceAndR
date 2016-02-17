# Put custom tests in this file.

# Uncommenting the following line of code will disable
# auto-detection of new variables and thus prevent swirl from
# executing every command twice, which can slow things down.

# AUTO_DETECT_NEWVAR <- FALSE

# However, this means that you should detect user-created
# variables when appropriate. The answer test, creates_new_var()
# can be used for for the purpose, but it also re-evaluates the
# expression which the user entered, so care must be taken.

test_value_no_name <- function(reference) {
  e <- get("e", parent.frame())
  tryCatch({
    (e$val == reference) & (length(e$val) == length(reference))
  }, error = function(e) {
    message(conditionMessage(e))
    FALSE
  })
}

script_test_prefix <- function(n = 2) {
  e <- get("e", parent.frame(n = n))
  source_result <- try(source(e$script_temp_path, local = new.env(), encoding = "UTF-8"), silent = TRUE)
  if (class(source_result)[1] == "try-error") stop(sprintf("Syntax error: %s", conditionMessage(attr(source_result, "condition"))))
  e
}

rstatistics_template <- function(retval_name, f.name.list, var.name.list = c("x1", "x2", "x3", "x4")) {
  retval <- matrix(0.0, length(f.name.list), length(var.name.list))
  name.list.raw <- expand.grid(
    colnames(retval) <- var.name.list,
    rownames(retval) <- f.name.list,
    stringsAsFactors = FALSE
  )
  for(i in seq_len(nrow(name.list.raw))) {
    var.name <- name.list.raw$Var1[i]
    var.f <- name.list.raw$Var2[i]
    var <- get(var.name, envir = globalenv())
    f <- get(var.f, envir = parent.frame())
    answer.ref <- f(var)
    answer <- get(sprintf("%s.%s", var.name, var.f), envir = globalenv())
    if (length(answer) != length(answer.ref)) {
      stop(sprintf("The length of %s.%s is incorrect", var.name, var.f))
    }
    if (answer != answer.ref) {
      stop(sprintf("%s.%s is incorrect", var.name, var.f))
    }
    retval[var.f, var.name] <- answer
  }
  assign(retval_name, retval, envir = globalenv())
#   lockBinding(retval_name, globalenv())
  NULL
}

rstatistics_02 <- function() {
  tryCatch({
    e <- script_test_prefix()
    mode <- function(x) {
      as.numeric(names(sort(-table(x))[1]))
    }
    rstatistics_template("answer_02", c("mean", "median", "mode"))
    TRUE
  }, error = function(e) {
    message(conditionMessage(e))
    FALSE
  })
}

rstatistics_03_01 <- function() {
  tryCatch({
    e <- script_test_prefix()
    range <- function(x) diff(base::range(x))
    rstatistics_template("answer_03_01", c("min", "max", "range"))
    TRUE
  }, error = function(e) {
    message(conditionMessage(e))
    FALSE
  })
}

rstatistics_03_02 <- function() {
  tryCatch({
    e <- script_test_prefix()
    MD <- function(x) mean(abs(x - mean(x)))
    rstatistics_template("answer_03_02", c("MD"))
    TRUE
  }, error = function(e) {
    message(conditionMessage(e))
    FALSE
  })
}

rstatistics_03_03 <- function() {
  tryCatch({
    e <- script_test_prefix()
    MAD <- function(x) mad(x, constant = 1)
    rstatistics_template("answer_03_03", c("MAD"))
    TRUE
  }, error = function(e) {
    message(conditionMessage(e))
    FALSE
  })
}

rstatistics_03_04 <- function() {
  tryCatch({
    e <- script_test_prefix()
    rstatistics_template("answer_03_04", c("IQR"))
    TRUE
  }, error = function(e) {
    message(conditionMessage(e))
    FALSE
  })
}

rstatistics_03_05 <- function() {
  tryCatch({
    e <- script_test_prefix()
    rstatistics_template("answer_03_05", c("var", "sd"))
    TRUE
  }, error = function(e) {
    message(conditionMessage(e))
    FALSE
  })
}

rstatistics_03_06 <- function() {
  tryCatch({
    e <- script_test_prefix()
    CV <- function(x) sd(x) / mean(x)
    rstatistics_template("answer_03_06", c("CV"))
    TRUE
  }, error = function(e) {
    message(conditionMessage(e))
    FALSE
  })
}

rstatistics_03_07 <- function() {
  tryCatch({
    e <- script_test_prefix()
    QCD <- function(x) IQR(x) / median(x)
    rstatistics_template("answer_03_07", c("QCD"))
    TRUE
  }, error = function(e) {
    message(conditionMessage(e))
    FALSE
  })
}

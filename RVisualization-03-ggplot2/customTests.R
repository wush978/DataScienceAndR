# Put custom tests in this file.

# Uncommenting the following line of code will disable
# auto-detection of new variables and thus prevent swirl from
# executing every command twice, which can slow things down.

# AUTO_DETECT_NEWVAR <- FALSE

# However, this means that you should detect user-created
# variables when appropriate. The answer test, creates_new_var()
# can be used for for the purpose, but it also re-evaluates the
# expression which the user entered, so care must be taken.

rvisualization_03_01 <- function(answer01) {
  e <- get("e", parent.frame())
  source_result <- source_by_l10n_info(e$script_temp_path)
  if (class(source_result)[1] == "try-error") return(FALSE)
  tryCatch({
    stopifnot(colnames(answer01) == c("sex", "count"))
    stopifnot(nrow(answer01) == 2)
    stopifnot(is.data.frame(answer01))
    stopifnot(sum(answer01$count) == nrow(hsb))
    stopifnot(sort(answer01$sex) == sort(c("female", "male")))
    stopifnot(answer01$count[answer01$sex == "female"] == 109)
    stopifnot(answer01$count[answer01$sex == "male"] == 91)
    TRUE
  }, error = function(e) {
    message(e)
    FALSE
  })
}

rvisualization_03_hw_01 <- function() {
  e <- get("e", parent.frame())
  hw_01()
  tryCatch({
    omnitest("begin_rvisualization_03()")
  }, error = function(e) {
    FALSE
  })
}

rvisualization_03_hw_02 <- function() {
  e <- get("e", parent.frame())
  hw_02()
  TRUE
}

rvisualization_03_hw_03 <- function() {
  e <- get("e", parent.frame())
  hw_03()
  TRUE
}

rvisualization_03_hw_finish <- function() {
  TRUE
}

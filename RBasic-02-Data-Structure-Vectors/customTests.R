# Put custom tests in this file.

# Uncommenting the following line of code will disable
# auto-detection of new variables and thus prevent swirl from
# executing every command twice, which can slow things down.

# AUTO_DETECT_NEWVAR <- FALSE

# However, this means that you should detect user-created
# variables when appropriate. The answer test, creates_new_var()
# can be used for for the purpose, but it also re-evaluates the
# expression which the user entered, so care must be taken.

rbasic_02_hw_test <- function() {
  e <- get("e", parent.frame())
  source_result <- try(source(e$script_temp_path, encoding = "UTF-8"), silent = TRUE)
  if (class(source_result)[1] == "try-error") return(FALSE)
  name.list <- c("year1", "power1", "power2", "year1.answer1", "power1.mean","power1.sd", 
                 "power1.z", "power2.mean", "power2.sd", "power2.z", "year1.answer2")
  year1.ref <-
    87:91
  power1.ref <-
    c(6097059332, 6425887925, 6982579022, 7323992602.53436, 7954239517
    )
  power2.ref <-
    c(59090445718, 61981666330, 67378329131, 66127460204.6482, 69696372914.6949
    )
  year1.answer1.ref <-
    90:91
  power1.mean.ref <-
    6956751679.70687
  power1.sd.ref <-
    733382947.600376
  power1.z.ref <-
    c(-1.17222843879828, -0.723856146974585, 0.0352167205109348, 
      0.500749197985988, 1.36011866727595)
  power2.mean.ref <-
    64854854859.6686
  power2.sd.ref <-
    4269407714.15836
  power2.z.ref <-
    c(-1.3501660013759, -0.672971222715612, 0.591059566169553, 0.298075384264502, 
      1.13400227365746)
  year1.answer2.ref <-
    87:91
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
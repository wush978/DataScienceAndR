# Put custom tests in this file.

# Uncommenting the following line of code will disable
# auto-detection of new variables and thus prevent swirl from
# executing every command twice, which can slow things down.

# AUTO_DETECT_NEWVAR <- FALSE

# However, this means that you should detect user-created
# variables when appropriate. The answer test, creates_new_var()
# can be used for for the purpose, but it also re-evaluates the
# expression which the user entered, so care must be taken.

rdataengineer_06_01 <- function(answer01) {
  answer01.ref <- local({
    # 請在此填寫你的程式碼
    slice(flights, 1:100) %>%
      select(year:day, tailnum, carrier) %>%
      left_join(y = airlines, by = "carrier")
  })
  retval <- all.equal(data.frame(answer01), data.frame(answer01.ref))
  if (!isTRUE(retval)) {
    message(retval)
    FALSE
  } else TRUE
}

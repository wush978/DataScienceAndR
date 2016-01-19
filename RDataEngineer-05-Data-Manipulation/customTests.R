# Put custom tests in this file.

# Uncommenting the following line of code will disable
# auto-detection of new variables and thus prevent swirl from
# executing every command twice, which can slow things down.

# AUTO_DETECT_NEWVAR <- FALSE

# However, this means that you should detect user-created
# variables when appropriate. The answer test, creates_new_var()
# can be used for for the purpose, but it also re-evaluates the
# expression which the user entered, so care must be taken.

test_equal <- function(a, b) {
  isTRUE(all.equal(a, b))
}

rdataengineer_05_04 <- function(answer04.1, answer04.2, answer04.3) {
  if (answer04.1 !=
    filter(flights, month == 1) %>%
    mutate(gain = arr_delay - dep_delay) %>%
    summarise(mean(gain, na.rm = TRUE)) %>%
    `[[`(1)) {
      message("answer04.1 is wrong")
      return(FALSE)
    }
  if (answer04.2 != FALSE) {
    message("answer04.2 is wrong")
    return(FALSE)
  }
  if (answer04.3 !=
    filter(flights, 2301 <= dep_time, dep_time <= 2400) %>%
    summarise(mean(dep_delay, na.rm = TRUE)) %>%
    `[[`(1)) {
      message("answer04.3 is wrong")
      return(FALSE)
    }
  TRUE

}

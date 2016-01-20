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
  e <- get("e", parent.frame())
  source_result <- try(source(e$script_temp_path, local = new.env(), encoding = "UTF-8"), silent = TRUE)
  if (class(source_result)[1] == "try-error") return(FALSE)
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

rdataengineer_05_05 <- function(answer05) {
  e <- get("e", parent.frame())
  source_result <- try(source(e$script_temp_path, local = new.env(), encoding = "UTF-8"), silent = TRUE)
  if (class(source_result)[1] == "try-error") return(FALSE)
  answer05.ref <-
    group_by(flights, month) %>%
    mutate(gain = arr_delay - dep_delay) %>%
    summarise(mean(gain, na.rm = TRUE))
  if (!isTRUE(all.equal(answer05, answer05.ref))) {
    message("answer05 is wrong")
    return(FALSE)
  }
  TRUE
}

rdataengineer_05_06 <- function(cl_info2, cl_info3) {
  e <- get("e", parent.frame())
  source_result <- try(source(e$script_temp_path, local = new.env(), encoding = "UTF-8"), silent = TRUE)
  if (class(source_result)[1] == "try-error") return(FALSE)
  check_equal <- function(a, b) {
    isTRUE(all.equal(a, b))
  }
  cl_info2.ref <- mutate(cl_info, month = substring(data_dt, 1, 7)) %>%
    select(month, mortgage_bal)
  if (!check_equal(cl_info2$month, cl_info2.ref$month)) {
    message("cl_info2$month is wrong")
    return(FALSE)
  }
  if (!check_equal(cl_info2$mortgage_bal, cl_info2.ref$mortgage_bal)) {
    message("cl_info2$mortgage_bal is wrong")
    return(FALSE)
  }
  cl_info3.ref <- group_by(cl_info2.ref, month) %>%
    summarise(mortgage_total_bal = sum(mortgage_bal)) %>%
    arrange(month)
    if (!check_equal(cl_info3$month, cl_info3.ref$month)) {
      message("cl_info3$month is wrong")
      return(FALSE)
    }
    if (!check_equal(cl_info3$mortgage_total_bal, cl_info3.ref$mortgage_total_bal)) {
      message("cl_info3$mortgage_total_bal is wrong")
      return(FALSE)
    }
  TRUE
}

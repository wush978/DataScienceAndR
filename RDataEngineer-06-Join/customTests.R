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
  e <- get("e", parent.frame())
  source_result <- try(source(e$script_temp_path, local = new.env(), encoding = "UTF-8"), silent = TRUE)
  if (class(source_result)[1] == "try-error") return(FALSE)
  answer01.ref <- local({
    # 請在此填寫你的程式碼
    slice(flights, 1:100) %>%
      select(year:day, hour, origin, dest, tailnum, carrier) %>%
      left_join(y = airlines, by = "carrier")
  })
  retval <- all.equal(data.frame(answer01), data.frame(answer01.ref))
  if (!isTRUE(retval)) {
    message(retval)
    FALSE
  } else TRUE
}

rdataengineer_06_02 <- function(answer02.1, answer02.2, answer02.3) {
  e <- get("e", parent.frame())
  source_result <- try(source(e$script_temp_path, local = new.env(), encoding = "UTF-8"), silent = TRUE)
  if (class(source_result)[1] == "try-error") return(FALSE)
  check_equal <- function(a, b, msg) {
    retval <- all.equal(a, b)
    if (!isTRUE(retval)) {
      message(msg)
      message(retval)
      FALSE
    } else TRUE
  }
  answer02.1.ref <- local({
    select(flights, year:day, hour, origin, dest, tailnum, carrier, arr_delay) %>%
      left_join(weather) %>%
      select(wind_speed, arr_delay) %>%
      filter(!is.na(wind_speed), !is.na(arr_delay))
  })
  if (!check_equal(answer02.1, answer02.1.ref, "answer02.1 is wrong")) {
    return(FALSE)
  }
  answer02.2.ref <- quantile(answer02.1.ref$wind_speed, seq(0, 1, by = 0.25))
  if (!check_equal(answer02.2, answer02.2.ref, "answer02.2 is wrong")) {
    return(FALSE)
  }
  answer02.3.ref <- local({
    mutate(answer02.1.ref, wind_speed = cut(wind_speed, breaks = c(-Inf, answer02.2.ref))) %>%
      group_by(wind_speed) %>%
      summarise(mean(arr_delay))
  })
  if (!check_equal(answer02.3, answer02.3.ref, "answer02.3 is wrong")) {
    return(FALSE)
  }
  TRUE
}

rdataengineer_06_hw <- function() {
  TRUE
}

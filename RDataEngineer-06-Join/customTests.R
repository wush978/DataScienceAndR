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


rdataengineer_06_hw <- function(gdp, cl_info_year, answerHW) {
  e <- get("e", parent.frame())
  source_result <- try(source(e$script_temp_path, local = new.env(), encoding = "UTF-8"), silent = TRUE)
  if (class(source_result)[1] == "try-error") return(FALSE)
  tryCatch({
    stopifnot(is.data.frame(gdp))
    stopifnot(colnames(gdp) == c("year", "gdp"))
    stopifnot(class(gdp$year) == "character")
    stopifnot(class(gdp$gdp) == "numeric")
    stopifnot(nrow(gdp) == 33)
    stopifnot(range(gdp$year) == c("1981", "2013"))
    stopifnot(range(gdp$gdp) == c(1810829,14564242) * 1000000)
    stopifnot(is.data.frame(cl_info_year))
    stopifnot(colnames(cl_info_year) == c("year", "mortgage_total_bal"))
    stopifnot(class(cl_info_year$year) == "character")
    stopifnot(class(cl_info_year$mortgage_total_bal) == "numeric")
    stopifnot(nrow(cl_info_year) == 9)
    stopifnot(range(cl_info_year$year) == c("2006", "2014"))
    stopifnot(range(cl_info_year$mortgage_total_bal) == c(3.79632e+12, 5.726784e+12))
    stopifnot(is.data.frame(answerHW))
    stopifnot(nrow(answerHW) == 8)
    stopifnot(colnames(answerHW) == c("year", "index"))
    stopifnot(class(answerHW$year) == "character")
    stopifnot(class(answerHW$index) == "numeric")
    stopifnot(min(answerHW$index) > 0.3)
    stopifnot(max(answerHW$index) < 0.4)
    answerHW.ref <- local({
      gdp <- local({
        # 請填寫你的程式碼
        read.table(gdp_path, skip = 4, header = FALSE, sep = ",") %>%
          slice(1:132) %>%
          select(season = V1, gdp = V2) %>%
          mutate(
            season = as.character(season),
            year = substring(season, 1, 4),
            gdp = gsub(pattern = ",", replacement = "", x = gdp), 
            gdp = as.numeric(gdp) * 1000000) %>%
          group_by(year) %>%
          summarise(gdp = sum(gdp))
      })
      cl_info_year <- local({
        select(cl_info, data_dt, mortgage_bal) %>%
          mutate(month = substring(data_dt,1,7)) %>%
          group_by(month) %>%
          summarise(mortgage_total_bal = sum(mortgage_bal, na.rm = TRUE)) %>%
          mutate(year = substring(month, 1, 4)) %>%
          group_by(year) %>%
          arrange(month) %>%
          summarise(month = head(month, 1), mortgage_total_bal = head(mortgage_total_bal, 1)) %>%
          select(year, mortgage_total_bal)
      })
      local({
        # 請在這邊填寫你的程式碼
        inner_join(cl_info_year, gdp, by = "year") %>%
          mutate(index = mortgage_total_bal / gdp) %>%
          select(year, index)
      })
    })
    stopifnot(sum(answerHW.ref$index) == sum(answerHW$index))
    TRUE
  }, error = function(e) {
    message(conditionMessage(e))
    FALSE
  })
}

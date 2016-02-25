# 我們定義gain為arr_delay - dep_delay

# 請算出1 月份平均的gain
answer04.1 <- local({
  filter(flights, month == 1) %>%
    mutate(gain = arr_delay - dep_delay) %>%
    summarise(mean(gain, na.rm = TRUE)) %>%
    `[[`(1)
})
stopifnot(class(answer04.1) == "numeric")
stopifnot(length(answer04.1) == 1)

# 請問carrier為AA的飛機，是不是tailnum都有AA字眼？
answer04.2 <- local({
  # 請填寫你的程式碼
  # 請給出你的答案： TRUE or FALSE
  retval <-
    filter(flights, carrier == "AA", !grepl("AA", tailnum)) %>%
    nrow
  retval == 0
})
stopifnot(class(answer04.2) == "logical")
stopifnot(length(answer04.2) == 1)

# 請問dep_time介於 2301至2400之間的平均dep_delay為何
answer04.3 <- local({
  # 請填寫你的程式碼
  retval <-
    filter(flights, 2301 <= dep_time, dep_time <= 2400) %>%
    summarise(mean(dep_delay, na.rm = TRUE))
  retval[[1]]
})
stopifnot(class(answer04.3) == "numeric")
stopifnot(length(answer04.3) == 1)

# 完成後請存檔，並回到console輸入`submit()`

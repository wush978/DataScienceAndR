# 這是一種計算answer04.1的方式
# answer04.1 <- local({
#   retval <-
#     filter(flights, month == 1) %>%
#     mutate(gain = arr_delay - dep_delay) %>%
#     summarise(mean(gain, na.rm = TRUE))
#   retval[[1]]
# })

answer05 <- local({
  result <-
    # 為了清楚起見，再寫一次df的定義
    group_by(flights, month) %>%
    # mutate 和 summarise 的部份就照抄
    mutate(gain = arr_delay - dep_delay) %>%
    summarise(mean(gain, na.rm = TRUE))
  result[[1]]
})

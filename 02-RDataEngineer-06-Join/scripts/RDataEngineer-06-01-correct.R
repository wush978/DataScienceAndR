answer01 <- local({
  # 請在此填寫你的程式碼
  slice(flights, 1:100) %>%
    select(year:day, hour, origin, dest, tailnum, carrier) %>%
    left_join(y = airlines, by = "carrier")
})
# 結束之後請回到console輸入`submit()`

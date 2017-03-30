# local函數只會輸出最後一個expression的結果
# 所以中間建立的變數不會污染到外部
answer01 <- local({
  # 提示：先拿flights$month 和 1 比較
  month_is_1 <- flights$month == 1
  # 再拿flights$day 和 1 比較
  day_is_1 <- flights$day == 1
  # 拿上面兩個比較結果做 & 後丟到中括號的第一個參數。
  is_target <- month_is_1 & day_is_1
  flights[is_target,]
})

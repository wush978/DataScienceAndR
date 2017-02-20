# 請計算sex類別的個數。

answer01 <- local({
  # 請在這邊填寫你的程式碼。
  group_by(hsb, <請填寫欄位>) %>%
    summarise(count = n())
})

# 請先確定你的答案通過以下測試。
stopifnot(colnames(answer01) == c("sex", "count"))
stopifnot(nrow(answer01) == 2)
stopifnot(is.data.frame(answer01))
stopifnot(sum(answer01$count) == nrow(hsb))
stopifnot(sort(answer01$sex) == sort(c("female", "male")))

# 確認完畢之後，請回到console輸入`submit()`

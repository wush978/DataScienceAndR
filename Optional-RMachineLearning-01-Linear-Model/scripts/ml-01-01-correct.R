check_then_install("dplyr", "0.4.3")

# 請計算出iris的三種花的種類，所帶有的平均Sepal.Length
answer_01 <- local({
  data(iris)
  group_by(iris, Species) %>%
    summarise(mean(Sepal.Length))
})

stopifnot(is.data.frame(answer_01))
stopifnot(colnames(answer_01) == c("Species", "mean(Sepal.Length)"))
stopifnot(sum(answer_01[[2]]) == 17.53)

# 完成後，請同學存檔並回到console輸入：`submit()`

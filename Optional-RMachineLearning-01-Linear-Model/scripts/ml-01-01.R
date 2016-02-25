packageVersion("dplyr") # 套件版本如果比0.4.3還低，請安裝新的dplyr套件
library(dplyr) # 請載入dplyr套件

# 請計算出iris的三種花的種類，所帶有的平均Sepal.Length
answer_01 <- local({
  
})

stopifnot(is.data.frame(answer_01))
stopifnot(colnames(answer_01) == c("Species", "mean(Sepal.Length)"))
stopifnot(sum(answer_01[[2]]) == 17.53)

# 完成後，請同學存檔並回到console輸入：`submit()`

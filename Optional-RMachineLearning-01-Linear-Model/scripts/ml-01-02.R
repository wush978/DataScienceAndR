# 請同學計算一個有所有三次交互作用項的模型
# Residuals的平方和為多少。
answer_02 <- local({
  m.iris3 <- lm(Sepal.Length ~ .^<?>, iris) # 請修改這段程式碼
  sum(residuals(m.iris3)^2)
})

stopifnot(class(answer_02) == "numeric")
stopifnot(length(answer_02) == 1)

# 完成後，請同學存檔並回到console輸入：`submit()`


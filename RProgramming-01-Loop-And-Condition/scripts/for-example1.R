# 重新初始化x 的內容
x <- numeric(100)
x[1] <- 3
# 尋找x^2的最小值
for(i in 1:99) {
  x[i + 1] <- x[i] - 0.2 * x[i]
  if (abs(x[i + 1] - x[i]) < 0.01) break
}
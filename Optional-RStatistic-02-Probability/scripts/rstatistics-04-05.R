# 給定20個金門縣縣民樣本
#   - $X1$代表樣本的年齡平均數
#   - $X2$代表樣本的年齡中位數
#   - $X3$代表樣本的年齡平均數再乘以0.99
# 請分別估計$X1$、$X2$與$X3$和金門縣全縣縣民比較的偏差和變異數
X1.sample <- X.sample # 這是之前產生的樣本
stopifnot(class(X1.sample) == "numeric")
stopifnot(length(X1.sample) == 10000)

X2.sample <- sapply(1:10000, function(i) {
  # R從population.Kinmen中抽出20個樣本
  x <- sample(x = population.Kinmen, size = 20)
  # 請計算樣本的中位數
})
stopifnot(class(X2.sample) == "numeric")
stopifnot(length(X2.sample) == 10000)

X3.sample <- sapply(1:10000, function(i) {
  # R從population.Kinmen中抽出20個樣本
  x <- sample(x = population.Kinmen, size = 20)
  # 請計算樣本的平均數後乘以0.99
})
stopifnot(class(X3.sample) == "numeric")
stopifnot(length(X3.sample) == 10000)

# 完成後，請存檔並回到console輸入`submit()`


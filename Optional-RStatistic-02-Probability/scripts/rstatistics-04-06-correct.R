# 給定20個金門縣縣民樣本
# - $X1$代表20名金門縣縣民的樣本平均數
# - $X2$代表50名金門縣縣民的樣本平均數
# - $X3$代表100名金門縣縣民的樣本平均數
X1.sample <- X.sample # 這是之前產生的樣本
stopifnot(class(X1.sample) == "numeric")
stopifnot(length(X1.sample) == 10000)

X2.sample <- sapply(1:10000, function(i) {
  # R從population.Kinmen中抽出50個樣本
  x <- sample(x = population.Kinmen, size = 50)
  # 請計算樣本的平均數
  mean(x)
})
stopifnot(class(X2.sample) == "numeric")
stopifnot(length(X2.sample) == 10000)

X3.sample <- sapply(1:10000, function(i) {
  # R從population.Kinmen中抽出20個樣本
  x <- sample(x = population.Kinmen, size = 100)
  # 請計算樣本的平均數
  mean(x)
})
stopifnot(class(X3.sample) == "numeric")
stopifnot(length(X3.sample) == 10000)

# 完成後，請存檔並回到console輸入`submit()`


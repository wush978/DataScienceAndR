X.sample <- sapply(1:10000, function(i) {
  # 請在這裡填入適當的參數，讓R從population.Kinmen中抽出20個樣本
  x <- sample(x = population.Kinmen, size = 20)
  mean(x)
})

stopifnot(class(X.sample) == "numeric")
stopifnot(length(X.sample) == 10000)

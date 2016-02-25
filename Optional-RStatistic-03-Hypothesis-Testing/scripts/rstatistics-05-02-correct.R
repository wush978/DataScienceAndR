X.sample <- sapply(1:10000, function(i) {
  # 請參考前幾題的答案，從常態分佈中抽出20個樣本
  x <- rnorm(20, 40.45, sqrt(417.94))
  median(x)
})
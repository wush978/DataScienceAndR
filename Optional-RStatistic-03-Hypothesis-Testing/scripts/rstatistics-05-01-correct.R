X.sample <- sapply(1:10000, function(i) {
  x <- sample(c(TRUE, FALSE), size = 10, replace = TRUE) 
  # 請計算x 中TRUE的個數
  sum(x)
})

X.sample <- sapply(1:10000, function(i) {
  # 請在這裡填入適當的參數，讓R從population.Kinmen中抽出20個樣本
  x <- sample(x = <請填寫你的程式碼>, size = <請填寫你的程式碼>)
  mean(x)
})

stopifnot(class(X.sample) == "numeric")
stopifnot(length(X.sample) == 10000)

# 完成後，請存檔並回到console輸入`submit()`

# 我們先重新整理

score2.train <- score2[,1:9]
score2.test <- score2[,10]

# 練習七之三
score2.predict1 <- local({
  
})

score2.predict1.bias <- local({
  
})

score2.predict1.var <- local({
  
})

# 練習七之四
score2.predict2 <- local({
  
})

score2.predict2.bias <- local({
  
})

score2.predict2.var <- local({
  
})

stopifnot(length(score2.predict1) == 10)
stopifnot(length(score2.predict2) == 10)

# 完成後，請存檔並回到console輸入`submit()`
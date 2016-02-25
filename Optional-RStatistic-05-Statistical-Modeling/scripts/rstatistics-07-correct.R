# 我們先重新整理

score2.train <- score2[,1:9]
score2.test <- score2[,10]

# 練習七之三
score2.predict1 <- local({
  rowMeans(score2.train)
})

score2.predict1.bias <- mean(score2.predict1 - score2.test)

score2.predict1.var <- var(score2.predict1 - score2.test)

# 練習七之四
score2.predict2 <- local({
  df2 <- prepare_data(score2.train)
  g2 <- lm(after ~ before, df2)
  coef(g2)[1] + coef(g2)[2] * score2.train[,9]
})

score2.predict2.bias <- mean(score2.predict2 - score2.test)

score2.predict2.var <- var(score2.predict2 - score2.test)

stopifnot(length(score2.predict1) == 10)
stopifnot(length(score2.predict2) == 10)

# 完成後，請存檔並回到console輸入`submit()`

# 方便起見，同學可以使用這個函數計算 Logarithmic Loss
logloss <- function(y, p, tol = 1e-4) {
  # tol 的用途是避免對0取log所導致的數值問題
  p[p < tol] <- tol
  p[p > 1 - tol] <- 1 - tol
  -sum(y * log(p) + (1 - y) * log(1-p))
}

# 請找出一個在df.test上的logloss小於24.5的模型
answer_02 <- local({
  NULL
  # 請填寫你的程式碼
  step(m1, trace = 0)
})
stopifnot(class(answer_02) == c("glm", "lm"))
stopifnot(logloss(df.test$Class == "good", predict(answer_02, df.test, type = "response")) < 24.5)

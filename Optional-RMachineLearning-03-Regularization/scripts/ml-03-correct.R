check_then_install("mlbench", "2.1.1")
library(mlbench)
# 方便起見，同學可以使用這個函數計算 Logarithmic Loss
logloss <- function(y, p, tol = 1e-4) {
  # tol 的用途是避免對0取log所導致的數值問題
  p[p < tol] <- tol
  p[p > 1 - tol] <- 1 - tol
  -sum(y * log(p) + (1 - y) * log(1-p))
}

data(Ionosphere)
test.i <- c(4L, 6L, 9L, 13L, 14L, 22L, 31L, 33L, 50L, 52L, 61L, 63L, 68L, 
  79L, 91L, 99L, 119L, 135L, 154L, 155L, 160L, 162L, 166L, 194L, 
  200L, 219L, 233L, 236L, 237L, 242L, 244L, 248L, 250L, 257L, 261L, 
  276L, 278L, 283L, 292L, 310L, 312L, 315L, 319L, 323L, 325L, 327L, 
  335L, 337L, 338L, 344L)
df.test <- Ionosphere[test.i,-2] # remove V2
train.i <- setdiff(seq_len(nrow(Ionosphere)), test.i)
df.train <- Ionosphere[train.i,-2]

# 上一個單元，我們請同學找到df.test上的logloss小於26的模型
# 我們想要讓同學透過glmnet找到更好的模型
# X.train 是等等要放到glmnet的x參數的值
X.train <- model.matrix(Class ~ ., df.train)[,-1]
# y.train 是等等要放到glmnet的y參數的值
y.train <- df.train$Class
# 請同學透過找到適當的lambda、alplha組合
# 利用glmnet在df.train上學出一個模型，
# 它在df.test上logloss小於8
answer_03 <- local({
  NULL
  # 你的最終物件應該要由以下的程式碼產生：
  # glmnet(x = X.train, y = y.train, lambda = ?, alpha = ?, family = "binomial")
  glmnet(x = X.train, y = y.train, lambda = 0.00514326, alpha = 1, family = "binomial")
})
stopifnot(class(answer_03) == c("lognet", "glmnet"))
stopifnot(length(answer_03$lambda) == 1) # 你的答案應該要指定lambda
if (interactive()) { # 讓自動測試略過以下程式碼
  stopifnot(logloss(
    df.test$Class == "good", 
    predict(answer_03, model.matrix(Class ~ ., df.test)[,-1], type = "response")) <
      8
    )
}

# 完成以後請存檔並回到console輸入`submit()`
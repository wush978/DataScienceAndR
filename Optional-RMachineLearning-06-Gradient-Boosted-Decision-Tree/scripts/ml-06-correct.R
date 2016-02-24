check_then_install("mlbench", "2.1.1")
library(mlbench)
# 方便起見，同學可以使用這個函數計算 Logarithmic Loss
logloss <- function(y, p, tol = 1e-4) {
  # tol 的用途是避免對0取log所導致的數值問題
  p[p < tol] <- tol
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

# X 是等等要放到的x參數的值
X.train <- model.matrix(Class ~ ., df.train)[,-1]
X.test <- model.matrix(Class ~ ., df.test)[,-1]
# y 是等等要放到glmnet的y參數的值
y.train <- df.train$Class == "good"
y.test <- df.test$Class == "good"

# 請利用xgboost，從df.train上學出一個模型
# 該模型在df.test上的logloss需要小於3
answer_06 <- local({
  NULL
  # 請修改下列的程式碼
  # xgboost(X.train, y.train, nround = ?, eta = ?, objective = "binary:logistic")
  xgboost(X.train, y.train, nround = 100, eta = 0.1, objective = "binary:logistic")
})

stopifnot(class(answer_06) == "xgb.Booster")
if (interactive()) {
  stopifnot(local({
    p <- predict(answer_06, X.test)
    logloss(y.test, p) < 3
  }))
}

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
logloss2 <- function(answer_04) {
  p <- predict(answer_04, df.test, probability = TRUE)
  logloss(df.test$Class == "good", attr(p, "probabilities")[,"good"])
}
# 請利用e1071的svm函數，透過調整參數，建立一個logloss小於4的模型
answer_04 <- local({
  # NULL
  # 你的程式碼應該很類似以下的程式碼：
  # svm(Class ~ ., df.train, C = ?, kernel = ?, ..., probability = TRUE)
})

stopifnot("svm" %in% class(answer_04))
if (interactive()) {
  stopifnot(local({
    p <- predict(answer_04, df.test, probability = TRUE)
    logloss(df.test$Class == "good", attr(p, "probabilities")[,"good"]) < 4
  }))
}

# 完成後，請存檔並在console輸入`submit()`
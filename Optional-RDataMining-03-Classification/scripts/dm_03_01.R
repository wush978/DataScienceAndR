# 使用 ML 習題用的 Ionosphere 資料集
check_then_install("mlbench", "2.1.1")
library(mlbench)

data(Ionosphere)
test.i <- c(4L, 6L, 9L, 13L, 14L, 22L, 31L, 33L, 50L, 52L, 61L, 63L, 68L, 
  79L, 91L, 99L, 119L, 135L, 154L, 155L, 160L, 162L, 166L, 194L, 
  200L, 219L, 233L, 236L, 237L, 242L, 244L, 248L, 250L, 257L, 261L, 
  276L, 278L, 283L, 292L, 310L, 312L, 315L, 319L, 323L, 325L, 327L, 
  335L, 337L, 338L, 344L)
df.test <- Ionosphere[test.i,-2] # remove V2
X.test <- df.test[,-34]
y.test <- df.test$Class
train.i <- setdiff(seq_len(nrow(Ionosphere)), test.i)
df.train <- Ionosphere[train.i,-2]
X.train <- df.train[,-34]
y.train <- df.train$Class

# 以下程式碼示範用euclidean distance來計算1NN的分類結果。
df <- rbind(X.train, X.test)
d <- dist(df, method = "euclidean")
m <- as.matrix(d)
i <- seq_len(nrow(df.train))
j <- nrow(df.train) + seq_len(nrow(df.test))
m2 <- m[i,j]
i.1nn <- apply(m2, 2, which.min)
answer1 <- mean(y.test == y.train[i.1nn])

# 請同學修改上述程式碼中，dist函數的參數
# 讓R使用其他的「距離定義」，找出讓answer1的準確度超過0.95的結果
# 細節可以參考 ?dist 的說明文件
# 完成後請存檔後輸入`submit()`


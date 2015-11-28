#' 這份作業會讓同學走一次實務做模型比較的流程
#' 請同學先安裝好 mlbench和caret和glmnet套件，再進行這個作業

Sys.setenv("THIS_IS_NOT_HUMAN" = "TRUE")

library(rpart)
library(xgboost)
library(e1071)
library(mlbench)
library(caret)
data(LetterRecognition, package = "mlbench")
summary(LetterRecognition)

#' 這是一個字母辨識的資料。有興趣的同學請 ?LetterRecognition 看資料出處。

#' 為了要比較不同方法的準確度，
#' 我們需要把LetterRecognition資料集分成training, tuning和testing三份

#' 我們幫每一個instance分配到1, 2, 3 三個組別去
#' 這三個整數分別對應：training, tuning 和testing
set.seed(1)
index.group <- sample(1:3, nrow(LetterRecognition), TRUE, c(0.4, 0.4, 0.2))
#' 依照index.group，對每一筆LetterRecognition的資料進行分組
group <- split(seq_len(nrow(LetterRecognition)), index.group)

#' 接著，我們利用training.index建立training dataset和testing dataset
LetterRecognition.train <- LetterRecognition[group[[1]],]
LetterRecognition.tune <- LetterRecognition[group[[2]],]
LetterRecognition.test <- LetterRecognition[group[[3]],]
#' 取得測試資料的結果
answer <- LetterRecognition.test$lettr

if (interactive() & Sys.getenv("THIS_IS_NOT_HUMAN") != "TRUE") { # 自動測試會略過這段

  #' 請同學用rpart 與預設參數，在LetterRecognition.train上學一個decision tree model
  #' 這裡的formula應該使用 lettr ~ .，代表依據lettr以外的變數來預測lettr
  g.dt <- rpart(lettr ~ ., LetterRecognition.train)
  stopifnot(class(g.dt) == "rpart")
  
  p.dt <- predict(g.dt, LetterRecognition.test, type = "class")
  stopifnot(class(p.dt) == "factor")
  stopifnot(levels(p.dt) == levels(LetterRecognition$Species))
  
  #' 由於xgboost 不吃formula interface，我們需要手動建立矩陣和輸出向量
  formula <- reformulate(setdiff(colnames(LetterRecognition), "lettr"))
  xgtrain <- xgb.DMatrix(data = model.matrix(formula, LetterRecognition.train), 
                         label = as.integer(LetterRecognition.train$lettr) - 1)
  xgtune <- xgb.DMatrix(data = model.matrix(formula, LetterRecognition.tune),
                        label = as.integer(LetterRecognition.tune$lettr) - 1)
  xgtest <- xgb.DMatrix(data = model.matrix(formula, LetterRecognition.test))
  
  #' 接著，我們利用xgboost從training dataset學出一個模型
  g.bst <- xgboost(xgtrain, nround = 10, 
                   objective = "multi:softprob", num_class = 26)
  #' 我們可以再用以下的方法把xgboost的輸出轉回字母辨識的factor
  p.bst <- matrix(predict(g.bst, xgtest), ncol = 26, byrow = 3)
  stopifnot(class(p.bst) == "matrix")
  stopifnot(dim(p.bst) == c(nrow(LetterRecognition.test), 26L))
  
  p.bst <- factor(apply(p.bst, 1, which.max))
  levels(p.bst) <- levels(LetterRecognition$lettr)
  
  #' 最後，我們來學一個svm 的模型與預測
  g.svm <- svm(lettr ~ ., LetterRecognition.train)
  p.svm <- predict(g.svm, LetterRecognition.test)
  
  #' 我們可以簡單用table來比較分類得到的字母和實際的字母
  table(p.dt, answer)
  table(p.bst, answer)
  table(p.svm, answer)
  
  #' caret 套件的confusionMatrix函數可以更仔細的檢視三個分類器的表現
  confusionMatrix(p.dt, answer)
  confusionMatrix(p.bst, answer)
  confusionMatrix(p.svm, answer)
}


#' 其實我們可以把每一種模型的參數調整的更好，這就是當初保留tuning dataset的意義
answer.tune <- LetterRecognition.tune$lettr

#' 我們讓參數cp 從1e-1跑到1e-6，看看在tuning dataset上的準確度
if (interactive() & Sys.getenv("THIS_IS_NOT_HUMAN") != "TRUE") { # 自動測試會略過這段
  cp.value.list <- c(1e-1, 1e-2, 1e-3, 1e-4, 1e-5, 1e-6)
  accuracy.dt <- sapply(cp.value.list, function(cp.value) {
    g.dt <- rpart(lettr ~ ., LetterRecognition.train, control = rpart.control(cp = cp.value))
    v.dt <- predict(g.dt, LetterRecognition.tune, type = "class")
    mean(v.dt == answer.tune)
  })
  print(cbind(cp.value.list, accuracy.dt)) # 請同學看看
}

#' 請同學使用剛剛結果最好的cp參數，
#' 1) 在training dataset上學出一個decision tree的模型，
#' 把這個模型在tuning dataset上的預測結果存到變數v1.dt2
v1.dt2 <- NULL # 請把NULL換成你的程式碼
#' 2) 在tuning dataset上學出一個decision tree的模型，
#' 把這個模型在training dataset上的預測結果存到變數v2.dt2
v2.dt2 <- NULL # 請把NULL換成你的程式碼
#' 3) 在training 和 tuning dataset上共同學一個模型
#'    ps. 你可以用rbind來合併兩個資料集
#' 把這個模型在testing dataset的預測結果存到變數p.dt2
p.dt2 <- NULL # 請把NULL換成你的程式碼

#' 我們也可以eta, max_depth讓GDBT在tuning dataset上的效果最好
#' 並且加大nround，為了預防overfitting，也啟用early stop 

#' 列出想要測試的參數組合：
if (interactive() & Sys.getenv("THIS_IS_NOT_HUMAN") != "TRUE") { # 自動測試會略過這段
  xgb.param.grid <- expand.grid(
    eta = c(0.2, 0.3, 0.4),
    max_depth = c(5, 6, 7)
  )
  #' 嘗試上面的每一個參數組合
  xgb.param.accuracy <- apply(xgb.param.grid, 1, function(param) {
    xgb.param <- list(objective = "multi:softprob",
                      num_class = 26, 
                      eta = param["eta"], 
                      max_depth = param["max_depth"])
    #' 這裡我們也運用tuning dataset來讓xgboost啟用early stop 的機制。
    #' 如果模型在tuning dataset上的error沒降低的話，xgboost就會提早中止迭代。
    g.bst <- xgb.train(xgb.param, xgtrain, nrounds = 100, print.every.n = 10,
                       watchlist = list(val = xgtune, train = xgtrain),
                       early.stop.round = 50, maximize = FALSE)
    v.bst <- matrix(predict(g.bst, xgtune), ncol = 26, byrow = 3)
    v.bst <- factor(apply(v.bst, 1, which.max))
    levels(v.bst) <- levels(LetterRecognition$lettr)
    mean(v.bst == answer.tune)
  })
  cbind(xgb.param.grid, xgb.param.accuracy)
}

#' 請同學使用剛剛結果最好的參數組合，學出一個GDBT的模型物件，
#' 1) 在training dataset上學出一個GDBT的模型，
#' 把這個模型在tuning dataset上的預測結果存到變數v1.bst2
v1.bst2 <- NULL # 請把NULL換成你的程式碼
#' 2) 在tuning dataset上學出一個GDBT的模型，
#' 把這個模型在training dataset上的預測結果存到變數v2.bst2
v2.bst2 <- NULL # 請把NULL換成你的程式碼
#' 3) 在training 和 tuning dataset上共同學一個模型
#'    ps. 你可以用rbind來合併兩個資料集
#' 把這個模型在testing dataset的預測結果存到變數p.bst2
xgtrainall <- xgb.DMatrix(data = model.matrix(formula, rbind(LetterRecognition.train, LetterRecognition.tune)), 
                          label = as.integer(c(LetterRecognition.train$lettr, LetterRecognition.tune$lettr)) - 1)
p.bst2 <- NULL # 請把NULL換成你的程式碼

#' 
#' 上述的結果可能也提示了未來要提昇結果時，參數組合的搜尋方向

#' 另外請同學想想，eta 是不是越大越好？
#' 另外請同學想想，max_depth 是不是越大越好？

#' 最後，我們來調整svm 的cost parameter
if (interactive() & Sys.getenv("THIS_IS_NOT_HUMAN") != "TRUE") { # 自動測試會略過這段
  svm.cost.grid <- c(0.1, 0.5, 1.0, 2, 10)
  svm.cost.accuracy <- sapply(svm.cost.grid, function(svm.cost) {
    g.svm <- svm(lettr ~ ., LetterRecognition.train, cost = svm.cost)
    v.svm <- predict(g.svm, LetterRecognition.tune)
    mean(v.svm == answer.tune)  
  })
  cbind(svm.cost.grid, svm.cost.accuracy)
}

#' 請同學使用剛剛結果最好的cost參數，學出一個svm 的模型物件，
#' 1) 在training dataset上學出一個svm 的模型，
#' 把這個模型在tuning dataset上的預測結果存到變數v1.svm2
v1.svm2 <- NULL # 請把NULL換成你的程式碼
#' 2) 在tuning dataset上學出一個GDBT的模型，
#' 把這個模型在training dataset上的預測結果存到變數v2.svm2
v2.svm2 <- NULL # 請把NULL換成你的程式碼
#' 3) 在training 和 tuning dataset上共同學一個模型
#'    ps. 你可以用rbind來合併兩個資料集
#' 把這個模型在testing dataset的預測結果存到變數p.svm2
p.svm2 <- NULL # 請把NULL換成你的程式碼


#' 另外請同學想想，cost 是不是越大越好？

#' 我們比較一下六個結果的performance

confusionMatrix(p.dt2, answer)
confusionMatrix(p.bst2, answer)
confusionMatrix(p.svm2, answer)

#' 以Overall Accuracy來看，最好的結果是？ 
#' 請從c("dt", "bst", "svm")中挑選一個
best.model <- NULL

if (interactive() & Sys.getenv("THIS_IS_NOT_HUMAN") != "TRUE") { # 自動測試會略過這段
  
  #' BONUS
  #' 趁這個機會，我們來試試看一個現代Machine Learning 競賽常用的技巧：
  #' Stacked Generalization
  #' Reference: 
  #'   - http://mlwave.com/kaggle-ensembling-guide/
  #'   - http://www.researchgate.net/publication/222467943_Stacked_Generalization 
  #' 
  #' 這個技巧可以混合許多既有模型，生出一個更好的模型。
  #' 
  #' 接下來我們要利用剛剛產生的：
  #' 1. training dataset => tuning dataset 的預測結果
  #' 2. tuning dataset => training dataset 的預測結果
  #' 3. training dataset + tuning dataset => testing dataset 的預測結果
  #' 再使用glmnet套件做出一個Stacked Model
  
  #' 首先，我們把資料整理好。
  #' 由於剛剛的預測結果都是categorical data，所以
  #' 我們使用sparse matrix 做運算的話，效率會比較高：
  merge_factor <- function(x1, x2) {
    stopifnot(levels(x1) == levels(x2))
    retval <- c(as.integer(x1), as.integer(x2))
    retval <- factor(retval, seq_along(levels(x1)))
    levels(retval) <- levels(x1)
    retval
  }
  
  library(Matrix)
  #' 我們的training data是:
  #'   - training dataset => tuning dataset 的預測結果
  #'   - tuning dataset => training dataset 的預測結果
  #'   - 真正的答案
  m.ass.train <- sparse.model.matrix(lettr ~ ., data.frame(
    lettr = y.ass <- merge_factor(LetterRecognition.train$lettr, LetterRecognition.tune$lettr),
    dt2 = merge_factor(v2.dt2, v1.dt2),
    bst2 = merge_factor(v2.bst2, v1.bst2),
    svm2 = merge_factor(v2.svm2, v1.svm2)
  ))
  #' 我們做預測的依據是：
  #'   - training dataset + tuning dataset => testing dataset 的預測結果
  m.ass.test <- sparse.model.matrix(~ ., data.frame(
    dt2 = p.dt2,
    bst2 = p.bst2,
    svm2 = p.svm2
  ))
  
  #' glmnet 是很有名的一個R 套件，也常用於各種競賽中。
  library(glmnet)
  
  #' 裡面有提供linear predictor based的multinomial model。
  #' 我們運用剛剛decision tree, GDBT和svm 的預測結果彙整成一個stacked model做預測
  #' 
  #' ps. 這裡，我們可以使用一個cross validation based 的方式
  #'     來挑選適當的regularization term，所以就省略了上述做parameter tuning的部份
  g.ass <- cv.glmnet(m.ass.train, y.ass, family = "multinomial")
  
  #' 運用stacked model產生預測結果
  p.ass <- predict(g.ass, m.ass.test, s = "lambda.min")
  p.ass <- apply(p.ass, 1, which.max)
  p.ass <- factor(p.ass, 1:26)
  levels(p.ass) <- levels(LetterRecognition$lettr)
  #' 評估預測結果
  confusionMatrix(p.ass, answer)
  #' 結果應該要比前面三個模型都還要好！

}
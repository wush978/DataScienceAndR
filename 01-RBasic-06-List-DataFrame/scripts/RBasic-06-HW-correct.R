#' 這裡我們使用CO2這個資料集請同學做練習
data(CO2)

#' 請問CO2 有多少列？
answer1 <- nrow(CO2)

#' 請問CO2 有多少行(column)？
answer2 <- ncol(CO2)

#' 請問CO2 的各行的名稱為何？
answer3 <- colnames(CO2)

#' 請問uptake這欄的平均值為多少？
answer4 <- mean(CO2$uptake)

#' CO2 共有很多很多列（answer3）
#' 請從CO2 中挑出一些列，滿足以下的條件：
#' 這些列的uptake直，超過全部CO2的uptake值
#' （`mean(CO2$uptake)`）
#' 
#'   你可以先取出uptake的向量、接著拿該向量和平均值做比較、把結果的logical vector丟到`[]`的第一個參數
answer5 <- CO2[CO2$uptake > answer4,]

#' 請問Type有多少種類別？
answer6 <- length(levels(CO2$Type))

#' 請問當Type的類別為Quebec時，uptake的平均值為多少？
answer7 <- mean(CO2[CO2$Type == "Quebec","uptake"])

#' 請問當Type的類別為Mississippi時，uptake的平均值為多少？
answer8 <- mean(CO2[CO2$Type == "Mississippi","uptake"])

#' 我們可以利用`model.matrix`來建立一個矩陣。舉例來說：
#' `model.matrix(~ Type + Treatment + conc, CO2)`可以
#' 建立一個基於Type、Treatment和conc的矩陣。

X <- model.matrix(~ Type + Treatment + conc, CO2)

#' 請取出uptake的值放入y 之中
y <- CO2$uptake

#' 請利用<https://en.wikipedia.org/wiki/Ordinary_least_squares#Estimation>的公式，利用迴歸的演算法，
#' 找出beta.hat讓 X %*% beta.hat 很靠近 y
#' ps. class(beta.hat) 應該為matrix
#'     dim(beta.hat) 應該為 c(4, 1)
#'     rownames(beta.hat) 應該為 c("(Intercept)","TypeMississippi","Treatmentchilled","conc")
beta.hat <- solve(t(X) %*% X, t(X) %*% y)

#' 請計算X %*% beta.hat 和 y 的correlation（提示：用函數`cor`）
answer11 <- cor(X %*% beta.hat, y)

#' answer11 的平方，就是迴歸分析時常提到的：R-squared。
#' 很多分析師會用這個數據來判斷這個模型好不好。
#' 在R 裡面，跑迴歸分析，可以簡單用`lm`這個函數：
g <- lm(uptake ~ Type + Treatment + conc, CO2)

#' g 這個物件就會包含我們剛剛算過得答案
#' g$coef就會是beta.hat
#' g$fitted.value就會是X %*% beta.hat
#' summary(g)則會顯示各個參數的t 檢定，以及整個模型的R-squared
g.s <- summary(g)
#' mode(g.s)顯示它是一個list。
#' 請找出一個名字，answer12，讓g[[answer12]]就是R-squared
#' 你可以參考help(summary.lm)裡面的說明。
answer12 <- "r.squared"


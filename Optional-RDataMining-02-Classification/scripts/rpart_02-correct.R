# R 中的型態很重要。類別的數據，調整成factor之後做運算會方便很多
y <- factor(stagec$pgstat)

# n 是各種類別出現的次數
n <- table(y)

# 預設的prior 是各種類別出現的比率
prior <- n / length(y)

#'@title 這是Vignette中的P 函數的實作
#'
#'@param x factor vector.
#'@return numeric value. 資料點屬於x 的機率
P <- function(x) {
  x.tb <- table(x)
  sum(pi * (x.tb / n))
}

#'@title 這是information index的計算
#'
#'@param p numeric value. 是某個類別的機率
#'@return numeric value. 該類別的information index
information <- function(p) {
  if (p == 0) 0 else - p * log(p)
}

#'@title 這是使用information index做切割準則時，I 函數的實作
#'@param x factor vector.
#'@return numeric value. x 的impurity
I <- function(x) {
  x.tb <- table(x)
  # 各種類別的機率
  category.prob <- x.tb / length(x)
  #' R 也是一種函數式語言，而sapply等函數能夠很方便的取代for 迴圈
  #' 這個寫法等價於：
  #' for(p in category.prob) gini(p)
  #' 但是自動把輸出結果排列成一個向量
  category.information <- sapply(category.prob, information) 
  sum(category.information)
}

PI <- function(x) P(x) * I(x)

#'@title 給定一個切點之後，計算impurity降低的幅度
impurity_variation_after_cut <- function(cut) {
  origin.impurity <- I(y) * P(y)
  # split 會依照第二個參數的值，將第一個參數分成若干個向量。
  # split 的結果是一個list，而且每一個list element對應到第二個參數的一種類別
  group <- split(y, stagec$age < cut)
  # group 是一個長度為二的list
  # 第一個element是所有stage$age < cut為FALSE 的病患對應的pgstat
  # 第二個element是所有stage$age < cut為TRUE 的病患對應的pgstat

  # 對各種切割後的node計算PI後加總
  splitted.impurity <- sum(sapply(group, PI))
  origin.impurity - splitted.impurity
}

# 列舉所有可能的切點
eval.x <- seq(min(stagec$age) - 0.5, max(stagec$age) + 0.5, by = 1)

# 算出每個切點，對應的impurity 的改善量
index <- sapply(eval.x, impurity_variation_after_cut)

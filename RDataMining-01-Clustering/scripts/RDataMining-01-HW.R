#' 請同學先安裝 mlbench 這個套件後進行這份作業
library(mlbench)

set.seed(1)
shapes <- mlbench.shapes(500)
table(shapes$classes)
d.shapes <- dist(shapes$x)

#' 請使用hclust 的預設參數，建立一個Hierarchical Clustering的結果
#' 再從上述結果產生一個有4群的cluster結果
cl1 <- {
  NULL #' 請在這邊輸入你的程式碼
}

#' 結果應該是一個integer vector
stopifnot(class(cl1)[1] == "integer")

#' 請使用kmeans 和以下的centers參數得到cluster結果
#' centers = shapes$x[c(1,126,251, 376),]

cl2 <- {
  NULL #' 請在這邊輸入你的程式碼
}

#' 結果應該是一個integer vector
stopifnot(class(cl2)[1] == "integer")

#' 請使用dbscan和參數eps = 0.5來建立cluster結果
cl3 <- {
  NULL #' 請在這邊輸入你的程式碼
}

#' 結果應該是一個integer vector
stopifnot(class(cl3)[1] == "integer")

#' 請同學先安裝 mlbench 這個套件後進行這份作業
check_then_install <- function(pkg_name, pkg_version) {
  if (!require(pkg_name, character.only = TRUE)) utils::install.packages(pkg_name, repos = "http://cran.r-project.org") else {
    if (packageVersion(pkg_name) < package_version(pkg_version)) utils::install.packages(pkg_name, repos = "http://cran.r-project.org")
  }
}
check_then_install("mlbench", "2.1.1")
library(mlbench)

set.seed(1)
shapes <- mlbench.shapes(500)
table(shapes$classes)
d.shapes <- dist(shapes$x)

#' 請使用hclust 的預設參數，建立一個Hierarchical Clustering的結果
#' 再從上述結果產生一個有4群的Cluster結果
cl1 <- {
  NULL #' 請在這邊輸入你的程式碼
}

cl1 <- {
  tmp <- hclust(d.shapes)
  cutree(tmp, 4)
}

#' 結果應該是一個integer vector
stopifnot(class(cl1)[1] == "integer")

#' 請使用k.means 和以下參數得到第二個cluster的結果
#' centers = shapes$x[c(1,126,251, 376),]

cl2 <- {
  NULL #' 請在這邊輸入你的程式碼
}

cl2 <- {
  kmeans(shapes$x, centers = shapes$x[c(1,126,251, 376),])$cluster
}

#' 結果應該是一個integer vector
stopifnot(class(cl2)[1] == "integer")

cl3 <- {
  NULL #' 請在這邊輸入你的程式碼
}

cl3 <- {
  as.integer(dbscan(d.shapes, eps = 0.5, method = "dist")$cluster)
}

#' 結果應該是一個integer vector
stopifnot(class(cl3)[1] == "integer")

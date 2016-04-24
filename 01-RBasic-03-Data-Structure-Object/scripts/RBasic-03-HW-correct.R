#' 以下內容改自prcomp 的範例程式碼
#' 
#' PCA(Principle Components Analysis) 是一個資料分析時常用的技術，
#' 它的原理會在後面的課程講解。
#' 在R 中，我們可以利用prcomp這個指令對USArrests這筆資料進行PCA 的分析，
#' R 會吐回一個計算後的物件給我們。
pca <- prcomp(USArrests, scale = TRUE)

#' 請同學找出pca的「型態」。你的答案只可能是：「"character"」、「"numeric"」或「"list"」
answer1 <- mode(pca)

#' 請同學將pca的長度寫入變數answer2
answer2 <- length(pca)

#' 請同學將pca的名字寫入變數answer3
answer3 <- names(pca)

#' pca 的元素中，有一個是各個principal components的standard deviations。
#' 請同學參考help(prcomp)的說明的Value章節
#' 將各個principal components的standard deviations
#' 寫入變數answer4
answer4 <- pca$sdev

#' pca 的元素中，有一個是PCA的中心(center)。請同學參考help(prcomp)的說明，
#' 將該元素寫入變數answer5
answer5 <- pca$center

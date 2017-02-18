#' 以下內容改自prcomp 的範例程式碼
#' 
#' PCA(Principle Components Analysis) 是一個資料分析時常用的技術，會在後面的課程中，會進一步的講解它的原理。
#' 在R 中，可以利用prcomp這個指令對USArrests這筆資料進行PCA 的分析，R 則會輸出一個計算後的物件。
pca <- prcomp(USArrests, scale = TRUE)

#' 請同學找出PCA的「型態」。你的答案只可能是：「"character"」、「"numeric"」或「"list"」
answer1 <- NULL #請將NULL替換成你的程式碼

#' 請同學將PCA的長度寫入變數answer2。
answer2 <- NULL #請將NULL替換成你的程式碼

#' 請同學將PCA的名字寫入變數answer3。
answer3 <- NULL #請將NULL替換成你的程式碼

#' PCA的元素中，有一個是各個principal components的standard deviations。
#' 請同學參考help(prcomp)說明中的Value章節。
#' 將各個principal components的standard deviation寫入變數answer4。
answer4 <- NULL #請將NULL替換成你的程式碼

#' PCA 元素中，有一個是PCA的中心(center)。請同學參考help(prcomp)的說明，將該元素寫入變數answer5。
answer5 <- NULL #請將NULL替換成你的程式碼

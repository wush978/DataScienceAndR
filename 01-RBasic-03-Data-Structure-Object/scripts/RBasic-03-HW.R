#' 以下內容改自prcomp 的範例程式碼
#' 
#' PCA(Principle Components Analysis) 是一個資料分析時常用的技術，
#' 它的原理會在後面的課程講解。
#' 在R 中，我們可以利用prcomp這個指令對USArrests這筆資料進行PCA 的分析，
#' R 會吐回一個計算後的物件給我們。
pca <- prcomp(USArrests, scale = TRUE)

#' 請同學找出這個物件的名稱。你的答案只可能是：「character」、「numeric」或「list」
answer1 <- NULL #請將NULL替換成你的程式碼

#' 請同學撰寫找出pca這個向量的長度的「指令」
answer2 <- NULL #請將NULL替換成你的程式碼

#' 請同學撰寫找出pca的名字的「指令」
answer3 <- NULL #請將NULL替換成你的程式碼

#' pca 的元素中，有一個是各個principal components的standard deviations。
#' 請同學參考help(prcomp)的說明，撰寫將各個principal components的standard deviations
#' 的值取出的「指令」。
answer4 <- NULL #請將NULL替換成你的程式碼

#' pca 的元素中，有一個是做PCA的中心(center)。請同學參考help(prcomp)的說明，
#' 撰寫把該元素取出的「指令」。
answer5 <- NULL #請將NULL替換成你的程式碼

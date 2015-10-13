#' 以下內容改自prcomp 的範例程式碼
#' 
#' PCA(Principle Components Analysis) 是一個資料分析時常用的技術，
#' 它的原理會在後面的課程講解。
#' 在R 中，我們可以利用prcomp這個指令對USArrests這筆資料進行PCA 的分析，
#' R 會吐回一個計算後的物件給我們。
pca <- prcomp(USArrests, scale = TRUE)

#' 請同學找出這個物件的名稱。你的答案只可能是：「character」、「numeric」或「list」
answer1 <- <填寫你的程式碼>

#' 請同學找出`pca`這個向量的長度
answer2 <- <填寫你的程式碼>

#' 請同學找出`pca`中值的名字
answer3 <- <填寫你的程式碼>

#' `pca` 的元素中，有一個是各個principal components的standard deviations。
#' 請同學參考`help(prcomp)`的說明，將各個principal components的standard deviations
#' 的值取出，存到答案中。
answer4 <- <填寫你的程式碼>

#' `pca` 的元素中，有一個是做PCA的中心(center)。請同學參考`help(prcomp)`的說明，
#' 把該元素取出，存到答案中。
answer5 <- <填寫你的程式碼>
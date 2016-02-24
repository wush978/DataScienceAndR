# Put custom tests in this file.

# Uncommenting the following line of code will disable
# auto-detection of new variables and thus prevent swirl from
# executing every command twice, which can slow things down.

# AUTO_DETECT_NEWVAR <- FALSE

# However, this means that you should detect user-created
# variables when appropriate. The answer test, creates_new_var()
# can be used for for the purpose, but it also re-evaluates the
# expression which the user entered, so care must be taken.

source_by_l10n_info <- function(path) {
  info <- l10n_info()
  if (info$MBCS & !info$`UTF-8`) {
    try(source(path, local = new.env()), silent = TRUE)
  } else {
    try(source(path, local = new.env(), encoding = "UTF-8"), silent = TRUE)
  }
}

rpart_01_test <- function() {
  e <- get("e", parent.frame())
  source_result <- source_by_l10n_info(e$script_temp_path)
  if (class(source_result)[1] == "try-error") return(FALSE)
  eval.x.ref <- seq(min(stagec$age) - 0.5, max(stagec$age) + 0.5, by = 1)
  index.ref <- local({
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
    
    #'@title 這是gini index的計算
    #'
    #'@param p numeric value. 是某個類別的機率
    #'@return numeric value. 該類別的gini index
    gini <- function(p) p * (1 - p)
    
    #'@title 這是使用gini index做切割準則時，I 函數的實作
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
      category.gini <- sapply(category.prob, gini) 
      sum(category.gini)
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
    sapply(eval.x, impurity_variation_after_cut)
  })
  name.list <- c("eval.x", "index")
  tryCatch({
    for(name in name.list) {
      if (!isTRUE(all.equal(
        get(name, envir = globalenv()),
        get(sprintf("%s.ref", name))
      ))) stop(sprintf("%s is wrong! Try again.\n", name))
    }
    TRUE
  }, error = function(e) {
    cat(conditionMessage(e))
    FALSE
  })
}

rpart_02_test <- function() {
  e <- get("e", parent.frame())
  source_result <- source_by_l10n_info(e$script_temp_path)
  if (class(source_result)[1] == "try-error") return(FALSE)
  eval.x.ref <- seq(min(stagec$age) - 0.5, max(stagec$age) + 0.5, by = 1)
  index.ref <- local({
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
    
    #'@title 這是gini index的計算
    #'
    #'@param p numeric value. 是某個類別的機率
    #'@return numeric value. 該類別的gini index
    information <- function(p) {
      if (p == 0) 0 else - p * log(p)
    }
    
    
    #'@title 這是使用gini index做切割準則時，I 函數的實作
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
      category.gini <- sapply(category.prob, information) 
      sum(category.gini)
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
    sapply(eval.x, impurity_variation_after_cut)
  })
  name.list <- c("eval.x", "index")
  tryCatch({
    for(name in name.list) {
      if (!isTRUE(all.equal(
        get(name, envir = globalenv()),
        get(sprintf("%s.ref", name))
      ))) stop(sprintf("%s is wrong! Try again.\n", name))
    }
    TRUE
  }, error = function(e) {
    cat(conditionMessage(e))
    FALSE
  })
}

script_test_prefix <- function(n = 2) {
  e <- get("e", parent.frame(n = n))
  source_result <- try(source(e$script_temp_path, local = new.env(), encoding = "UTF-8"), silent = TRUE)
  if (class(source_result)[1] == "try-error") stop(sprintf("Syntax error: %s", conditionMessage(attr(source_result, "condition"))))
  e
}

ml_05 <- function() {
  tryCatch({
    e <- script_test_prefix()
    answer_05 <- get("answer_05", envir = globalenv())
    logloss <- function(y, p, tol = 1e-4) {
      # tol 的用途是避免對0取log所導致的數值問題
      p[p < tol] <- tol
      p[p > 1 - tol] <- 1 - tol
      -sum(y * log(p) + (1 - y) * log(1-p))
    }
    stopifnot(class(answer_05) == c("rpart"))
    stopifnot(local({
      p <- predict(answer_05, df.test)[,"good"]
      logloss(df.test$Class == "good", p) < 12
    }))
    TRUE
  }, error = function(e) {
    message(conditionMessage(e))
    FALSE
  })
}
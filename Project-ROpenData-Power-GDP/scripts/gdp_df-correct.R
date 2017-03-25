# 開始的index
year.index.start <- year.index
# 結束的index
## 每一個開始的index接續到下一個開始的index
## 也就是結尾的index就是下一個開始的index
year.index.end <- c(tail(year.index, -1), length(gdp.split))
# 開始撰寫for迴圈
## 我們先建立每一年份整理出來的gdp 資料
## 這些資料會被放到gdp.df.components之中
gdp.df.components <- list()
# 請填寫正確的for 迴圈的範圍
for(i in 1:7) {
  # 針對特定年份做處理的程式碼
  ## 開始的index
  start <- year.index.start[i]
  ## 結束的index
  end <- year.index.end[i]
  ## 年份的資料在第一筆
  year <- gdp.split[[start]] %>%
    ## 將 "2007" ==> 2007，將"用空白替換掉
    gsub(pattern = '"', replacement = '')
  ## 只抽出這次要處理的資料
  target <- gdp.split[start:end]
  ## 挑出長度是3 的，做rbind
  target.mat <- do.call(rbind, 
                        target[sapply(target, length) == 3])
  ## 原本的第一行是空白，我們改成放年份
  target.mat[,1] <- year
  ## 處理第二行中的"
  target.mat[,2] <- gsub('"', '', target.mat[,2])
  ## 將這輪處理的資料，放到gdp.df.components
  gdp.df.components[[i]] <- target.mat
}
gdp.df <- do.call(rbind, gdp.df.components) %>% 
  ## 我們先不把資料轉成factor
  data.frame(stringsAsFactors = FALSE)
colnames(gdp.df) <- c("year", "name", "gdp")
## 把year 轉成integer
gdp.df$year <- as.integer(gdp.df$year)
## 把name 轉成character
gdp.df$name <- as.character(gdp.df$name)
## 把gdp 轉成numeric
gdp.df$gdp <- as.numeric(gdp.df$gdp)
gdp.df <- filter(gdp.df, !is.na(gdp))

# 先建立sex物件
sex <- table(hsb$sex)

# 預設圖
pie(sex)

# 加上標題
pie(sex, main = "Sex")

# 改顏色
col <- rainbow(length(sex)) # 利用rainbow函數產生若干種不同的色系
col # 這是RGB的值
pie(sex, main = "Sex", col = col)

# 加上比率
pct <- sex / sum(sex) * 100 # 計算百分比
label <- paste0(names(sex), " ", pct, "%") # 產生說明文字
label # 同學可以比較label, names(sex), pct 和 "%" 的結果
pie(sex, labels = label)

if (FALSE) {
  # 3D pie chart
  library(plotrix) # 同學請自行安裝這個套件
  pie3D(sex, labels = label)
}

# 請回到console輸入`submit()`


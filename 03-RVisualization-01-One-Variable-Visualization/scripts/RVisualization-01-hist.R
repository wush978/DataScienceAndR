# 先建立math物件
math <- hsb$math
hist(math)

# 改變title
hist(math, main = "Histogram of math!")

# 改變x軸說明
hist(math, xlab = "Value of math")

# 改變y軸說明
hist(math, ylab = "frequency")

# 改變顏色
hist(math, col = "blue")

# 圖標
legend("topright", "test")

# 改變切割點
hist(math, breaks = 2)
hist(math, breaks = 10)
hist(math, breaks = 20)
# 請回到console輸入`submit()`

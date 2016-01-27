x <- tail(sunspot.year, 50) # 只選出最後50筆資料做圖

# 畫出散布圖
plot(x) 
# 將點連接起來
lines(x) # 低階繪圖函數
# 調色
lines(x, col = "red")
# 加粗
lines(x, lwd = 2)
# 改變線的型態
plot(x) # 重新畫圖
lines(x, lty = 3)
# 標題
plot(x, main = "sunspot")
# 刪除x 軸座標
plot(x, xaxt = "n")
# y 軸座標更改
plot(x, yaxt = "n") # 先刪除y軸座標
axis(2, at = seq(10, 200, 10), labels = seq(10, 200, 10))
# 請回到console輸入`submit()`


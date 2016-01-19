# 首先，我們重新連線到令一個資料庫
db <- dbConnect(drv, db_path2)

# 請列出現在的資料庫中的表格清單
tb_list <- {
  # 請填寫你的程式碼
  dbListTables(db)
}

# 資料庫中的TWII是台灣加權指數，是透過quantmod套件從yahoo下載的數據
# 請問同學，這段數據的日期範圍，是幾號到幾號呢？
# 你的答案應該是一個字串
twii_head <- {
  # 請填寫你的程式碼
  dbReadTable(db, "TWII")$date[1]
}
twii_tail <- {
  # 請填寫你的程式碼
  tail(dbReadTable(db, "TWII")$date, 1)
}
stopifnot(class(twii_head) == "character")
stopifnot(length(twii_head) == 1)
stopifnot(class(twii_tail) == "character")
stopifnot(length(twii_tail) == 1)

# 接著我們開啟一個Transaction
dbBegin(db)

# R 內建的iris資料共有三種類別，一共150筆花的量測資料
# 請同學將屬於setosa種類（Species的值為"setosa"）的資料，
# 寫入到database，並且取名為"setosa"
{
  # 請填寫你的程式碼
  dbWriteTable(db, "setosa", iris[iris$Species == "setosa",], overwrite = TRUE)
}

# 請確實將資料寫入！
{
  # 請填寫你的程式碼
  dbCommit(db)
}

# 最後，我們中斷連線
dbDisconnect(db)

# 測試程式將會檢查這個資料庫內的資料

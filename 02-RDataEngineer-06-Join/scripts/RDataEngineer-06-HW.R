#' 請用學到的方法讀取`gdp_path`的資料、整理資料，並把最後的結果存到變數`gdp`。
#' 提示：`gdp_path`中的第一欄數據是年/季、第二欄數據是該季的GDP(百萬)。
#' 結果應該要有兩欄的數據，第一欄是年份，第二欄是我國每年的GDP，
#' 具體細節請參考最後的`stopifnot`的檢查事項。
#' 提示：拿掉數據中間的逗號，請用：`gsub(pattern = ",", replacement = "", x = <你的字串向量>)`
gdp <- local({
  # 請填寫你的程式碼。
})
stopifnot(is.data.frame(gdp))
stopifnot(colnames(gdp) == c("year", "gdp"))
stopifnot(class(gdp$year) == "character")
stopifnot(class(gdp$gdp) == "numeric")
stopifnot(nrow(gdp) == 33)
stopifnot(range(gdp$year) == c("1981", "2013"))
stopifnot(range(gdp$gdp) == c(1810829,14564242) * 1000000)

#' cl_info的資料包含各家銀行的房貸餘額（mortgage_bal）資訊與資料建立的時間（data_dt）。
#' 請用學到的方法整理cl_info的資料，並把最後的結果整理至`cl_info_year`。
#' 結果應該要有兩欄的數據，第一欄是年份，第二欄是每年房貸餘額的值(請以每年的一月份資料為準)。
#' 具體細節請參考最後的`stopifnot`檢查事項。
cl_info_year <- local({
  # 請填寫你的程式碼。
})

stopifnot(is.data.frame(cl_info_year))
stopifnot(colnames(cl_info_year) == c("year", "mortgage_total_bal"))
stopifnot(class(cl_info_year$year) == "character")
stopifnot(class(cl_info_year$mortgage_total_bal) == "numeric")
stopifnot(nrow(cl_info_year) == 9)
stopifnot(range(cl_info_year$year) == c("2006", "2014"))
stopifnot(range(cl_info_year$mortgage_total_bal) == c(3.79632e+12, 5.726784e+12))

#' 最後，請同學用這門課程所學的技術整合`gdp`與`cl_info`的資料，
#' 並計算出房貸餘額與gdp的比率（mortgage_total_bal / gdp）。
#' 請將結果輸出到一個data.frame，第一欄是年份，第二欄則是房貸餘額的GDP佔有比率。
#' 細節請參考`stopifnot`的檢查。
answerHW <- local({
  # 請在這邊填寫你的程式碼。
})

stopifnot(is.data.frame(answerHW))
stopifnot(nrow(answerHW) == 8)
stopifnot(colnames(answerHW) == c("year", "index"))
stopifnot(class(answerHW$year) == "character")
stopifnot(class(answerHW$index) == "numeric")
stopifnot(min(answerHW$index) > 0.3)
stopifnot(max(answerHW$index) < 0.4)
#' 完成後請存檔，並回到console執行`submit()`

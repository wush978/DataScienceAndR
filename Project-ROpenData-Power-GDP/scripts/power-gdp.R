
#' 請依據`power.df2`建立一個data.frame
#' 包含: year, id2, power, name 等四個欄位
#' year: 原本`power.df2`的year
#' id2: 將`power.df2`的id經過`translation.power`轉換
#' power: 同年度同id2的用電量總和
#' name: 同年度同id2的欄位名稱的串接，分隔符號為","
#'   hint: 在`summarise`中使用`paste(name, collapse = ",")`
power.df3 <- local({
  NULL
})

#' 請依據`gdp.df2`建立一個data.frame
#' 包含: year, id2, gdp, name 等四個欄位
#' year: 原本`gdp.df2`的year
#' id2: 將`gdp.df2`的id經過`translation.gdp`轉換
#' gdp: 同年度同id2的gdp總和
gdp.df3 <- local({
  NULL
})

#' 請將power.df3與gdp.df3整合成一個單一的data.frame
#' 欄位包含: year, id2, power, name, gdp, eff
#' year: 年度
#' id2: 產業代號
#' power: 用電量
#' name: 產業名稱
#' gdp: gdp
#' eff: 每單位用電量所產生的gdp
#' 資料中請避免有NA
power.gdp <- local({
  NULL
  # 請在此填寫你的程式碼
})

stopifnot(isTRUE(all.equal(class(power.gdp), "data.frame")))
stopifnot(isTRUE(all.equal(nrow(power.gdp), 70)))
stopifnot(isTRUE(all.equal(ncol(power.gdp), 6)))
stopifnot(isTRUE(all.equal(colnames(power.gdp), c("year", "id2", "power", "name", "gdp", "eff"))))
stopifnot(isTRUE(all.equal(rownames(power.gdp), paste(1:70))))
stopifnot(isTRUE(all.equal(sum(power.gdp$year), 140700)))
stopifnot(isTRUE(all.equal(sum(power.gdp$id2), 385)))
stopifnot(!is.unsorted(power.gdp$year * 10 + power.gdp$id2))
stopifnot(isTRUE(all.equal(sum(power.gdp$gdp), 94279743)))
stopifnot(power.gdp$eff == power.gdp$gdp / power.gdp$power)

#' 完成後請存檔並回到console輸入：`submit()`

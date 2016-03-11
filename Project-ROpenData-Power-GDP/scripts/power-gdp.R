#' 請同學自由發揮
#' 我們只將結果的條件已`stopifnot`的方式寫在最下方給同學參考
power.gdp <- local({
  NULL
  # 請在此填寫你的程式碼
})

stopifnot(isTRUE(all.equal(class(power.gdp), "data.frame")))
stopifnot(isTRUE(all.equal(nrow(power.gdp), 56)))
stopifnot(isTRUE(all.equal(ncol(power.gdp), 6)))
stopifnot(isTRUE(all.equal(colnames(power.gdp), c("year", "id2", "power", "name", "gdp", "eff"))))
stopifnot(isTRUE(all.equal(rownames(power.gdp), paste(1:56))))
stopifnot(isTRUE(all.equal(sum(power.gdp$year), 112560)))
stopifnot(isTRUE(all.equal(sum(power.gdp$id2), 252)))
stopifnot(!is.unsorted(power.gdp$year * 8 + power.gdp$id2))
stopifnot(isTRUE(all.equal(sum(power.gdp$gdp), 72840324)))
stopifnot(power.gdp$eff == power.gdp$gdp / power.gdp$power)

#' 完成後請存檔並回到console輸入：`submit()`

#' 請同學利用之前所學，從cl_info的欄位data_dt的資料中萃取出資料的「年和月」，並存到欄位 year_month 中。
#' 並且最後只留下 year_month 與 mortgage_bal兩個欄位。
#' 這裡的data_dt 是收集資料的時間點，
#' mortgage_bal 則是房貸餘額。
cl_info2 <- local({
  # 請填寫你的程式碼。
})

stopifnot(class(cl_info2$year_month)[1] == "character")
stopifnot(ncol(cl_info2) == 2)
stopifnot(!is.null(cl_info2$mortgage_bal))

#' 請算出每個月份的 mortgage_bal 總和，
#' 並且把結果放在 mortgage_total_bal 欄位中。
#' 結果請依照月份由小到大做排序。
cl_info3 <- local({
  # 請填寫你的程式碼。
})

stopifnot(nrow(cl_info3) == 98)
stopifnot(ncol(cl_info3) == 2)
stopifnot(!is.unsorted(cl_info3$year_month))
#' 這個資料集只要能和GDP進行比較，就是一個我國房地產泡沫化的指標。

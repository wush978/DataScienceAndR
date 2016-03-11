cl_info2 <- local({
  # 請填寫你的程式碼
  mutate(cl_info, year_month = substring(data_dt, 1, 7)) %>%
    select(year_month, mortgage_bal)
})

stopifnot(class(cl_info2$year_month)[1] == "character")
stopifnot(ncol(cl_info2) == 2)
stopifnot(!is.null(cl_info2$mortgage_bal))

cl_info3 <- local({
  # 請填寫你的程式碼
  group_by(cl_info2, year_month) %>%
    summarise(mortgage_total_bal = sum(mortgage_bal)) %>%
    arrange(year_month)
})

stopifnot(nrow(cl_info3) == 98)
stopifnot(ncol(cl_info3) == 2)
stopifnot(!is.unsorted(cl_info3$year_month))
#' 這個資料集只要能和GDP做比較，就是一個我國房地產泡沫化的指標

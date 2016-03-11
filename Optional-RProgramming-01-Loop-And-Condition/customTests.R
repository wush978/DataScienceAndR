# Put custom tests in this file.

# Uncommenting the following line of code will disable
# auto-detection of new variables and thus prevent swirl from
# executing every command twice, which can slow things down.

# AUTO_DETECT_NEWVAR <- FALSE

# However, this means that you should detect user-created
# variables when appropriate. The answer test, creates_new_var()
# can be used for for the purpose, but it also re-evaluates the
# expression which the user entered, so care must be taken.

test_x <- function(x) {
  (length(x) == 100) & is.numeric(x)
}

for_example1 <- function() {
  e <- get("e", parent.frame())
  source_result <- source_by_l10n_info(e$script_temp_path)
  if (class(source_result)[1] == "try-error") return(FALSE)
  x <- get("x", globalenv())
  # 重新初始化x 的內容
  x.ref <- numeric(100)
  x.ref[1] <- 3
  # 尋找x^2的最小值
  for(i in 1:99) {
    x.ref[i + 1] <- x.ref[i] - 0.2 * x.ref[i]
    if (abs(x.ref[i + 1] - x.ref[i]) < 0.01) break
  }
  isTRUE(all.equal(x, x.ref))
}

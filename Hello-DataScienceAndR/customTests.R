# Put custom tests in this file.

# Uncommenting the following line of code will disable
# auto-detection of new variables and thus prevent swirl from
# executing every command twice, which can slow things down.

# AUTO_DETECT_NEWVAR <- FALSE

# However, this means that you should detect user-created
# variables when appropriate. The answer test, creates_new_var()
# can be used for for the purpose, but it also re-evaluates the
# expression which the user entered, so care must be taken.

check_version <- function() {
  rv <- package_version(paste(R.Version()$major, R.Version()$minor, sep = "."))
  if (rv < package_version("3.2.3")) {
    message(sprintf("你的R 版本過舊(%s)，請考慮更新R至版本：%s或以上", rv, "3.2.3"))
  }
  if (packageVersion("swirl") != package_version("2.3.1.2")) {
    message('你的swirl版本過舊，請重開R 後執行： install.packages("swirl", repos = "http://wush978.github.io/R", type = "source") ')
    FALSE
  } else TRUE
}

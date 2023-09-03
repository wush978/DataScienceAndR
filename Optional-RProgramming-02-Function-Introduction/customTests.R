# Put custom tests in this file.

# Uncommenting the following line of code will disable
# auto-detection of new variables and thus prevent swirl from
# executing every command twice, which can slow things down.

# AUTO_DETECT_NEWVAR <- FALSE

# However, this means that you should detect user-created
# variables when appropriate. The answer test, creates_new_var()
# can be used for for the purpose, but it also re-evaluates the
# expression which the user entered, so care must be taken.

test_x <- function() {
  e <- get("e", parent.frame())
  x <- get("x", globalenv())
  (length(x) == 100) & is.numeric(x)
}

test_f <- function() {
  f <- get("f", globalenv())
  isTRUE(all.equal(deparse(f), deparse(function(x) sum((x - y)^2))))
}

test_f1 <- function() {
  f1 <- get("f1", globalenv())
  isTRUE(all.equal(deparse(f1), deparse(function(x) f(m %*% x))))
}

# Code placed in this file fill be executed every time the
# lesson is started. Any variables created here will show up in
# the user's working directory and thus be accessible to them
# throughout the lesson.

.set_init_value <- function(name, value) {
  if (exists(name, envir = globalenv())) {
    if (bindingIsLocked(name, globalenv())) {
      unlockBinding(name, globalenv())
    }
  }
  assign(name, value, envir = globalenv())
  # lockBinding(name, globalenv())
  invisible(NULL)
}

.set_init_value("x1", c(1, 10, 2, 3, 7, 1, 7, 8, 1))
.set_init_value("x2", c(1, 100, 2, 3, 7, 1, 7, 8, 1))
.set_init_value("x3", c(1, 10, 2, 3, 7, 1, 7, 8, 1) * 100)
.set_init_value("x4", c(1, 10, 2, 3, 7, 1, 7, 8, 1) + 1)
.set_init_value("answer", structure(list(robustness = c(FALSE, FALSE, TRUE, TRUE, FALSE, 
FALSE, FALSE, TRUE), ratio.invariant = c(FALSE, FALSE, FALSE, 
FALSE, FALSE, FALSE, TRUE, TRUE), ratio = c(TRUE, TRUE, TRUE, 
TRUE, FALSE, TRUE, FALSE, FALSE), shift.invariant = c(TRUE, TRUE, 
TRUE, TRUE, TRUE, TRUE, FALSE, FALSE)), .Names = c("robustness", 
"ratio.invariant", "ratio", "shift.invariant"), row.names = c("range", 
"MD", "MAD", "IQR", "var", "sd", "CV", "QCD"), class = "data.frame")
)

for(name in c("answer_02", sprintf("answer_03_%02d", 1:7))) {
  if (exists(name, envir = globalenv())) {
    if (bindingIsLocked(name, globalenv())) {
      unlockBinding(name, globalenv())
    }
  }
}

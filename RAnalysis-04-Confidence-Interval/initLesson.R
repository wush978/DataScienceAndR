# Code placed in this file fill be executed every time the
# lesson is started. Any variables created here will show up in
# the user's working directory and thus be accessible to them
# throughout the lesson.

assign("confint.plot", function(df) {
  df$x <- sprintf("Exp%d", 1:nrow(df))
  ggplot(df, aes(x = x, y = mean)) +
    geom_point() +
    geom_errorbar(aes(ymin=lower, ymax=upper))
}, envir = globalenv())
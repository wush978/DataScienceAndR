# Code placed in this file fill be executed every time the
# lesson is started. Any variables created here will show up in
# the user's working directory and thus be accessible to them
# throughout the lesson.

assign("facebook_error",
       readLines(.get_path("facebook-error.json")),
       envir = globalenv())

assign("x1",
       '["Amsterdam", "Rotterdam", "Utrecht", "Den Haag"]',
       envir = globalenv())

assign("youbike_path",
       .get_path("youbike.json"),
       envir = globalenv())

# Code placed in this file fill be executed every time the
# lesson is started. Any variables created here will show up in
# the user's working directory and thus be accessible to them
# throughout the lesson.

.assign <- function(name, value) {
  assign(name, value, envir = globalenv())
}

.assign("test.i", c(4L, 6L, 9L, 13L, 14L, 22L, 31L, 33L, 50L, 52L, 61L, 63L, 68L, 
                   79L, 91L, 99L, 119L, 135L, 154L, 155L, 160L, 162L, 166L, 194L, 
                   200L, 219L, 233L, 236L, 237L, 242L, 244L, 248L, 250L, 257L, 261L, 
                   276L, 278L, 283L, 292L, 310L, 312L, 315L, 319L, 323L, 325L, 327L, 
                   335L, 337L, 338L, 344L))

.assign("train.i", local({
  setdiff(seq_len(351), get("test.i", envir = globalenv()))
}))

## From: http://stackoverflow.com/a/29691154/1182304
.assign("extract_rhs_symbols", function(x) {
  as.list(attr(delete.response(terms(x)), "variables"))[-1]
})
.assign("symbols_to_formula", function(x) {
  as.call(list(quote(`~`), x))    
})
.assign("sum_symbols", function(...) {
  Reduce(function(a,b) bquote(.(a)+.(b)), do.call(`c`, list(...), quote=T))
})
.assign("square_terms", function(x) {
  symbols_to_formula(sum_symbols(sapply(extract_rhs_symbols(x), function(x) bquote(I(.(x)^2)))))
})
.assign("interact_rhs", function(x) {
  x[[length(as.list(x))]] <- bquote((.(x[[length(as.list(x))]]))^2)
  x
})
.assign("add_rhs_dot", function(x) {
  x[[length(as.list(x))]] <- sum_symbols(quote(.), x[[length(as.list(x))]])    
  x
})
.assign("add_terms", function(f, x) {
  update(f, add_rhs_dot(x))
})

# Code placed in this file fill be executed every time the
# lesson is started. Any variables created here will show up in
# the user's working directory and thus be accessible to them
# throughout the lesson.

assign("score1", 
       local({
         set.seed(1)
          score <- lapply(1:10, function(i) {
            x <- integer(10)
            x[1] <- sample(1:100, 1)
            for(i in 2:10) {
              while(TRUE) {
                tmp <- sample((-10):10, 1)
                x[i] <- x[i-1] + tmp
                if (x[i] %in% 1:100) break
              }
            }
            x
          })
          score <- as.data.frame(do.call(rbind, score))
          rownames(score) <- sprintf("Student%02d", 1:10)
          colnames(score) <- sprintf("Test%02d", 1:10)
          score
       }), envir = globalenv())

assign("score2", 
       local({
         set.seed(1)
          score <- lapply(1:10, function(i) {
            x <- integer(10)
            x[1] <- sample(1:100, 1)
            if (x[1] < 6) {
              x[2:10] <- sample(seq(1, 11, by = 1), 9, TRUE)
            } else if (x[1] > 95) {
              x[2:10] <- sample(seq(90, 100, by = 1), 9, TRUE)
            } else {
              x[2:10] <- sample(seq(x[1] - 5, x[1] + 5, by = 1), 9, TRUE)
            }
            x
          })
          score <- as.data.frame(do.call(rbind, score))
          rownames(score) <- sprintf("Student%02d", 1:10)
          colnames(score) <- sprintf("Test%02d", 1:10)
          score
       }), envir = globalenv())

assign("prepare_data", function(score) {
  data.frame(
    before = as.vector(apply(score[,1:9], 1, function(x) {
      head(x, -1)
    })),
    after = as.vector(apply(score[,1:9], 1, function(x) {
      tail(x, -1)
    })))
}, envir = globalenv())

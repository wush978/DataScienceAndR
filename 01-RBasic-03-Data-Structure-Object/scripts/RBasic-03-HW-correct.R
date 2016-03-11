pca <- prcomp(USArrests, scale = TRUE)

answer1 <- mode(pca)

answer2 <- length(pca)

answer3 <- names(pca)

answer4 <- pca$sdev

answer5 <- pca$center

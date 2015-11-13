#' iris 是一個很有名的資料集。
#' R 在處理iris的Species欄位，也就是鳶尾花資料集時，預設是使用factor型態
species <- iris$Species

#' 請問species共有哪幾種類別？（答案應該是一個character vector）
answer1 <- levels(species)

#' 請問species的類別有無順序關係？
answer2 <- FALSE

#' CO2 是另一個範例數據。
plant <- CO2$Plant

#' 請問plant共有哪幾種類別？（答案應該是一個character vector）
answer3 <- levels(plant)

#' 請問plant的類別有無順序關係？
answer4 <- TRUE

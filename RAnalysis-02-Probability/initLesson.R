# Code placed in this file fill be executed every time the
# lesson is started. Any variables created here will show up in
# the user's working directory and thus be accessible to them
# throughout the lesson.

assign("population.Kinmen", 
       local({
         tb <- structure(c(1272L, 1390L, 1230L, 1300L, 960L, 802L, 748L, 708L, 
762L, 710L, 760L, 738L, 756L, 829L, 888L, 1124L, 1115L, 1055L, 
1950L, 2316L, 2437L, 2564L, 2307L, 2245L, 2090L, 2229L, 2017L, 
2229L, 1987L, 1953L, 2036L, 2191L, 2104L, 2146L, 2163L, 1936L, 
2093L, 2035L, 1923L, 2066L, 1834L, 1865L, 1896L, 1984L, 2068L, 
2101L, 2139L, 2185L, 2050L, 2502L, 2420L, 2547L, 2403L, 2438L, 
2196L, 2592L, 2377L, 2404L, 2492L, 2319L, 2004L, 2122L, 1614L, 
1683L, 1559L, 1118L, 1093L, 918L, 791L, 677L, 682L, 745L, 682L, 
675L, 620L, 624L, 577L, 609L, 619L, 501L, 484L, 473L, 423L, 392L, 
325L, 268L, 249L, 228L, 175L, 168L, 143L, 133L, 101L, 71L, 81L, 
49L, 29L, 29L, 25L, 18L, 46L), .Dim = 101L, .Dimnames = structure(list(
    population.Kinmen = c("0", "1", "2", "3", "4", "5", "6", 
    "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", 
    "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", 
    "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", 
    "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", 
    "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", 
    "57", "58", "59", "60", "61", "62", "63", "64", "65", "66", 
    "67", "68", "69", "70", "71", "72", "73", "74", "75", "76", 
    "77", "78", "79", "80", "81", "82", "83", "84", "85", "86", 
    "87", "88", "89", "90", "91", "92", "93", "94", "95", "96", 
    "97", "98", "99", "100")), .Names = "population.Kinmen"), class = "table")
      unlist(lapply(0:100, function(i) {
        rep(i, tb[paste(i)])
      }))
       }), envir = globalenv())

assign("mu", mean(get("population.Kinmen", envir = globalenv())), envir = globalenv())


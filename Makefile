all : index.html teacher.html
	$(MAKE) -C slide

index.md : index.Rmd
	Rscript -e "knitr::knit('$<', '$@')"

index.html : index.md
	node_modules/.bin/markdown2bootstrap -h  $<

teacher.html : teacher.md
	node_modules/.bin/markdown2bootstrap $<

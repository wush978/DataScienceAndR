all : GettingStarted.html

%.html : %.Rmd
	Rscript -e "slidify::slidify('$<')"
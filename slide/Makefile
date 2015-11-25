all : GettingStarted.html RDataMining.html

%.html : %.Rmd
	Rscript -e "slidify::slidify('$<')"

clean :
	-rm ./*.html ./*.md
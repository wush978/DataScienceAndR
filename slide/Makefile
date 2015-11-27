all : GettingStarted.html RDataMining.html

%.html : %.Rmd
	Rscript -e "slidify::slidify('$<')"

clean :
	-rm -rf GettingStarted.html RDataMining.html ./cache-RDataMining
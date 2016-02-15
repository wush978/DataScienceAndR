RMD=$(wildcard *.Rmd)
HTML=$(RMD:.Rmd=.html)
PDF=$(RMD:.Rmd=.pdf)

all : $(HTML) 
# $(PDF)

%.html : %.Rmd
	-rm $@
	Rscript -e "slidify::slidify('$<')"

%.pdf : %.html
	-firefox $<

clean :
	-rm -rf $(HTML) $(PDF)

cleancache :
	-rm ./cache-* ./assets/fig/*


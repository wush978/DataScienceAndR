RMD=$(wildcard *.Rmd)
HTML=$(RMD:.Rmd=.html)
PDF=$(RMD:.Rmd=.pdf)

all : $(HTML) $(PDF)

%.html : %.Rmd
	Rscript -e "slidify::slidify('$<')"

%.pdf : %.html
	wkhtmltopdf --orientation Landscape --print-media-type --dpi 96 --margin-top 0 --margin-bottom 0 --margin-right 0 --margin-left 0 --disable-smart-shrinking --page-width 297mm --page-height 370mm --javascript-delay 25000 $< $@

clean :
	-rm -rf $(HTML) $(PDF) ./cache-* ./assets/fig/*
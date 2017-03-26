WORKDIR=$()
SRC=index.Rmd material.Rmd before.Rmd after.Rmd teacher.Rmd

all : $(SRC:.Rmd=.html)
	$(MAKE) -C slide

%.md : %.Rmd
	Rscript -e "knitr::knit('$<', '$@')"
	cat header.md > $@.tmp
	cat $@ >> $@.tmp
	mv $@.tmp $@

%.html : %.md
	node_modules/.bin/markdown2bootstrap -h --nav=$(CURDIR)/nav.js $<

.PHONY : clean

clean :
	rm $(SRC:.Rmd=.html)
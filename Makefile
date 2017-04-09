WORKDIR=$()
SRC=index.Rmd install.Rmd before.Rmd material.Rmd after.Rmd teacher.Rmd individual-tracking.Rmd

all : $(SRC:.Rmd=.html) thanks.html
	$(MAKE) -C slide

.check_wiki :
	cd wiki && git pull origin master

thanks.md : wiki/感謝清單.md .check_wiki 
	cp $< $@
	cat header.md > $@.tmp
	cat $@ >> $@.tmp
	mv $@.tmp $@

individual-tracking.md : individual-tracking.Rmd chunks/login.md
	Rscript -e "knitr::knit('$<', '$@')"
	cat header.md > $@.tmp
	cat $@ >> $@.tmp
	mv $@.tmp $@

%.md : %.Rmd
	Rscript -e "knitr::knit('$<', '$@')"
	cat header.md > $@.tmp
	cat $@ >> $@.tmp
	mv $@.tmp $@

%.html : %.md nav.js
	node_modules/.bin/markdown2bootstrap -h --nav=$(CURDIR)/nav.js $<

.PHONY : clean .check_wiki

clean :
	-rm $(SRC:.Rmd=.html)
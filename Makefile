WORKDIR=$()
SRC=index.Rmd install.Rmd before.Rmd material.Rmd after.Rmd teacher.Rmd individual-tracking.Rmd

define md2html
	cat chunks/header.md > $(1).tmp
	cat $(1) >> $@.tmp
	cat chunks/footer.md >> $(1).tmp
	mv $(1).tmp $(1)
endef

all : $(SRC:.Rmd=.html) thanks.html
	$(MAKE) -C slide
	rsync -avx node_modules/markdown2bootstrap/bootstrap .

.check_wiki :
	cd wiki && git pull origin master

thanks.md : wiki/感謝清單.md .check_wiki 
	$(call md2html,$@)

individual-tracking.md : individual-tracking.Rmd chunks/header.md chunks/footer.md chunks/login.md
	Rscript -e "knitr::knit('$<', '$@')"
	$(call md2html,$@)

%.md : %.Rmd chunks/header.md chunks/footer.md
	Rscript -e "knitr::knit('$<', '$@')"
	$(call md2html,$@)

%.html : %.md nav.js
	node_modules/.bin/markdown2bootstrap -h --nav=$(CURDIR)/nav.js $<

.PHONY : clean .check_wiki

clean :
	-rm $(SRC:.Rmd=.html)
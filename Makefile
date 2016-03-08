all: index.html
	$(MAKE) -C slide

README.md: README-src.md
	-rm -r note
	Rscript get_note.R

index.html: README.md
	node_modules/.bin/customizedm2b -h README.md
	mv README.html index.html

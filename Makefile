all : index.html teacher.html
	$(MAKE) -C slide

README.md : README-src.md
	-rm -r note
	Rscript get_note.R

index.html : README.md
	node_modules/.bin/markdown2bootstrap -h README.md
	mv README.html index.html

teacher.html : teacher.md
	node_modules/.bin/markdown2bootstrap $<

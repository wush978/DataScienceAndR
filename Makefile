all : index.html teacher.html
	$(MAKE) -C slide

README.md : README-src.md
	-rm -r note
	Rscript get_note.R

index.html : README.md get_index.R
	node_modules/.bin/markdown2bootstrap -h README.md
	Rscript get_index.R

teacher.html : teacher.md
	node_modules/.bin/markdown2bootstrap $<

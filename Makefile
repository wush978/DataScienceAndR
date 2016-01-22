all : index.html
	$(MAKE) -C slide

index.html : README.md
	node_modules/.bin/markdown2bootstrap -h README.md
	mv README.html index.html

files=$(shell find jekyll/ -type f)
site: $(files)
	jekyll build
	cp _site/index.html .


local: $(files)
	jekyll build --source jekyll --destination .




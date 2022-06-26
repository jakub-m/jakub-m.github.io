files=$(shell find jekyll/ -type f)
publish: $(files)
	jekyll build
	mv _site ..
	git checkout master
	mv ../_site/* .
	git add . 
	git commit -m "Publish $$(date)"


local: $(files)
	jekyll build --source jekyll --destination .




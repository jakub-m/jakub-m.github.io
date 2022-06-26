files=$(shell find jekyll/ -type f)
publish: $(files)
	jekyll build
	rm -frv ../_site
	mv -fv _site ..
	git checkout master
	rm -rf about/ assets/ jekyll/ stuff/
	mv -fv ../_site/* .
	rmdir -v ../_site
	git add . 
	git commit -m "Publish $$(date)"


local: $(files)
	jekyll build --source jekyll --destination .




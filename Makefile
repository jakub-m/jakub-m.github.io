files=$(shell find jekyll/ -type f)

build: $(files)
	jekyll build
watch:
	jekyll build --watch
serve: build
	open http://localhost:8000
	(cd _site; python3 -m http.server)

publish: build
	rm -frv ../_site
	mv -fv _site ..
	git checkout master
	rm -rf about/ assets/ jekyll/ stuff/
	mv -fv ../_site/* .
	rmdir -v ../_site
	git add . 
	git commit -m "Publish $$(date)"






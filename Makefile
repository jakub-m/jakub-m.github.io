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
	rm -rf 202*/ *.html *.xml about/ assets/ jekyll/ stuff/
	rsync -avzt ../_site/ . 
	rm -fvr ../_site
	git add . 
	git commit -m "Publish $$(date)"






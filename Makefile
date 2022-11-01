files=$(shell find jekyll/ -type f)

build: $(files)
	jekyll build
watch:
	jekyll build --watch
serve: build
	open http://localhost:8000
	(cd _site; python3 -m http.server)

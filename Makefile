build:
	docker build . -t jekyll:local

run: build
	docker run --rm -ti -v `pwd`:/site -p 4000:4000 jekyll:local

bundle: build
	docker run --rm -ti -v `pwd`:/site --entrypoint bundle jekyll:local

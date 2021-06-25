.PHONY : all

all: build push deploy

build:
	docker build -t triple3a/demo-app demo-app

push:
	docker push triple3a/demo-app

deploy:
	kubectl apply -n development -f demo-app/k8s

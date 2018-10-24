.PHONY: update-deps docker test

update-deps:
	go install golang.org/x/build/cmd/gitlock
	gitlock --update=Dockerfile golang.org/x/playground

docker: Dockerfile
	docker build -t playground .

test: docker
	go test
	docker run --rm playground test

run: Dockerfile
	docker run --name=play --rm -d -p 8090:8080 -v $(shell pwd)/tmp:/tmp playground


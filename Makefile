# File: Makefile

# Variables
DOCKER_IMAGE_NAME=ghcr.io/arvelog/kbot
DOCKER_TAG=$(shell git describe --tags --always --dirty=-$(shell git rev-parse --short HEAD) 2>/dev/null || echo "latest")
TARGETARCH=amd64

# Targets
docker-build:
	@echo "Building Docker image..."
	docker build . -t $(DOCKER_IMAGE_NAME):$(DOCKER_TAG) --build-arg TARGETARCH=$(TARGETARCH)

docker-push:
	docker push $(DOCKER_IMAGE_NAME):$(DOCKER_TAG)

build:
	go build -o myapp main.go

run:
	docker run -d $(DOCKER_IMAGE_NAME):$(DOCKER_TAG)

deploy:
	kubectl apply -f deployment.yaml

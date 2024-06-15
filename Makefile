.PHONY: all build docker-build docker-push helm-deploy

REGISTRY := ghcr.io/arvelog
IMAGE := $(REGISTRY)/kbot

all: build docker-build docker-push helm-deploy

build:
	@echo "Building the project..."
	go build -o bin/my-bot cmd/my-bot/main.go

docker-build:
	@echo "Building Docker image..."
	VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
	docker build . -t $(IMAGE):$(VERSION) --build-arg TARGETARCH=amd64

docker-push:
	@echo "Pushing Docker image..."
	VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
	docker push $(IMAGE):$(VERSION)

helm-deploy:
	@echo "Deploying to Kubernetes with Helm..."
	VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
	helm upgrade --install kbot ./helm-chart --namespace my-namespace -f values.yaml --set image.repository=$(IMAGE) --set image.tag=$(VERSION)

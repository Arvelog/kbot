.PHONY: all build docker-build docker-push helm-deploy

REGISTRY := ghcr.io/arvelog
IMAGE := $(REGISTRY)/kbot
TAG := $(shell git rev-parse --short HEAD)-linux-amd64

all: build docker-build docker-push helm-deploy

build:
	@echo "Building the project..."
	# Команди для збірки проекту, наприклад:
	# go build -o bin/my-bot cmd/my-bot/main.go

docker-build:
	@echo "Building Docker image..."
	docker build . -t $(IMAGE):$(TAG) --build-arg TARGETARCH=amd64

docker-push:
	@echo "Pushing Docker image..."
	docker push $(IMAGE):$(TAG)

helm-deploy:
	@echo "Deploying to Kubernetes with Helm..."
	helm upgrade --install kbot ./helm-chart --namespace my-namespace -f values.yaml --set image.repository=$(IMAGE) --set image.tag=$(TAG)

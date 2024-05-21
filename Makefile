APP_NAME := kbot
REGISTRY := ghcr.io/vit-um
TAG := $(shell git describe --tags --abbrev=0 --always)-$(shell git rev-parse --short HEAD)

.PHONY: all test build push

all: test build push

test:
    echo "Running tests..."
    # Додайте ваші тести тут

build:
    docker build . -t $(REGISTRY)/$(APP_NAME):$(TAG) --build-arg TARGETARCH=arm64

push:
    docker push $(REGISTRY)/$(APP_NAME):$(TAG)

APP := $(shell basename $$(git remote get-url origin 2>/dev/null) || echo "default_app_name")
REGISTRY=quay.io/projectquay
VERSION := $(shell git describe --tags --abbrev=0 2>/dev/null || echo "v0.0.0")-$(shell git rev-parse --short HEAD)
TARGETARCH ?= arm64
TARGETOS ?= linux

lint:
	golint ./...

test:
	go test -v ./...

format:
	gofmt -s -w ./

build: format
	CGO_ENABLED=0 GOOS=$(TARGETOS) GOARCH=$(TARGETARCH) go build -v -o /go/src/app/kbot -ldflags "-X github.com/arvelog/kbot/cmd.appVersion=${VERSION}"

image:
	docker build . -t ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}

push:
	docker push ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}

clean:
	docker rmi ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH} || true

dependencies:
	go get ./...

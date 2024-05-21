.PHONY: all build docker-build docker-push helm-deploy

all: build docker-build docker-push helm-deploy

build:
    @echo "Building the project..."
    # Команди для збірки проекту, наприклад:
    # go build -o bin/my-bot cmd/my-bot/main.go

docker-build:
    @echo "Building Docker image..."
    docker build -t ghcr.io/arvelog/kbot:latest .

docker-push:
    @echo "Pushing Docker image..."
    docker push ghcr.io/arvelog/kbot:latest

helm-deploy:
    @echo "Deploying to Kubernetes with Helm..."
    helm upgrade --install my-bot ./helm-chart --namespace my-namespace -f values.yaml

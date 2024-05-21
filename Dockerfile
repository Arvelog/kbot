FROM golang:1.18 AS builder
WORKDIR /app
COPY . .
RUN go build -o my-bot cmd/my-bot/main.go

FROM alpine:latest
WORKDIR /root/
COPY --from=builder /app/my-bot .
CMD ["./my-bot"]

FROM golang:1.18 AS builder
WORKDIR /app
COPY . .
RUN go build -o kbot cmd/kbot/main.go

FROM alpine:latest
WORKDIR /root/
COPY --from=builder /app/kbot .
CMD ["./kbot"]

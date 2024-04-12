# Use the specific base image
FROM quay.io/projectquay/golang:1.22 as builder

WORKDIR /go/src/app
COPY . .

# Install dependencies and build the application
RUN make build

# Use scratch for a minimal production image
FROM scratch
WORKDIR /
COPY --from=builder /go/src/app/kbot /kbot
COPY --from=alpine:latest /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
ENTRYPOINT ["/kbot"]

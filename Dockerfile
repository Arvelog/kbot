FROM golang:1.22 as builder

WORKDIR /go/src/app
COPY . .

RUN make build
RUN ls -l /go/src/app  # This will list the files in the directory

FROM scratch
WORKDIR /
COPY --from=builder /go/src/app/kbot .
COPY --from=alpine:latest /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
ENTRYPOINT ["./kbot"]
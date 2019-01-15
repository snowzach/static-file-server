FROM golang:1.11 as builder

RUN mkdir -p /build
WORKDIR /build
COPY . .

RUN go test -cover ./...
RUN CGO_ENABLED=0 go build -a -installsuffix cgo -o /serve /build/bin/serve

FROM scratch
EXPOSE 8080
COPY --from=builder /serve /
ENTRYPOINT ["/serve"]
CMD []

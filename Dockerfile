FROM golang:1.18.0-alpine3.14 AS builder

WORKDIR /app

COPY go.mod go.sum ./

RUN go mod download

COPY *.go ./

RUN CGO_ENABLED=0 GOOS=linux go build -o /demo-app

FROM alpine:3 AS runtime

RUN apk add --no-cache ca-certificates

COPY --from=builder /demo-app /usr/bin/demo-app

EXPOSE 8080
CMD ["demo-app"]
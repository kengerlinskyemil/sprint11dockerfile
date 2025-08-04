FROM golang:1.22-alpine AS builder
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY *.go ./
RUN go build -o app .


FROM alpine:latest
WORKDIR /app
COPY --from=builder /app/app /app/app
COPY tracker.db /app/tracker.db
CMD ["./app"]
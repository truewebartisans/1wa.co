FROM golang:alpine AS builder

WORKDIR /app
COPY go.mod .
COPY go.sum .
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o 1wa_httpserver .

FROM scratch

COPY --from=builder /app/1wa_httpserver /app/
ENTRYPOINT [ "/app/1wa_httpserver" ]

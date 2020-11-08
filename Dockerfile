FROM golang:1.13.4 AS builder

COPY app.go .
RUN go get -d -v \
	github.com/lib/pq \
	github.com/julienschmidt/httprouter

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o prod .

##

FROM scratch
COPY --from=builder /go/prod .

EXPOSE 8000
CMD ["./prod"] 

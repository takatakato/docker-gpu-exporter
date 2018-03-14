FROM golang:1.10-alpine3.7 as builder

COPY ./ ./

RUN go get -d -v 
RUN go build main.go


FROM alpine:3.6

RUN apk --no-cache add ca-certificates

COPY --from=builder /go/main /
COPY --from=builder /go/template /template

EXPOSE 9201

ENTRYPOINT ["/main"]
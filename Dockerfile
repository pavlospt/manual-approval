FROM public.ecr.aws/docker/library/golang:1.24 AS builder

COPY . /var/app

WORKDIR /var/app

RUN CGO_ENABLED=0 go build -o app .

FROM public.ecr.aws/docker/library/alpine:3.21

LABEL org.opencontainers.image.source=https://github.com/pavlospt/manual-approval

RUN apk update && apk add ca-certificates

COPY --from=builder /var/app/app /var/app/app

CMD ["/var/app/app"]

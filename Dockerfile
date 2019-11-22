FROM alpine:3.10

LABEL maintainer="syuchan1005<syuchan.dev@gmail.com>"
LABEL name="onamae-ddns"

RUN apk add --no-cache openssl

ENV oanameServer=ddnsclient.onamae.com \
    ipCheckServerPort=65000 \
    modIpServerPort=65010 \
    sleep=10m \
    domains=""

COPY . /onamae

ENTRYPOINT ["/onamae/docker-entrypoint.sh"]

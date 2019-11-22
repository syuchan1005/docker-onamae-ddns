FROM alpine:3.10

LABEL maintainer="syuchan1005<syuchan.dev@gmail.com>"
LABEL name="onamae-ddns"

ENV oanameServer=ddnsclient.onamae.com \
    ipCheckServerPort=65000 \
    modIpServerPort=65010 \
    sleep=10m \
    domains=""

RUN apk add --no-cache openssl

COPY . /onamae

RUN chmod +x /onamae/*.sh

ENTRYPOINT ["/onamae/docker-entrypoint.sh"]

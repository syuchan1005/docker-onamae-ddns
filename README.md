# docker-onamae-ddns

[![GitHub Actions](https://github.com/syuchan1005/docker-onamae-ddns/workflows/Docker%20Image%20CI/badge.svg)](https://github.com/syuchan1005/BookReader/actions)

[![Docker Hub Version](https://img.shields.io/badge/dynamic/json?color=0db7ed&label=Docker%20Hub&query=results.0.name&url=https%3A%2F%2Fregistry.hub.docker.com%2Fv2%2Frepositories%2Fsyuchan1005%2Fonamae-ddns%2Ftags%2F)](https://hub.docker.com/r/syuchan1005/book_reader)

[![dockeri.co](https://dockeri.co/image/syuchan1005/onamae-ddns)](https://hub.docker.com/r/syuchan1005/onamae-ddns)

```bash
$ docker run -d --name onamae \
    -e domains="...." \
    syuchan1005/onamae-ddns
```

## env
|name|type|value|
|:---|:---|:----|
|onamaeServer|optional|ddnsclient.onamae.com|
|ipCheckServerPort|optional|65000|
|modIpServerPort|optional|65010|
|sleep|optional|10m|
|domains|**required**| `<userId>:<password>:<host name(optional)>:<domain>,<userId>...` |

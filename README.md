# docker-onamae-ddns

```bash
$ docker run -d --name onamae \
    -e domains="...." \
    docker.pkg.github.com/syuchan1005/docker-onamae-ddns/onamae_ddns
```

## env
|name|type|value|
|:---|:---|:----|
|onamaeServer|optional|ddnsclient.onamae.com|
|ipCheckServerPort|optional|65000|
|modIpServerPort|optional|65010|
|sleep|optional|10m|
|domains|**required**| `<userId>:<password>:<host name(optional)>:<domain>,<userId>...` |

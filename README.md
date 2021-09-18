# docker-dns-proxy

Docker container that will allow you to proxy your DNS queries using DNS-over-HTTPS/DNS-over-TLS

## Configuration options

See [Dockerfile](Dockerfile#L4)

## How to use

Run the container using one of the following methods, then feel free to point your favourite DNS client towards port 53 using the TCP or UDP protocol.

### DNS-over-HTTPS

```sh
$ docker run \
    --restart=always \
    -d \
    -e "DYNSD_USE_DOH=true" \
    -p 53:53 \
    -p 53:53/udp \
    julianxhokaxhiu/docker-dns-proxy
```

### DNS-over-TLS

```sh
$ docker run \
    --restart=always \
    -d \
    -e "DYNSD_USE_DOT=true" \
    -p 53:53 \
    -p 53:53/udp \
    julianxhokaxhiu/docker-dns-proxy
```

## Environment

- HTTP PROXY: `docker run --name squid -d --restart=always -v /srv/docker/squid/cache:/var/spool/squid -p 3128:3128 datadog/squid`


ARG CADDY_VERSION=2.10.2

# Builder
FROM caddy:${CADDY_VERSION}-builder-alpine AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/porkbun 
    #--with github.com/lucaslorentz/caddy-docker-proxy/v2

# Container
FROM caddy:${CADDY_VERSION}-alpine

# install additional packages
RUN apk add --no-cache tzdata

LABEL org.opencontainers.image.vendor="cablethewizard"
LABEL org.opencontainers.image.documentation="https://github.com/cablethewizard/docker-caddy-wizard"
LABEL org.opencontainers.image.source="https://github.com/cablethewizard/docker-caddy-wizard"

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
CMD ["caddy", "docker-proxy"]
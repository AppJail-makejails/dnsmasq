ARG FREEBSD_RELEASE

FROM ghcr.io/appjail-makejails/core:${FREEBSD_RELEASE}

ARG NO_PKGCLEAN

LABEL org.opencontainers.image.title="DNSMasq" \
    org.opencontainers.image.description="Lightweight DNS forwarder, DHCP, and TFTP server" \
    org.opencontainers.image.source="https://github.com/AppJail-makejails/dnsmasq" \
    org.opencontainers.image.url="https://github.com/AppJail-makejails/dnsmasq" \
    org.opencontainers.image.vendor="DtxdF" \
    org.opencontainers.image.authors="Jesús Daniel Colmenares Oviedo <dtxdf@disroot.org>"

RUN set -xe; \
    \
    pkg update; \
    pkg install -U dnsmasq; \
    \
    if [ -z "${NO_PKGCLEAN}" ]; then \
        pkg clean -a; \
        rm -rf /var/cache/pkg/*; \
    fi; \
    rm -rf /var/db/pkg/repos/*

CMD ["dnsmasq", "-d"]

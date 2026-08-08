# DNSMasq

DNSMasq is free software providing Domain Name System (DNS) caching, a Dynamic Host Configuration Protocol (DHCP) server, router advertisement and network boot features, intended for small computer networks.

dnsmasq has low requirements for system resources, can run on Linux, BSDs, Android and macOS, and is included in most Linux distributions. Consequently, it "is present in a lot of home routers and certain Internet of Things gadgets" and is included in Android.

wikipedia.org/wiki/dnsmasq

<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Dnsmasq_icon.svg/960px-Dnsmasq_icon.svg.png" width="30%" height="auto" alt="DNSMasq logo">

## How to use this Makejail

```console
$ appjail oci run -Pd \
    -o overwrite=force \
    -o virtualnet=":<random> default" \
    -o nat \
    -o expose=53 \
    ghcr.io/appjail-makejails/dnsmasq dnsmasq
```

### Arguments (stage: build)

* `dnsmasq_from` (default: `ghcr.io/appjail-makejails/dnsmasq`): Location of OCI image. See also [OCI Configuration](#oci-configuration).
* `dnsmasq_tag` (default: `latest`): OCI image tag. See also [OCI Configuration](#oci-configuration).


## OCI Configuration

```yaml
build:
  variants:
    - tag: 15.1
      containerfile: Containerfile
      aliases: ["latest"]
      default: true
      args:
        FREEBSD_RELEASE: "15.1"
        NO_PKGCLEAN: "1"
      cache_dirs: ["pkgcache0:/var/cache/pkg"]
```

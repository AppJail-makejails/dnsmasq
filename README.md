# dnsmasq

dnsmasq is free software providing Domain Name System (DNS) caching, a Dynamic Host Configuration Protocol (DHCP) server, router advertisement and network boot features, intended for small computer networks.

dnsmasq has low requirements for system resources, can run on Linux, BSDs, Android and macOS, and is included in most Linux distributions. Consequently, it "is present in a lot of home routers and certain Internet of Things gadgets" and is included in Android.

wikipedia.org/wiki/dnsmasq

<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Dnsmasq_icon.svg/800px-Dnsmasq_icon.svg.png" alt="dnsmasq logo" width="40%" height="auto">

## How to use this Makejail

### Basic usage

```
INCLUDE options/network.makejail
INCLUDE gh+AppJail-makejails/dnsmasq

OPTION expose=53
```

Where options/network.makejail are the options that suit your environment, for example:

```
ARG network
ARG interface=dnsmasq

OPTION virtualnet=${network}:${interface} default
OPTION nat
```

Open a shell and run `appjail makejail`:

```sh
appjail makejail -j dnsmasq -- --network home
```

### DHCP Server

```
INCLUDE options/network.makejail
INCLUDE gh+AppJail-makejails/dnsmasq

SYSRC "ifconfig_${vnet_interface}=inet 129.0.0.1/24"
SERVICE netif restart "${vnet_interface}"
COPY dnsmasq.conf /usr/local/etc/dnsmasq.conf
REPLACE /usr/local/etc/dnsmasq.conf INTERFACE "${vnet_interface}"

SERVICE dnsmasq reload
```

Where `options/network.makejail` are the options that allow the outgoing connection in the `dnsmasq` jail to install `dns/dnsmasq` and an inteface to be used by the DHCP server.

**options/network.makejail**:

```
INCLUDE virtualnet.makejail
INCLUDE vnet.makejail
```

**options/virtualnet.makejail**:

```
ARG virtualnet
ARG virtualnet_interface=dnsmasq

OPTION virtualnet=${virtualnet}:${virtualnet_interface} default
OPTION nat
```

**options/vnet.makejail**:

```
ARG vnet_interface
ARG vnet_ruleset=0

OPTION vnet=${vnet_interface}
OPTION mount_devfs
OPTION devfs_ruleset=${vnet_ruleset}
```

**Note**: To correctly use the DHCP server implemented in dnsmasq, your ruleset must unhide `bpf*`.

A minimal configuration file for dnsmasq is as follows:

```
interface=%{INTERFACE}
dhcp-range=129.0.0.2,129.0.0.150,12h
```

Open a shell and run `appjail makejail`:

```sh
appjail makejail -j dnsmasq -- \
	--virtualnet testing \
	--vnet_interface em0 \
	--vnet_ruleset 10
```

### Arguments

* `dnsmasq_tag` (default: `13.5`): see [#tags](#tags).
* `dnsmasq_ajspec` (default: `gh+AppJail-makejails/dnsmasq`): Entry point where the `appjail-ajspec(5)` file is located.

## Tags

| Tag    | Arch    | Version           | Type   |
| ------ | ------- | ----------------- | ------ |
| `13.5` | `amd64` | `13.5-RELEASE` | `thin` |
| `14.3` | `amd64` | `14.3-RELEASE` | `thin` |

# NATS Server (gnatsd) Plan for Habitat

## Authors Notes

This is a really interesting plan.  NATS (aka: _gnatsd_) is a single binary Go app, 
so deploying it should be incredibly simple.  The problem is, the binary is dynamically
linked and depends on /lib64/ld-linux-x86-64.so.2, at the ELF level.  This problem arose
for the phantomjs plan and _patchelf_ was used to re-write the ELF Headers, however that
trick didn't work for me here.  

After much tinkering, the best solution turned out to be the use of *init* and *run* hooks.  The
*init* hook simply symlinks the library from glibc into the expected location, and the *run*
hook kicks off _gnatsd_ with some options.

The result is a smooth working container and solid plan, but its decievingly simple. :)

## Usage

### To build:

```
build ops-plans/gnatsd
hab-bpm exec core/hab-pkg-dockerize hab-pkg-dockerize cuddletech/gnatsd
```


### To run:

```
$ docker run -it cuddletech/gnatsd
hab-sup(MN): Starting cuddletech/gnatsd
hab-sup(GS): Supervisor 172.17.0.2: aa8a6144-fea3-4f7d-b501-401c1c1c00d1
hab-sup(GS): Census gnatsd.default: 0f37ec19-4be8-49ba-b487-9aa5b41f5ce6
hab-sup(GS): Starting inbound gossip listener
hab-sup(GS): Starting outbound gossip distributor
hab-sup(GS): Starting gossip failure detector
hab-sup(CN): Starting census health adjuster
hab-sup(SC): Updated gnatsd.config
hab-sup(TP): Restarting because the service config was updated via the census
init(PH): Symlinking /lib/ld-linux-x86-64.so.2...
gnatsd(SV): Starting
gnatsd(O): Starting NATS...
gnatsd(O): [193] 2016/04/30 09:43:46.875211 [INF] Starting gnatsd version 0.7.2
gnatsd(O): [193] 2016/04/30 09:43:46.875235 [INF] Listening for client connections on 0.0.0.0:4222
gnatsd(O): [193] 2016/04/30 09:43:46.875269 [INF] gnatsd is ready
```

### To test:

See [NATS Protocol](http://nats.io/documentation/internals/nats-protocol/) for details on interfacing via telnet:

```
$ telnet 172.17.0.2 4222
Trying 172.17.0.2...
Connected to 172.17.0.2.
Escape character is '^]'.
INFO {"server_id":"f9f95def0df6081a3c9eddf6e53f1cda","version":"0.7.2","go":"go1.5.2","host":"0.0.0.0","port":4222,"auth_required":false,"ssl_required":false,"tls_required":false,"tls_verify":false,"max_payload":1048576} 
```

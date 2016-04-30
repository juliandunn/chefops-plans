## Build

Create a studio, generate the origin keys for "cuddletech", then build and dockerize:

```
studio new
studio enter

hab origin key generate cuddletech
build ops-plans/lighttpd

hab-bpm install core/hab-pkg-dockerize
hab-bpm exec core/hab-pkg-dockerize hab-pkg-dockerize cuddletech/lighttpd
```

## Run

To run the Docker container, provide a local directory with HTML as the docroot to _lighttpd_.  Example:

```
benr@magnolia:~$ docker run -it -v ~/public_html:/hab/svc/lighttpd/data  cuddletech/lighttpd
hab-sup(MN): Starting cuddletech/lighttpd
hab-sup(GS): Supervisor 172.17.0.2: 783dbc41-821a-4f2d-9dd1-6079b123517c
hab-sup(GS): Census lighttpd.default: 5dee85b3-29cb-4c5e-9455-531cd90f729a
hab-sup(GS): Starting inbound gossip listener
hab-sup(GS): Starting outbound gossip distributor
hab-sup(GS): Starting gossip failure detector
hab-sup(CN): Starting census health adjuster
hab-sup(SC): Updated lighttpd.conf
hab-sup(TP): Restarting because the service config was updated via the census
lighttpd(SV): Starting
lighttpd(O): 2016-04-30 00:31:50: (log.c.194) server started 
```
 

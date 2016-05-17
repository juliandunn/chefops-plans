# Using Habitat Packages without Docker

It is possible to install packages without Dockerizing them.  This document demonstrates how to do so.

Please note that Habitat services utilize the _hab-sup_ supervisor for applying configuration to the template,
therefore you must install and run the service via the supervisor.

Also, the _hab-sup_ daemon expects the _hab_ user and group to be present.

This proceedure was tested successfully on an Ubuntu 14.04 Vagrant box.

## Instructions

I learned this method from Nathan Smith, it borrows from the Habitat Studio installer script.

Begin by downloading or cut-n-pasting the (install.sh)[https://raw.githubusercontent.com/habitat-sh/habitat/master/components/studio/install.sh]
script onto the host your going to use.

Now execute the script.  This will get the BPM tool which allows you to install packages.

Now install the Habitat package you desire from the Depot.  This will grab all dependancies as well.  Example:

```bash
$ sudo hab-bpm install core/nginx
   hab-bpm: Installing core/nginx/1.8.0/20160428171926
   hab-bpm: Downloading core-nginx-1.8.0-20160428171926-x86_64-linux.hart
--2016-05-16 22:59:57--  http://willem.habitat.sh:9636/v1/depot/pkgs/core/nginx/1.8.0/20160428171926/download
Resolving willem.habitat.sh... 52.37.151.35
Connecting to willem.habitat.sh|52.37.151.35|:9636... connected.
....
```

Now create the _hab_ user and group, then install the Habitat Supervisor (hab-sup):

```bash
$ sudo useradd -G hab hab
$ sudo hab-bpm install core/hab-sup
....
```

Finally, you can start the supervisor to fire up your service!

```bash
$ sudo /hab/pkgs/core/hab-sup/0.5.0/20160516182206/bin/hab-sup start -v core/nginx
hab-sup(MN): Starting core/nginx
hab-sup(GS): Supervisor 10.0.2.15: 3e55fbd0-1c0d-4107-b1c3-0a21a48503f3
hab-sup(GS): Census nginx.default: 584c5df1-449a-4691-b7b8-e6b870e81ecb
hab-sup(GS): Starting inbound gossip listener
hab-sup(GS): Starting outbound gossip distributor
hab-sup(GS): Starting gossip failure detector
hab-sup(CN): Starting census health adjuster
hab-sup(SC): Updated scgi_params
hab-sup(SC): Updated uwsgi_params
hab-sup(SC): Updated win-utf
hab-sup(SC): Updated mime.types
hab-sup(SC): Updated fastcgi.conf
hab-sup(SC): Updated nginx.conf
hab-sup(SC): Updated koi-win
hab-sup(SC): Updated fastcgi_params
hab-sup(SC): Updated koi-utf
hab-sup(TP): Restarting because the service config was updated via the census
nginx(SV): Starting
```

Running!  

Remember to wrap this in an init-script if you want it to restart on boot.

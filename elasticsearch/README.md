# ElasticSearch Plan for Habitat





# Run-Time Configuration

A normal startup looks like this (some lines removed for clarity):

```
$ docker run -it  chefops/elasticsearch
hab-sup(MN): Starting chefops/elasticsearch
hab-sup(GS): Supervisor 172.17.0.2: 6ff4e063-7b64-48ed-a617-b5677d244c29
hab-sup(GS): Census elasticsearch.default: 6f78376d-016c-40d1-8cff-e867b579cd53
hab-sup(GS): Starting inbound gossip listener
hab-sup(GS): Starting outbound gossip distributor
hab-sup(GS): Starting gossip failure detector
hab-sup(CN): Starting census health adjuster
hab-sup(SC): Updated elasticsearch.yml
hab-sup(SC): Updated logging.yml
hab-sup(TP): Restarting because the service config was updated via the census
init(PH): Symlinking /lib/ld-linux-x86-64.so.2...
init(PH): Preparing Storage...
elasticsearch(SV): Starting
elasticsearch(O): [2016-05-03 10:51:25,293][INFO ][node                     ] [Bill Foster] version[2.3.2], pid[198], build[b9e4a6a/2016-04-21T16:03:47Z]
elasticsearch(O): [2016-05-03 10:51:25,293][INFO ][node                     ] [Bill Foster] initializing ...
elasticsearch(O): [2016-05-03 10:51:26,626][INFO ][node                     ] [Bill Foster] initialized
elasticsearch(O): [2016-05-03 10:51:26,626][INFO ][node                     ] [Bill Foster] starting ...
elasticsearch(O): [2016-05-03 10:51:26,671][INFO ][transport                ] [Bill Foster] publish_address {127.0.0.1:9300}, bound_addresses {[::1]:9300}, {127.0.0.1:930
elasticsearch(O): [2016-05-03 10:51:26,674][INFO ][discovery                ] [Bill Foster] elasticsearch/yx9DBdrTQc6mKgWGDz43gQ
elasticsearch(O): [2016-05-03 10:51:29,701][INFO ][cluster.service          ] [Bill Foster] new_master {Bill Foster}{yx9DBdrTQc6mKgWGDz43gQ}{127.0.0.1}{127.0.0.1:9300}, r
n: zen-disco-join(elected_as_master, [0] joins received)
elasticsearch(O): [2016-05-03 10:51:29,725][INFO ][http                     ] [Bill Foster] publish_address {127.0.0.1:9200}, bound_addresses {[::1]:9200}, {127.0.0.1:920
elasticsearch(O): [2016-05-03 10:51:29,725][INFO ][node                     ] [Bill Foster] started
elasticsearch(O): [2016-05-03 10:51:29,759][INFO ][gateway                  ] [Bill Foster] recovered [0] indices into cluster_state
...
```

## Custom Node Name

To specify a single configuration override, namely the node-name, pass like so:

```bash
benr@magnolia:~$ docker run -it -e HAB_ELASTICSEARCH='node-name = "codecan"'  chefops/elasticsearch
hab-sup(MN): Starting chefops/elasticsearch
hab-sup(GS): Supervisor 172.17.0.5: 948588ae-8b57-43c9-820a-e430908ade36
hab-sup(GS): Census elasticsearch.default: 0d3c2a18-d471-4335-841f-2a233023450e
hab-sup(GS): Starting inbound gossip listener
hab-sup(GS): Starting outbound gossip distributor
hab-sup(GS): Starting gossip failure detector
hab-sup(CN): Starting census health adjuster
hab-sup(SC): Updated elasticsearch.yml
hab-sup(SC): Updated logging.yml
hab-sup(TP): Restarting because the service config was updated via the census
init(PH): Symlinking /lib/ld-linux-x86-64.so.2...
init(PH): Preparing Storage...
elasticsearch(SV): Starting
elasticsearch(O): [2016-05-07 07:47:37,073][INFO ][node                     ] [codecan] version[2.3.2], pid[190], build[b9e4a6a/2016-04-21T16:03:47Z]
elasticsearch(O): [2016-05-07 07:47:37,073][INFO ][node                     ] [codecan] initializing ...
elasticsearch(O): [2016-05-07 07:47:38,231][INFO ][node                     ] [codecan] initialized
elasticsearch(O): [2016-05-07 07:47:38,231][INFO ][node                     ] [codecan] starting ...
```

## Multiple Configuration Over-Rides

Sadly you can't seem to serialize TOML, you require real line-breaks, so you need to put your configuration over-rides in a file and read them in:

```
$ cat es-custom.toml 
cluster-name = "es-dev-cluster"
node-name = "node001"

$ docker run -it -e HAB_ELASTICSEARCH="$(cat es-custom.toml)"  chefops/elasticsearch
hab-sup(MN): Starting chefops/elasticsearch
hab-sup(GS): Supervisor 172.17.0.5: 9959d255-26df-43fd-acd2-1c3ccf3e0197
hab-sup(GS): Census elasticsearch.default: aeb3e086-bdf3-4add-b017-6a6c43b6567c
hab-sup(GS): Starting inbound gossip listener
hab-sup(GS): Starting outbound gossip distributor
hab-sup(GS): Starting gossip failure detector
hab-sup(CN): Starting census health adjuster
hab-sup(SC): Updated elasticsearch.yml
hab-sup(SC): Updated logging.yml
hab-sup(TP): Restarting because the service config was updated via the census
init(PH): Symlinking /lib/ld-linux-x86-64.so.2...
init(PH): Preparing Storage...
elasticsearch(SV): Starting
elasticsearch(O): [2016-05-07 07:59:24,373][WARN ][bootstrap                ] Unable to lock JVM Memory: error=12,reason=Cannot allocate memory
elasticsearch(O): [2016-05-07 07:59:24,373][WARN ][bootstrap                ] This can result in part of the JVM being swapped out.
elasticsearch(O): [2016-05-07 07:59:24,374][WARN ][bootstrap                ] Increase RLIMIT_MEMLOCK, soft limit: 65536, hard limit: 65536
elasticsearch(O): [2016-05-07 07:59:24,374][WARN ][bootstrap                ] These can be adjusted by modifying /etc/security/limits.conf, for example: 
elasticsearch(O):       # allow user 'hab' mlockall
elasticsearch(O):       hab soft memlock unlimited
elasticsearch(O):       hab hard memlock unlimited
elasticsearch(O): [2016-05-07 07:59:24,374][WARN ][bootstrap                ] If you are logged in interactively, you will have to re-login for the new limits to take effect.
elasticsearch(O): [2016-05-07 07:59:24,466][INFO ][node                     ] [node001] version[2.3.2], pid[191], build[b9e4a6a/2016-04-21T16:03:47Z]
elasticsearch(O): [2016-05-07 07:59:24,466][INFO ][node                     ] [node001] initializing ...
elasticsearch(O): [2016-05-07 07:59:24,771][INFO ][plugins                  ] [node001] modules [reindex, lang-expression, lang-groovy], plugins [], sites []
elasticsearch(O): [2016-05-07 07:59:24,784][INFO ][env                      ] [node001] using [1] data paths, mounts [[/hab/svc/elasticsearch/data (/dev/disk/by-uuid/76612309-0fd4-48ee-a756-a3c6aacc70f7)]], net usable_space [24.1gb], net total_space [218.8gb], spins? [possibly], types [ext4]
elasticsearch(O): [2016-05-07 07:59:24,784][INFO ][env                      ] [node001] heap size [989.8mb], compressed ordinary object pointers [true]
elasticsearch(O): [2016-05-07 07:59:25,617][INFO ][node                     ] [node001] initialized
elasticsearch(O): [2016-05-07 07:59:25,617][INFO ][node                     ] [node001] starting ...
...
```

# Verifying Function

```
$ curl 172.17.0.5:9200
{
  "name" : "node001",
  "cluster_name" : "es-dev-cluster",
  "version" : {
    "number" : "2.3.2",
    "build_hash" : "b9e4a6acad4008027e4038f6abed7f7dba346f94",
    "build_timestamp" : "2016-04-21T16:03:47Z",
    "build_snapshot" : false,
    "lucene_version" : "5.5.0"
  },
  "tagline" : "You Know, for Search"
}


$ curl 172.17.0.5:9200/_cat/health
1462608670 08:11:10 es-dev-cluster green 1 1 0 0 0 0 0 0 - 100.0% 

$ curl 172.17.0.5:9200/_cat/nodes
172.17.0.5 172.17.0.5 3 96 0.37 d * node001 

```

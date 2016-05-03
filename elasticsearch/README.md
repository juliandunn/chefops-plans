# ElasticSearch Plan for Habitat


## Running!

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
elasticsearch(O): [2016-05-03 10:51:25,597][INFO ][plugins                  ] [Bill Foster] modules [reindex, lang-expression, lang-groovy], plugins [], sites []
elasticsearch(O): [2016-05-03 10:51:25,608][INFO ][env                      ] [Bill Foster] using [1] data paths, mounts [[/hab/svc/elasticsearch/data (/dev/disk/by-uuid/
2309-0fd4-48ee-a756-a3c6aacc70f7)]], net usable_space [18.4gb], net total_space [218.8gb], spins? [possibly], types [ext4]
elasticsearch(O): [2016-05-03 10:51:25,608][INFO ][env                      ] [Bill Foster] heap size [989.8mb], compressed ordinary object pointers [true]
elasticsearch(O): [2016-05-03 10:51:26,626][INFO ][node                     ] [Bill Foster] initialized
elasticsearch(O): [2016-05-03 10:51:26,626][INFO ][node                     ] [Bill Foster] starting ...
elasticsearch(O): [2016-05-03 10:51:26,671][INFO ][transport                ] [Bill Foster] publish_address {127.0.0.1:9300}, bound_addresses {[::1]:9300}, {127.0.0.1:930
elasticsearch(O): [2016-05-03 10:51:26,674][INFO ][discovery                ] [Bill Foster] elasticsearch/yx9DBdrTQc6mKgWGDz43gQ
elasticsearch(O): [2016-05-03 10:51:29,701][INFO ][cluster.service          ] [Bill Foster] new_master {Bill Foster}{yx9DBdrTQc6mKgWGDz43gQ}{127.0.0.1}{127.0.0.1:9300}, r
n: zen-disco-join(elected_as_master, [0] joins received)
elasticsearch(O): [2016-05-03 10:51:29,725][INFO ][http                     ] [Bill Foster] publish_address {127.0.0.1:9200}, bound_addresses {[::1]:9200}, {127.0.0.1:920
elasticsearch(O): [2016-05-03 10:51:29,725][INFO ][node                     ] [Bill Foster] started
elasticsearch(O): [2016-05-03 10:51:29,759][INFO ][gateway                  ] [Bill Foster] recovered [0] indices into cluster_state
elasticsearch(O): [2016-05-03 10:51:59,706][WARN ][cluster.routing.allocation.decider] [Bill Foster] high disk watermark [90%] exceeded on [yx9DBdrTQc6mKgWGDz43gQ][Bill F
r][/hab/svc/elasticsearch/data/elasticsearch/nodes/0] free: 18.4gb[8.4%], shards will be relocated away from this node
elasticsearch(O): [2016-05-03 10:51:59,707][INFO ][cluster.routing.allocation.decider] [Bill Foster] rerouting shards: [high disk watermark exceeded on one or more nodes]
elasticsearch(O): [2016-05-03 10:52:29,711][WARN ][cluster.routing.allocation.decider] [Bill Foster] high disk watermark [90%] exceeded on [yx9DBdrTQc6mKgWGDz43gQ][Bill F
r][/hab/svc/elasticsearch/data/elasticsearch/nodes/0] free: 18.4gb[8.4%], shards will be relocated away from this node
```

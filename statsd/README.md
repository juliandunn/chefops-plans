# StatsD Plan for Habitat

[StatsD](https://github.com/etsy/statsd) 


## TODO:

* The config isn't very flexible right now, namely because the config file
is in JSON and this makes it harder to templetize as it depends on whether
an objects attribute exists or not.  Need to play with nil's in TOML.
* Doesn't support mgmt_port; just need to export 8126
* Lacks a volume for persistance


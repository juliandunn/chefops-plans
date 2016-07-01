# Overview

Habitat's supervisor supports several topologies to handle concerns such as leader election for you.  The supported tolopogies are:

- Standalone
- Leader-Follower
- Initializer

Service groups are used to limit the scope of a topology (so your ring can have more than 1 Leader-Follower group).

When starting the process the topology and service group can be specified with `--topology` and `--group` and the ring is joined using `--peer`.  So starting up a package using the leader topology might look like:
```
hab start chefops/nomad --topology leader --group nomad.test --peer 10.11.12.13
```
or
```
# docker args are passed to hab so the arguments are the same
docker run -it chefops/nomad --topology leader --group nomad.test --peer 10.11.12.13
```

In this case the `leader` topology is specified so habitat will handle leader election, a service group name of `nomad.test` is used and the existing peer (a node already in the ring) is `10.11.12.13`.

## Topologies

The supervisor has a ring which knows about all other supervisors in the ring and service groups for smaller groupings of supervisors.  The ring a supervisor is in as well as it's service group will define it's view of the world.  When creating and running your package consider:

1. Do I need leader election?
2. Do followers of the leader need to wait on an initialization process?
3. Does this package require any dynamic action when other members of it's service join and/or leave?
4. Do I need any sort of service discovery?

- If 1 and 2 are true, you should use the `initializer` topology and a specific service group.
- If 1 is true, but not 2, you should use the `leader topology and a specific service group.
- If 3 is true, but not 1 or 2, you should use a specific service group but the default topology of `standalone` is fine.
- If 4 is true, but not 1-3, then be sure to join an existing ring but there's no need to make a service group or use a non-default topology.

The `leader` topology handles the leader election and sets one member to leader and the rest to followers.  The supervisor will wait for a leader before the process starts.
The `initializer` is the same as `leader` but also blocks starting followers until the leader is fully initialized.
The `standalone` topology still adds members to the group, but does not leader election and sets `leader` and `follower` to `false` for every member.  This is the default behavior.

## Service Groups

Service groups can be used to limit the scope of a topology and allow multiple of a topology type in a shared ring.  Service group names can be anything, for the sake of consistency and clarity it's recommended to use the format of `SERVICE_NAME.ENVIRONEMT` so to match our Delivery environments `nomad.acceptance`, `nomad.union`, `nomad.rehearsal` and `nomad.delivered` are used and `nomad.test` is used outside of Delivery.

## Config

Habitat packages allow for templated config files using the (handlebars templating syntax)[http://handlebarsjs.com/].  There is a good overview of the config in the (official docs)[https://www.habitat.sh/docs/create-packages-configure/], but in addtion to the user supplied config the supervisor has a lot of built in variables related to topologies and service groups.

### General
* `bind` - ? I don't know what this is
* `cfg` - User supplied/default package config (default.toml, etc.)
* `hab.version` - habitat supervisor version

### Packages
`pkg` stuff all comes straight from plan.sh, see https://www.habitat.sh/docs/reference/plan-syntax/ for details
* pkg.exposes 
* pkg.ident
* pkg.name
* pkg.origin
* pkg.path
* pkg.release
* pkg.svc_config_path
* pkg.svc_data_path
* pkg.svc_files_path
* pkg.svc_path
* pkg.svc_static_path 
* pkg.svc_var_path
* pkg.version

Arrays of dependencies exist for all deps: `pkg.deps[.deps[.deps...]]` which include all the above.  For example:

```
[[pkg.deps.deps]]
exposes = []
ident = "core/glibc/2.22/20160612063629"
name = "glibc"
origin = "core"
path = "/hab/pkgs/core/glibc/2.22/20160612063629"
release = "20160612063629"
svc_config_path = "/hab/svc/glibc/config"
svc_data_path = "/hab/svc/glibc/data"
svc_files_path = "/hab/svc/glibc/files"
svc_path = "/hab/svc/glibc"
svc_static_path = "/hab/svc/glibc/static"
svc_var_path = "/hab/svc/glibc/var"
version = "2.22"
```

### Supervisor
* `svc.gossip_ip` - IP the supervisor uses for the gossip ring
* `svc.gossip_port` - Port the supervisor uses for the gossip ring
* `svc.hostname` - System's hostname 
* `svc.ip` - System's IP address
* `svc.sidecar_ip` - IP to bind to for the http endpoints
* `svc.sidecar_port` - Port to bind to for the http endpoints
* `svc.group` - group name (from `--group`)
* `svc.service` - the service name (same as package name)
* `svc.ident` - SERVICE_NAME.GROUP_NAME

### Service groups (topology info)
* svc.all - an array of running services (each service has same fields listed above as well as what's below for each service)

Information on services follows a pattern but is listed under identifiers for the service and member.  Each service will have a way to identify the service and information on each member in the format of:
```
SERVICE.MEMBER.KEY
```
Where SERVICE can be:
 - A member of the `svc.all` array
 - The ring itself as a bare `svc`
 - A named service in the format of `svc.named.$SERVICE_NAME.$SERVICE_GROUP`

MEMBER can be:
 - `.members` - An array of server information containing every member
 - `.leader` - service information on the service leader
 - `.me` - service information on the local supervisor
 - `.member_id.$ID` - service information on the service member with id of `$ID`

and KEY is one of:
 - `.alive`: Boolean -  Is the member currently alive?
 - `.confirmed`: Boolean - Is the member confirmed dead?
 - `.data_init`: Boolean -
 - `.detached`: Boolean -
 - `.exposes`: Array of strings - What ports does are exposed
 - `.follower`: Boolean - Anything not a leader
 - `.group`: String - Service group name
 - `.hostname`: String - System's hostname
 - `.id`: String -
 - `.initialized`: Boolean -
 - `.ip`: String - IP address of the supervisor
 - `.keep_me`: Boolean -
 - `.leader`: Boolean - Is this member the leader?
 - `.member_id`: String - Member id in the service group
 - `.port`: String - 
 - `.service`: String - Service name (probably the package name)
 - `.suitability`: Integer -
 - `.suspect`: Boolean -
 - `.incarnation.counter`: Integer -

For example:
```
members = {}

{{~#if svc.me.follower}}
  {{~#each svc.members}}
members['{{hostname}}'] = {
  'ip' = '{{ip}}',
  'port' = '{{port}}'
}
  {{~/each}}
{{~/if}}
```

would render:
```
members= {}

members['node1.example.com'] = {
  'ip' = '1.2.3.4',
  'port' = '56'
}

members['node2.example.com'] = {
  'ip' = '1.2.3.5',
  'port' = '56'
}
```

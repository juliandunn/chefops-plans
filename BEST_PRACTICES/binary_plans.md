# Binary Plans

*Binary Plans* are those which produce packages that are not compiled from source.  

An example of such a plan is included in this repository (hello_world), which installs a simple shell 
script which will simply print "Hello!" in a loop.  


## The "Install-Only" Plan

The following is an example plan which skips all phases except installation.  Notice that the _download_, _verify_, _unpack_,
and _build_ phases return zero to effectively skip them.  During the _install_ phase we can go about the business
of installing our file.  Note that you can reference the plans directory using $PLAN_CONTEXT (this is commonly used for applying
patches which are bundled with the plan).

```
pkg_name=hello_world
pkg_origin=chefops
pkg_version=0.0.1
pkg_maintainer="Ben Rockwood <benr@chef.io>"
pkg_license=('Revised BSD')
pkg_deps=()
pkg_build_deps=()

pkg_service_run="bin/hello_world"

do_download() {
  return 0
}

do_verify() {
  return 0
}

do_unpack() {
  return 0
}

do_build() {
  return 0
}

do_install() {
  mkdir -p $pkg_prefix/bin
  cp $PLAN_CONTEXT/bin/hello_world $pkg_prefix/bin/hello_world
  chmod +x $pkg_prefix/bin/hello_world
}
```

In the real world, you likely will download something for your plan; therefore work your way backwards from
this example towards that of a normal plan to handle download and unpack.

## Docker Containers w/o Configuration

As of 4/30/16, Dockerized services **must*** possess a configuration, even if its empty, or the following
error will be seen during container startup:

```
benr@magnolia:~$ docker run -it chefops/hello_world 
hab-sup(MN): Starting chefops/hello_world
hab-sup(GS): Supervisor 172.17.0.2: cdf8e4b8-a20d-402f-9ec0-d94322b14765
hab-sup(GS): Census hello_world.default: 24e5ff4c-84a8-4375-a44e-e53877f88e67
hab-sup(GS): Starting inbound gossip listener
hab-sup(GS): Starting outbound gossip distributor
hab-sup(GS): Starting gossip failure detector
hab-sup(CN): Starting census health adjuster
hab-sup(ER)[src/error.rs:303:8]: No such file or directory (os error 2)
benr@magnolia:~$
```

The error above (line 303 of hab-sup/src/error.rs)  indicates that the files required to apply the Mustache
template aren't found.  

This is solved by creating an empty **default.toml** and some empty config file, such as **config/xxx***.  These 
won't do anything, but will appease the supervisor.

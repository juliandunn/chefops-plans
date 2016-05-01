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

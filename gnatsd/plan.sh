pkg_name=gnatsd
pkg_origin=chefops
pkg_version=0.7.2
pkg_maintainer="Ben Rockwood <benr@chef.io>"
pkg_license=('MIT')

pkg_source="https://github.com/nats-io/gnatsd/releases/download/v0.7.2/gnatsd-v0.7.2-linux-amd64.tar.gz"
pkg_shasum=62bbf8ddeb54d162e815805cfb99f184abd0c98eca05519ea1aaa4affe878cdf
pkg_filename="${pkg_name}-v${pkg_version}-linux-amd64.tar.gz"

pkg_deps=(core/glibc)
pkg_bin_dirs=(sbin)

pkg_service_run="sbin/gnatsd"
pkg_expose=(4222)


do_build() {
  return 0
}

do_strip() {
  return 0
}

do_install() {
  mkdir -p $pkg_prefix/sbin
  cp $HAB_CACHE_SRC_PATH/gnatsd $pkg_prefix/sbin
}

pkg_name=influxdb
pkg_origin=chefops
pkg_version=0.12.2-1
pkg_maintainer="Ben Rockwood <benr@chef.io>"
pkg_license=('MIT')
pkg_source=https://dl.influxdata.com/${pkg_name}/releases/${pkg_name}-${pkg_version}_linux_amd64.tar.gz
pkg_shasum=d50b09b95cb83a5515843accc13e27712eaf4f99d50d4fcb7abcced0de87e4cf
pkg_deps=(core/glibc)
pkg_svc_user="root"

pkg_expose=(8083 8086)

do_build() {
  return 0
}

do_strip() {
  return 0
}

do_install() {
  mkdir -p $pkg_prefix/sbin
  cp $HAB_CACHE_SRC_PATH/usr/bin/influxd $pkg_prefix/sbin/
}


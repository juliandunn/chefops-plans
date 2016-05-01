pkg_name=statsd
pkg_version=0.7.2
pkg_origin=chefops
pkg_license=('MIT')
pkg_maintainer="Ben Rockwood <benr@chef.io>"
pkg_source=https://github.com/etsy/statsd/archive/v${pkg_version}.tar.gz
pkg_shasum=0d0d6b7596fe68ef7da0984e32ca988c21985bdab825d33043cede2d7b9076f2
pkg_filename=${pkg_name}-${pkg_version}.tar.gz
pkg_deps=(core/node)
pkg_build_deps=()
pkg_expose=(8125)


## See https://github.com/etsy/statsd

do_build() {
  return 0
}

do_install() {
  # Just copy the contents from the HAB_CACHE_SRC_APATH into the package 
  mkdir -p $pkg_prefix/src
  cp -r * $pkg_prefix/src
}

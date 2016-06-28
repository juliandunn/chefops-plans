pkg_name=gogs
pkg_origin=chefops
pkg_version=0.9.13
pkg_maintainer="Ben Rockwood <benr@chef.io>"
pkg_license=('MIT')

pkg_source="https://github.com/gogits/gogs/archive/v0.9.13.tar.gz"
pkg_shasum=
pkg_filename="${pkg_name}_v${pkg_version}_linux_amd64.tar.gz"

pkg_deps=(core/glibc core/go)
pkg_build_deps=(core/glibc core/go)
pkg_bin_dirs=(gogs)

pkg_svc_run="gogs/gogs"
pkg_expose=(3000)

GOPATH=/hab/cache/src/go

do_build() {
    
  return 0
}

do_strip() {
  return 0
}

do_install() {
  mv /hab/cache/src/gogs $pkg_prefix/
}

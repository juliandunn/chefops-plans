pkg_name=consul
pkg_origin=chefops
pkg_version=0.6.4
pkg_maintainer="Chef Operations <ops@chef.io>"
pkg_license=('MIT')
pkg_source=https://releases.hashicorp.com/consul/${pkg_version}/${pkg_name}_${pkg_version}_linux_amd64.zip
pkg_shasum=abdf0e1856292468e2c9971420d73b805e93888e006c76324ae39416edcf0627
pkg_deps=(core/cacerts)

pkg_expose=(8500)

do_build() {
  return 0
}

do_strip() {
  return 0
}

do_install() {
  mkdir -p "$pkg_prefix/bin"
  cp /hab/cache/src/consul "$pkg_prefix/bin/"
}

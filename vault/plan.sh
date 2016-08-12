pkg_name=vault
pkg_origin=chefops
pkg_version=0.6.0
pkg_maintainer="Ben Rockwood <benr@chef.io>"
pkg_license=('MIT')
pkg_source=https://releases.hashicorp.com/vault/${pkg_version}/${pkg_name}_${pkg_version}_linux_amd64.zip
pkg_shasum=283b4f591da8a4bf92067bf9ff5b70249f20705cc963bea96ecaf032911f27c2

pkg_expose=(8200)

do_build() {
  return 0
}

do_strip() {
  return 0
}

do_install() {
  mkdir -p $pkg_prefix/bin
  cp /hab/cache/src/vault $pkg_prefix/bin/
}


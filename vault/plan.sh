pkg_name=vault
pkg_origin=chefops
pkg_version=0.5.3
pkg_maintainer="Ben Rockwood <benr@chef.io>"
pkg_license=('MIT')
pkg_source=https://releases.hashicorp.com/vault/${pkg_version}/${pkg_name}_${pkg_version}_linux_amd64.zip
pkg_shasum=fddb97507f8b539534620882f3a46984160778950e4884831c0f7c2a82b65f52

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


pkg_name=nomad
pkg_origin=chefops
pkg_version=0.4.0
pkg_maintainer="Paul Mooring <paul@chef.io>"
pkg_license=('MIT')
pkg_source=https://releases.hashicorp.com/nomad/${pkg_version}/${pkg_name}_${pkg_version}_linux_amd64.zip
pkg_shasum=c0479dcc03d35c1b0f6e7be256732431384bec16901a124dd97b2a60d465fb91

pkg_expose=(4646 4647 4648)
pkg_svc_run="bin/nomad agent -config=$pkg_svc_config_path/nomad.hcl 2>&1"

do_build() {
  return 0
}

do_strip() {
  return 0
}

do_install() {
  mkdir -p $pkg_prefix/bin
  cp /hab/cache/src/nomad $pkg_prefix/bin/
}


pkg_name=etcd
pkg_origin=chefops
pkg_version=2.3.6
pkg_maintainer="Ben Rockwood <benr@chef.io>"
pkg_license=('MIT')

pkg_source="https://github.com/coreos/etcd/releases/download/v2.3.6/etcd-v2.3.6-linux-amd64.tar.gz"
pkg_shasum=9264a2e8580bd5f1f5691d4468d97fc8e2952867fbfdd79f92ecc688f29362bd
pkg_filename="${pkg_name}-v${pkg_version}-linux-amd64.tar.gz"
pkg_dirname="${pkg_name}-v${pkg_version}-linux-amd64"

##pkg_deps=(core/glibc)
pkg_bin_dirs=(sbin)

pkg_svc_run="sbin/etcd --data-dir $pkg_svc_data_path"


# Expose Ports:
# port 2379, 4001 for client communication 
# port 2380, 2380 for server-to-server communication
pkg_expose=(2379 2380 4001 7001)


do_build() {
  return 0
}

do_strip() {
  return 0
}

do_install() {
  mkdir -p $pkg_prefix/sbin
  cp etcd* $pkg_prefix/sbin
}

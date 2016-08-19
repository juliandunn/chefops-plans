pkg_name=mongodb
pkg_origin=chefops
pkg_version=3.2.9
pkg_maintainer="Ben Rockwood <benr@chef.io>"
pkg_description="High-performance, schema-free, document-oriented database"
pkg_license=('AGPL-3.0')
pkg_shasum=25f8817762b784ce870edbeaef14141c7561eb6d7c14cd3197370c2f9790061b
pkg_deps=(core/glibc core/gcc-libs)
pkg_build_deps=(core/gcc core/scons core/python2)
pkg_expose=(27017 28017)
pkg_bin_dirs=(bin)
# This plan uses hooks.

do_build() {
  #LD_LIBRARY_PATH=$(pkg_path_for core/gcc-libs)/lib
  scons all
}

do_strip() {
  return 0
}

do_install() {
  mkdir -p $pkg_prefix/bin
  cp bin/* $pkg_prefix/bin/

  for i in mongo mongos mongod ; do
    build_line "Setting interpreter for '${pkg_prefix}/bin/${i}' '$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2'"
    build_line "Setting rpath for '${pkg_prefix}/bin/${i}' to '$LD_RUN_PATH'"
    patchelf --set-interpreter "$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2" \
             --set-rpath ${LD_RUN_PATH} \
             ${pkg_prefix}/bin/${i}
  done
}

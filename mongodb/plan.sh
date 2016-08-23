pkg_name=mongodb
pkg_origin=chefops
pkg_version=3.2.9
pkg_maintainer="Ben Rockwood <benr@chef.io>"
pkg_description="High-performance, schema-free, document-oriented database"
pkg_license=('AGPL-3.0')
pkg_source=https://fastdl.mongodb.org/src/mongodb-src-r${pkg_version}.tar.gz
pkg_shasum=25f8817762b784ce870edbeaef14141c7561eb6d7c14cd3197370c2f9790061b
pkg_deps=(core/gcc-libs core/glibc)
pkg_build_deps=(
  core/coreutils
  core/gcc
  core/patchelf
  core/python2
  core/scons
)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_dirname=${pkg_name}-r${pkg_version}

do_prepare() {
  if [[ ! -r /usr/bin/basename ]]; then
    ln -sv "$(pkg_path_for coreutils)/bin/basename" /usr/bin/basename
    _clean_basename=true
  fi

  if [[ ! -r /usr/bin/tr ]]; then
    ln -sv "$(pkg_path_for coreutils)/bin/tr" /usr/bin/tr
    _clean_tr=true
  fi
}

do_unpack() {
  # Because mongodb would normally unpack into mongodb-r3.2.9 and
  # we expect the pattern mongodb-3.2.9
  mkdir -p $pkg_dirname
  tar -xzf "$pkg_filename" -C $pkg_dirname --strip-components=1
  sed -i'' -e "s#chmod 755#$(pkg_path_for coreutils)/bin/chmod 755#" $pkg_dirname/src/mongo/SConscript
}

do_build() {
  CC="$(pkg_path_for gcc)/bin/gcc"
  CXX="$(pkg_path_for gcc)/bin/g++"
  scons --prefix="$pkg_prefix" CXX="$CXX" CC="$CC" LINKFLAGS="$LDFLAGS" --release core
  # XXXX Fix whatever scons is expecting for LD_RUN_PATH/LD_LIBRARY_PATH instead of patchelfing
}

do_check() {
  CC="$(pkg_path_for gcc)/bin/gcc"
  CXX="$(pkg_path_for gcc)/bin/g++"
  scons --prefix="$pkg_prefix" CXX="$CXX" CC="$CC" LINKFLAGS="$LDFLAGS" --release dbtest
  python buildscripts/resmoke.py --suites=dbtest
}

do_install() {
  CC="$(pkg_path_for gcc)/bin/gcc"
  CXX="$(pkg_path_for gcc)/bin/g++"
  scons --prefix="$pkg_prefix" CXX="$CXX" CC="$CC" LINKFLAGS="$LDFLAGS" install
}

do_end() {
  if [[ -n "$_clean_basename" ]]; then
    rm -fv /usr/bin/basename
  fi

  if [[ -n "$_clean_tr" ]]; then
    rm -fv /usr/bin/tr
  fi
}

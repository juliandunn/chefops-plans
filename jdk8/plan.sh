pkg_name=jdk8
pkg_origin=chefops
pkg_version=8u91
pkg_maintainer="Ben Rockwood <benr@chef.io>"
pkg_license=('http://www.oracle.com/technetwork/java/javase/terms/license/index.html')
pkg_source=http://download.oracle.com/otn-pub/java/jdk/8u91-b14/jdk-8u91-linux-x64.tar.gz
pkg_filename=jdk-8u91-linux-x64.tar.gz
pkg_shasum=6f9b516addfc22907787896517e400a62f35e0de4a7b4d864b26b61dbe1b7552
#pkg_deps=(core/glibc core/openssl core/zlib core/pcre)
#pkg_build_deps=(core/gcc core/make core/coreutils)
#pkg_lib_dirs=(lib)
#pkg_include_dirs=(include)


## Refer to habitat/components/plan-build/bin/hab-plan-build.sh

# Customomized download_file() to work around the Oracle EULA Cookie-wall 
#  See: http://stackoverflow.com/questions/10268583/downloading-java-jdk-on-linux-via-wget-is-shown-license-page-instead
download_file() {
  local url="$1"
  local dst="$2"
  local sha="$3"

  pushd $HAB_CACHE_SRC_PATH > /dev/null
  if [[ -f $dst && -n "$sha" ]]; then
    build_line "Found previous file '$dst', attempting to re-use"
    if verify_file $dst $sha; then
      build_line "Using cached and verified '$dst'"
      return 0
    else
      build_line "Clearing previous '$dst' file and re-attempting download"
      rm -fv $dst
    fi
  fi

  build_line "Downloading '$url' to '$dst'"
  $_wget_cmd --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie"  $url -O $dst
  build_line "Downloaded '$dst'";
  popd > /dev/null
}

do_unpack() {
  ### mv jdk1.8.0_91

}

do_build() {
  return 0
}

do_install() {
  cd $pkg_dirname 
  rm *			## Remove all the files from the JDK root
  rm -r man
  cp -r * $pkg_prefix
}




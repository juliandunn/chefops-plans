pkg_name=lighttpd
pkg_origin=cuddletech
pkg_version=1.4.39
pkg_maintainer="Ben Rockwood <benr@chef.io>"
pkg_license=('Revised BSD')
pkg_source=http://download.lighttpd.net/lighttpd/releases-1.4.x/${pkg_name}-${pkg_version}.tar.gz
pkg_filename=${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=bc5f910f78b8cbae3e8fe1a1d8558259f09dbe50dd3907db771404bfab27bb2e		# SHA256
pkg_gpg_key=3853DA6B
pkg_deps=(core/glibc core/openssl core/zlib core/pcre)
pkg_build_deps=(core/gcc core/make core/coreutils)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_service_user="root"

pkg_expose=(80)
pkg_service_run="sbin/lighttpd -Df $pkg_svc_config_path/lighttpd.conf"

do_build() {
  ./configure --prefix=${pkg_prefix} \
    --disable-ipv6 \
    --with-openssl=$(pkg_path_for core/openssl) \
    --without-bzip2 \
    --with-zlib 

  make
}



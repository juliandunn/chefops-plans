pkg_name=nano
pkg_origin=chefops
pkg_version=2.6.0
pkg_maintainer="Ben Rockwood <benr@chef.io>"
pkg_license=('Revised BSD')
pkg_source=https://www.nano-editor.org/dist/v2.6/nano-2.6.0.tar.gz
pkg_filename=${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=d517a5fcaa9fa6ceda8a63e22be1d83dd7f4af13703c73b10a48e95a6e1178d3
pkg_deps=(core/glibc core/ncurses)
pkg_build_deps=(core/gcc core/make core/coreutils core/ncurses)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)


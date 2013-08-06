# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-base/libobjc2/libobjc2-1.6.1.ebuild,v 1.1 2012/07/25 12:11:23 voyageur Exp $

EAPI=5
inherit subversion cmake-multilib flag-o-matic

DESCRIPTION="GNUstep Objective-C runtime"
HOMEPAGE="http://www.gnustep.org"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm"
IUSE="-boehm-gc debug"

RDEPEND="boehm-gc? ( dev-libs/boehm-gc )"
DEPEND="${RDEPEND}
	>=sys-devel/clang-2.9
	=gnustep-base/gnustep-make-9999
	dev-libs/libdispatch[${MULTILIB_USEDEP}]"

ESVN_REPO_URI="svn://svn.gna.org/svn/gnustep/libs/libobjc2/trunk"
ESVN_PROJECT="libobjc2"


src_configure() {
	export CC=clang
	export CXX=clang++

	local gb
	use boehm-gc \
		&& gb="-DBOEHM_GC=TRUE" \
		|| gb="-DBOEHM_GC=FALSE"

	mycmakeargs="-DGNUSTEP_INSTALL_TYPE=NONE -DTESTS=FALSE ${gb}"
	cmake-multilib_src_configure
}

src_compile() {
	cmake-multilib_src_compile
}

src_install() {
	cmake-multilib_src_install

	#dosym libobjc.so.4.6 "/usr/$(get_libdir)/libobjc.so.4"
	#dosym libobjc.so.4.6 "/usr/$(get_libdir)/libobjc.so.4.6.0"

	#if use abi_x86; then
	#	ABI=x86
	#	dosym libobjc.so.4.6 "/usr/$(get_libdir)/libobjc.so.4"
	#	dosym libobjc.so.4.6 "/usr/$(get_libdir)/libobjc.so.4.6.0"
	#fi
}

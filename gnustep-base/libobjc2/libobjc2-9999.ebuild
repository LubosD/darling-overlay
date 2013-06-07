# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-base/libobjc2/libobjc2-1.6.1.ebuild,v 1.1 2012/07/25 12:11:23 voyageur Exp $

EAPI=4
inherit multilib subversion cmake-utils

DESCRIPTION="GNUstep Objective-C runtime"
HOMEPAGE="http://www.gnustep.org"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm"
IUSE="-boehm-gc"

RDEPEND="boehm-gc? ( dev-libs/boehm-gc )"
DEPEND="${DEPEND}
	>=sys-devel/clang-2.9
	dev-util/cmake
	=gnustep-base/gnustep-make-9999"

ESVN_REPO_URI="svn://svn.gna.org/svn/gnustep/libs/libobjc2/trunk"
ESVN_PROJECT="libobjc2"

src_unpack() {
	subversion_src_unpack
}

src_configure() {
	CC=clang
	CXX=clang++
	
	local gb
	use boehm-gc \
		&& gb="-DBOEHM_GC=TRUE" \
		|| gb="-DBOEHM_GC=FALSE"
	
	mycmakeargs="-DGNUSTEP_INSTALL_TYPE=SYSTEM -DTESTS=FALSE ${gb}"
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_make
}

src_install() {

	cmake-utils_src_install
}

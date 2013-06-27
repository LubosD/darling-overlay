# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-2 cmake-multilib

DESCRIPTION="Linux port of Apple's open-source concurrency library"
HOMEPAGE="http://nickhutchinson.me/libdispatch"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

EGIT_REPO_URI="https://github.com/nickhutchinson/libdispatch.git"

DEPEND=">=sys-devel/clang-2.9"
RDEPEND="${DEPEND}
	dev-libs/libpthread_workqueue[${MULTILIB_USEDEP}]
	dev-libs/libkqueue[${MULTILIB_USEDEP}]"

src_unpack() {
	git-2_src_unpack
	
	sed -i 's/DESTINATION lib/DESTINATION ${CMAKE_INSTALL_LIBDIR}/' "${PF}/src/CMakeLists.txt"
}

src_prepare() {
	epatch "${FILESDIR}/gnustep-blocks.patch"
}

src_configure() {
	export CC=clang
	export CXX=clang++
	
	append-flags -fblocks
	cmake-multilib_src_configure
}



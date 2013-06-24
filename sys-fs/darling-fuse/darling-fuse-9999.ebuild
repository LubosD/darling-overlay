# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-2 cmake-utils

DESCRIPTION="Readonly access to .dmg files with HFS+ filesystem via FUSE"
HOMEPAGE="http://darling.dolezel.info"
SRC_URI=""

EGIT_REPO_URI="https://github.com/LubosD/darling-dmg.git"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=sys-devel/clang-3.1
	sys-fs/fuse
	sys-libs/zlib
	app-arch/bzip2
	dev-libs/openssl
	dev-libs/libxml2
	dev-libs/icu"
RDEPEND="${DEPEND}"

src_unpack() {
	git-2_src_unpack
}

src_configure() {
	export CC=clang
	export CXX=clang++

	cmake-utils_src_configure
}


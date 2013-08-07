# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# Exp $

EAPI=5
inherit eutils gnustep-base git-2

DESCRIPTION="a vector drawing library with an API similar to Quartz 2D"
HOMEPAGE="http://www.gnustep.org"
SRC_URI=""

EGIT_REPO_URI="https://github.com/gnustep/gnustep-opal.git"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="${GNUSTEP_CORE_DEPEND}"

DEPEND="${RDEPEND}
	virtual/pkgconfig
	>=sys-devel/clang-2.9
	x11-libs/cairo
	virtual/jpeg
	media-libs/libpng
	media-libs/tiff
	media-libs/lcms:0
	media-libs/freetype
	media-libs/fontconfig
"

src_prepare() {
	sed -i -e 's/Tests//' GNUmakefile
}

src_configure() {
	egnustep_env

	export CC=clang
	export CXX=clang++
}

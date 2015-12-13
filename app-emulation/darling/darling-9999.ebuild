# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3 cmake-utils

DESCRIPTION="Darling is a Wine-like emulation layer that enables you to run OS X apps on Linux"
HOMEPAGE="http://darling.dolezel.info"
SRC_URI=""

EGIT_REPO_URI="https://github.com/LubosD/darling.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	>=sys-devel/clang-3.2
	virtual/udev
	gnustep-base/gnustep-base
	gnustep-base/gnustep-corebase
	gnustep-base/gnustep-gui
"
RDEPEND="
	virtual/udev
	gnustep-base/gnustep-base
	gnustep-base/gnustep-corebase
	gnustep-base/gnustep-gui
	dev-libs/libkqueue
	dev-libs/libdispatch
	dev-libs/openssl
	>=dev-libs/libbsd-0.5.2
	media-video/libav
"

src_configure() {
	local mycmakeargs=();
	export CC=clang
	export CXX=clang++

	# TODO: multilib
	if use amd64; then
		local mycmakeargs+=( "-DSUFFIX=64" )
	fi

	cmake-utils_src_configure
}


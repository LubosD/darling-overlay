# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-multilib

DESCRIPTION="Portable implementation of the kqueue() and kevent() system calls"
HOMEPAGE="http://sourceforge.net/projects/libkqueue/"
SRC_URI="mirror://sourceforge/libkqueue/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_unpack() {
	unpack "${A}"
	cd "${S}"
	
	sed 's,${includedir},/usr,' < libkqueue.pc.in > libkqueue.pc
	cp "${FILESDIR}/CMakeLists.txt" .
	
	cat << EOF > include/config.h
	
	#define HAVE_DECL_EPOLLRDHUP 1
	#define HAVE_DECL_PPOLL 1
	#define HAVE_SYS_EPOLL_H 1
	/* #undef  HAVE_SYS_EVENT_H */
	#define HAVE_SYS_EVENTFD_H 1
	#define HAVE_SYS_INOTIFY_H 1
	#define HAVE_SYS_SIGNALFD_H 1
	#define HAVE_SYS_TIMERFD_H 1
EOF
}

src_configure() {
	cmake-multilib_src_configure
}

src_compile() {
	cmake-multilib_src_compile
}

src_install() {
	cmake-multilib_src_install
}

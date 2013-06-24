# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="libpthread_workqueue is a portable implementation of the pthread_workqueue API first introduced in Mac OS X."
HOMEPAGE="http://sourceforge.net/projects/libpwq/"
SRC_URI="mirror://sourceforge/libpwq/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_configure() {
	econf
	
	sed -i '/CFLAGS/s|$| -D_XOPEN_SOURCE=600 -D__EXTENSIONS__ -D_GNU_SOURCE -std=c99 -I./include -I./src/|' config.mk
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc ChangeLog
}


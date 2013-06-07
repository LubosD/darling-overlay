# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-base/libobjc2/libobjc2-1.6.1.ebuild,v 1.1 2012/07/25 12:11:23 voyageur Exp $

EAPI=4
inherit multilib subversion cmake-utils flag-o-matic

DESCRIPTION="GNUstep Objective-C runtime"
HOMEPAGE="http://www.gnustep.org"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm"
IUSE="-boehm-gc multilib debug"

RDEPEND="boehm-gc? ( dev-libs/boehm-gc )"
DEPEND="${RDEPEND}
	>=sys-devel/clang-2.9
	=gnustep-base/gnustep-make-9999"

ESVN_REPO_URI="svn://svn.gna.org/svn/gnustep/libs/libobjc2/trunk"
ESVN_PROJECT="libobjc2"

src_unpack() {
	subversion_src_unpack
}

src_configure() {
	
	local gb
	use boehm-gc \
		&& gb="-DBOEHM_GC=TRUE" \
		|| gb="-DBOEHM_GC=FALSE"

	if use multilib; then
	
		# Build the 32-bit version
	
		mkdir -p "${WORKDIR}/${PF}_build32"
		cd "${WORKDIR}/${PF}_build32"
		
		ASMFLAGS=-m32 CXXFLAGS="${CXXFLAGS} -m32" CFLAGS="${CFLAGS} -m32" CC=clang CXX=clang++ \
			cmake ../${PF} -DGNUSTEP_INSTALL_TYPE=NONE -DLIB_INSTALL_PATH=/usr/lib32 -DTESTS=FALSE ${gb}
		
		# Build the 64-bit version
		
		mkdir -p "${WORKDIR}/${PF}_build64"
		cd "${WORKDIR}/${PF}_build64"
		
		CC=clang CXX=clang++ \
			cmake ../${PF} -DGNUSTEP_INSTALL_TYPE=SYSTEM -DTESTS=FALSE ${gb}
		
	else
		mycmakeargs="-DGNUSTEP_INSTALL_TYPE=SYSTEM -DTESTS=FALSE ${gb}"
		cmake-utils_src_configure
	fi
}

src_compile() {
	if use multilib; then
		cd "${WORKDIR}"/${PF}_build64
		emake VERBOSE=1
		cd "${WORKDIR}"/${PF}_build32
		emake VERBOSE=1
	else
		cmake-utils_src_make
	fi
}

src_install() {
	if use multilib; then
		ABI=amd64
		cd "${WORKDIR}"/${PF}_build64
		emake DESTDIR="${D}" install
		ABI=x86
		cd "${WORKDIR}"/${PF}_build32
		emake DESTDIR="${D}" install
		ABI=amd64
	else
		cmake-utils_src_install
	fi
	
	dosym libobjc.so.4.6 "/usr/$(get_libdir)/libobjc.so.4"
	dosym libobjc.so.4.6 "/usr/$(get_libdir)/libobjc.so.4.6.0"
	
	if use multilib; then
		ABI=x86
		dosym libobjc.so.4.6 "/usr/$(get_libdir)/libobjc.so.4"
		dosym libobjc.so.4.6 "/usr/$(get_libdir)/libobjc.so.4.6.0"
	fi
}

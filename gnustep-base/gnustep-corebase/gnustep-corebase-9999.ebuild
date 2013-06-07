# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-base/libobjc2/libobjc2-1.6.1.ebuild,v 1.1 2012/07/25 12:11:23 voyageur Exp $

EAPI=4
inherit multilib subversion

DESCRIPTION="GNUstep CoreBase framework"
HOMEPAGE="http://www.gnustep.org"
SRC_URI=""

ESVN_REPO_URI="svn://svn.gna.org/svn/gnustep/libs/corebase/trunk"
ESVN_PROJECT="corebase"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm"
IUSE="multilib debug"

RDEPEND="=gnustep-base/gnustep-base-9999"
DEPEND="${RDEPEND}
	>=sys-devel/clang-2.9
	=gnustep-base/gnustep-make-9999"

src_unpack() {
	subversion_src_unpack
}

src_configure() {
	export CC=clang
	export CXX=clang++
	
	if use multilib; then
		cp -a "${WORKDIR}/${PF}" "${WORKDIR}/${PF}-32"
		pushd "${WORKDIR}/${PF}-32"
		
		econf $(use_enable debug)
		
		makefile_path="${WORKDIR}/${PF}-32/Source/GNUmakefile"
		sed -i '/ADDITIONAL_CFLAGS/s|$| -m32|' "$makefile_path"
		sed -i '/ADDITIONAL_CXXFLAGS/s|$| -m32|' "$makefile_path"
		sed -i '/ADDITIONAL_OBJCFLAGS/s|$| -m32|' "$makefile_path"
		sed -i '/libgnustep-corebase_LIBRARIES_DEPEND_UPON/s|$| -m32|' "$makefile_path"
		
		popd
	fi
	
	econf $(use_enable debug)
}

src_compile() {
	if use multilib; then
		cd "${WORKDIR}/${PF}-32"
		
		emake

		cd "${WORKDIR}/${PF}"
		emake
	else
		emake
	fi
}

src_install() {

	if use multilib; then
		pushd "${WORKDIR}/${PF}-32"
		
		ABI=x86
		
		insinto /usr/lib32
		dolib Source/obj/libgnustep-corebase.so*
		
		ABI=amd64
		
		popd
	fi
	
	emake DESTDIR="${D}" GNUSTEP_INSTALLATION_DOMAIN=SYSTEM install
	
	dodoc README ChangeLog
}

# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGO_PN="github.com/google/syzkaller"

inherit golang-vcs-snapshot
DESCRIPTION="Syzkaller is an unsupervised coverage-guided kernel fuzzer."
HOMEPAGE="https://github.com/google/syzkaller"
SRC_URI="https://github.com/hodgesds/syzkaller/archive/v${PV}.tar.gz"

LICENSE="Apache License 2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="app-emulation/qemu >=dev-lang/go-1.8.0"
RDEPEND="${DEPEND}"

DOCS=(
README.md
)

src_compile() {
	cd src/${EGO_PN}
	sed -i "/REV=\$*/c\	REV:=${PV}" Makefile
	# skip git checks
	sed -i "s/shell\sgit\sdiff\s--shortstat//g" Makefile
	sed -i "s/shell\sgit\sdiff\s--name-only//g" Makefile
	GOPATH="${WORKDIR}/${P}:$(get_golibdir_gopath)"	make
}

src_install() {
    dobin src/${EGO_PN}/bin/syz-db
    dobin src/${EGO_PN}/bin/syz-manager
    dobin src/${EGO_PN}/bin/syz-mutate
    dobin src/${EGO_PN}/bin/syz-prog2c
    dobin src/${EGO_PN}/bin/syz-repro
    dobin src/${EGO_PN}/bin/syz-runtest
    dobin src/${EGO_PN}/bin/syz-upgrade
    dobin src/${EGO_PN}/bin/linux_amd64/syz-executor
}

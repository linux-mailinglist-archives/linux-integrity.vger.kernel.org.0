Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D77F2243ED1
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Aug 2020 20:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgHMSZo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Aug 2020 14:25:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:54198 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbgHMSZn (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Aug 2020 14:25:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C7889AEB6;
        Thu, 13 Aug 2020 18:26:03 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        "Bruno E . O . Meneguele" <bmeneg@redhat.com>
Subject: [PATCH ima-evm-utils 9/9] travis: Switch to docker based builds
Date:   Thu, 13 Aug 2020 20:25:32 +0200
Message-Id: <20200813182532.6931-10-pvorel@suse.cz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200813182532.6931-1-pvorel@suse.cz>
References: <20200813182532.6931-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This requires to have distro specific install scripts and build.sh
script.

For now ibmswtpm2 is compiled just for native builds (depends on gcc,
compiled natively). libtmps/swtpm could be used.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .travis.yml                    | 106 +++++++++++++++++++++++----------
 build.sh                       |  97 ++++++++++++++++++++++++++++++
 travis/alpine.sh               |  50 ++++++++++++++++
 travis/centos.sh               |   1 +
 travis/debian.cross-compile.sh |  23 +++++++
 travis/debian.i386.sh          |  11 ++++
 travis/debian.sh               |  54 +++++++++++++++++
 travis/fedora.sh               |  49 +++++++++++++++
 travis/opensuse.sh             |   1 +
 travis/tumbleweed.sh           |  45 ++++++++++++++
 travis/ubuntu.sh               |   1 +
 11 files changed, 405 insertions(+), 33 deletions(-)
 create mode 100755 build.sh
 create mode 100755 travis/alpine.sh
 create mode 120000 travis/centos.sh
 create mode 100755 travis/debian.cross-compile.sh
 create mode 100755 travis/debian.i386.sh
 create mode 100755 travis/debian.sh
 create mode 100755 travis/fedora.sh
 create mode 120000 travis/opensuse.sh
 create mode 100755 travis/tumbleweed.sh
 create mode 120000 travis/ubuntu.sh

diff --git a/.travis.yml b/.travis.yml
index cdfba49..849fcb6 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -1,38 +1,78 @@
 dist: bionic
 language: C
-addons:
- apt:
-  packages:
-   - libkeyutils-dev
-   - libattr1-dev
-   - attr
-   - openssl
-   - libssl-dev
-   - asciidoc
-   - xsltproc
-   - docbook-xsl
-   - docbook-xml
+services:
+    - docker
+
 matrix:
-   include:
-     - env: TSS=ibmtss
-     - env: TSS=tpm2-tss
-install:
-   - if [ "${TSS}" = "tpm2-tss" ]; then
-           sudo apt-get install lcov pandoc autoconf-archive liburiparser-dev;
-           sudo apt-get install libdbus-1-dev libglib2.0-dev dbus-x11 libgcrypt-dev;
-           sudo apt-get install libssl-dev doxygen libjson-c-dev;
-           sudo apt-get install libini-config-dev libltdl-dev;
-           sudo apt-get install uuid-dev libcurl4-openssl-dev;
-          ./tests/install-tpm2-tss.sh;
-     fi
-   - ./tests/install-swtpm.sh
-   - ./tests/install-tss.sh
+    include:
+        # 32 bit build
+        - os: linux
+          env: DISTRO=debian:stable VARIANT=i386 ARCH=i386 TSS=tpm2-tss
+          compiler: gcc
 
-script:
-   - export LD_LIBRARY_PATH=/usr/local/lib64:/usr/local/lib;
-   - export PATH=$PATH:/usr/local/bin;
-   - autoreconf -i && ./configure && make -j$(nproc) && sudo make install && VERBOSE=1 make check;
+        # cross compilation builds
+        - os: linux
+          env: DISTRO=debian:stable VARIANT=cross-compile ARCH=ppc64el TSS=ibmtss
+          compiler: powerpc64le-linux-gnu-gcc
+
+        - os: linux
+          env: DISTRO=debian:stable VARIANT=cross-compile ARCH=arm64 TSS=tpm2-tss
+          compiler: aarch64-linux-gnu-gcc
+
+        - os: linux
+          env: DISTRO=debian:stable VARIANT=cross-compile ARCH=s390x TSS=ibmtss
+          compiler: s390x-linux-gnu-gcc
+
+        # musl
+        - os: linux
+          env: DISTRO=alpine:latest TSS=tpm2-tss
+          compiler: gcc
+
+        # glibc (gcc/clang)
+        - os: linux
+          env: DISTRO=opensuse/tumbleweed TSS=ibmtss
+          compiler: clang
+
+        - os: linux
+          env: DISTRO=opensuse/leap TSS=tpm2-tss
+          compiler: gcc
+
+        - os: linux
+          env: DISTRO=ubuntu:eoan TSS=ibmtss
+          compiler: gcc
 
-   - tail -3 tests/ima_hash.log;
-   - tail -3 tests/sign_verify.log;
-   - tail -20 tests/boot_aggregate.log;
+        - os: linux
+          env: DISTRO=ubuntu:xenial TSS=tpm2-tss
+          compiler: clang
+
+        - os: linux
+          env: DISTRO=fedora:latest TSS=ibmtss
+          compiler: clang
+
+        - os: linux
+          env: DISTRO=centos:7 TSS=tpm2-tss
+          compiler: gcc
+
+        - os: linux
+          env: DISTRO=centos:latest TSS=tpm2-tss
+          compiler: clang
+
+        - os: linux
+          env: DISTRO=debian:testing TSS=tpm2-tss
+          compiler: clang
+
+        - os: linux
+          env: DISTRO=debian:stable TSS=ibmtss
+          compiler: gcc
+
+before_install:
+    - df -hT
+    - DIR="/usr/src/ima-evm-utils"
+    - printf "FROM $DISTRO\nRUN mkdir -p $DIR\nWORKDIR $DIR\nCOPY . $DIR\n" > Dockerfile
+    - cat Dockerfile
+    - docker build -t ima-evm-utils .
+
+script:
+    - INSTALL="${DISTRO%%:*}"
+    - INSTALL="${INSTALL%%/*}"
+    - docker run -t ima-evm-utils /bin/sh -c "cd travis && if [ \"$VARIANT\" ]; then ARCH=\"$ARCH\" ./$INSTALL.$VARIANT.sh; fi && ARCH=\"$ARCH\" CC=\"$CC\" TSS=\"$TSS\" ./$INSTALL.sh && if [ ! \"$VARIANT\" ]; then which tpm_server || ../tests/install-swtpm.sh; fi && CC=\"$CC\" VARIANT=\"$VARIANT\" ../build.sh"
diff --git a/build.sh b/build.sh
new file mode 100755
index 0000000..b922fa6
--- /dev/null
+++ b/build.sh
@@ -0,0 +1,97 @@
+#!/bin/sh
+# Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
+
+set -e
+
+CC="${CC:-gcc}"
+CFLAGS="${CFLAGS:--Wformat -Werror=format-security -Werror=implicit-function-declaration -Werror=return-type -fno-common}"
+PREFIX="${PREFIX:-$HOME/ima-evm-utils-install}"
+
+export LD_LIBRARY_PATH="$PREFIX/lib64:$PREFIX/lib:/usr/local/lib64:/usr/local/lib"
+export PATH="$PREFIX/bin:/usr/local/bin:$PATH"
+
+title()
+{
+	echo "===== $1 ====="
+}
+
+log_exit()
+{
+	local ret="${3:-$?}"
+	local log="$1"
+	local msg="$2"
+	local prefix
+
+	echo "=== $log ==="
+	[ $ret -eq 0 ] || prefix="FAIL: "
+	cat $log
+	echo
+	echo "$prefix$msg, see output of $log above"
+	exit $ret
+}
+
+cd `dirname $0`
+
+case "$VARIANT" in
+	i386)
+		echo "32-bit compilation"
+		export CFLAGS="-m32 $CFLAGS" LDFLAGS="-m32 $LDFLAGS"
+		export PKG_CONFIG_LIBDIR=/usr/lib/i386-linux-gnu/pkgconfig
+		;;
+	cross-compile)
+		host="${CC%-gcc}"
+		export CROSS_COMPILE="${host}-"
+		host="--host=$host"
+		echo "cross compilation: $host"
+		echo "CROSS_COMPILE: '$CROSS_COMPILE'"
+		;;
+	*)
+		if [ "$VARIANT" ]; then
+			echo "Wrong VARIANT: '$VARIANT'" >&2
+			exit 1
+		fi
+		echo "native build"
+		;;
+esac
+
+title "compiler version"
+$CC --version
+echo "CFLAGS: '$CFLAGS'"
+echo "LDFLAGS: '$LDFLAGS'"
+echo "PREFIX: '$PREFIX'"
+
+title "configure"
+./autogen.sh
+./configure --prefix=$PREFIX $host || log_exit config.log "configure failed"
+
+title "make"
+make -j$(nproc)
+make install
+
+title "test"
+if [ "$VARIANT" = "cross-compile" ]; then
+	echo "skip make check on cross compilation"
+	exit 0
+fi
+
+ret=0
+VERBOSE=1 make check || ret=$?
+
+title "logs"
+if [ $ret -eq 0 ]; then
+	tail -3 tests/ima_hash.log
+	tail -3 tests/sign_verify.log
+	tail -20 tests/boot_aggregate.log
+	exit 0
+fi
+
+cat tests/test-suite.log
+
+if [ $ret -eq 77 ]; then
+	msg="WARN: some tests skipped"
+	ret=0
+else
+	msg="FAIL: tests exited: $ret"
+fi
+
+log_exit tests/test-suite.log "$msg" $ret
diff --git a/travis/alpine.sh b/travis/alpine.sh
new file mode 100755
index 0000000..63d7954
--- /dev/null
+++ b/travis/alpine.sh
@@ -0,0 +1,50 @@
+#!/bin/sh
+# Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
+set -ex
+
+if [ -z "$CC" ]; then
+	echo "missing \$CC!" >&2
+	exit 1
+fi
+
+case "$TSS" in
+ibmtss) echo "No IBM TSS package, will be installed from git" >&2; TSS=;;
+tpm2-tss) TSS="tpm2-tss-dev";;
+'') echo "Missing TSS!" >&2; exit 1;;
+*) echo "Unsupported TSS: '$TSS'!" >&2; exit 1;;
+esac
+
+# ibmswtpm2 requires gcc
+[ "$CC" = "gcc" ] || CC="gcc $CC"
+
+apk update
+
+apk add \
+	$CC $TSS \
+	asciidoc \
+	attr \
+	attr-dev \
+	autoconf \
+	automake \
+	diffutils \
+	docbook-xml \
+	docbook-xsl \
+	keyutils-dev \
+	libtool \
+	libxslt \
+	linux-headers \
+	make \
+	musl-dev \
+	openssl \
+	openssl-dev \
+	pkgconfig \
+	procps \
+	sudo \
+	wget \
+	which \
+	xxd
+
+if [ ! "$TSS" ]; then
+	apk add git
+	../tests/install-tss.sh
+fi
diff --git a/travis/centos.sh b/travis/centos.sh
new file mode 120000
index 0000000..1479a43
--- /dev/null
+++ b/travis/centos.sh
@@ -0,0 +1 @@
+fedora.sh
\ No newline at end of file
diff --git a/travis/debian.cross-compile.sh b/travis/debian.cross-compile.sh
new file mode 100755
index 0000000..5456d12
--- /dev/null
+++ b/travis/debian.cross-compile.sh
@@ -0,0 +1,23 @@
+#!/bin/sh
+# Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
+set -ex
+
+if [ -z "$ARCH" ]; then
+	echo "missing \$ARCH!" >&2
+	exit 1
+fi
+
+case "$ARCH" in
+arm64) gcc_arch="aarch64";;
+ppc64el) gcc_arch="powerpc64le";;
+s390x) gcc_arch="$ARCH";;
+*) echo "unsupported arch: '$ARCH'!" >&2; exit 1;;
+esac
+
+dpkg --add-architecture $ARCH
+apt update
+
+apt install -y --no-install-recommends \
+	dpkg-dev \
+	gcc-${gcc_arch}-linux-gnu \
+	libc6-dev-${ARCH}-cross
diff --git a/travis/debian.i386.sh b/travis/debian.i386.sh
new file mode 100755
index 0000000..1cad06e
--- /dev/null
+++ b/travis/debian.i386.sh
@@ -0,0 +1,11 @@
+#!/bin/sh
+# Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
+set -ex
+
+dpkg --add-architecture i386
+apt update
+
+apt install -y --no-install-recommends \
+	linux-libc-dev:i386 \
+	gcc-multilib \
+	pkg-config:i386
diff --git a/travis/debian.sh b/travis/debian.sh
new file mode 100755
index 0000000..ad7d2c0
--- /dev/null
+++ b/travis/debian.sh
@@ -0,0 +1,54 @@
+#!/bin/sh
+# Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
+set -ex
+
+if [ -z "$CC" ]; then
+	echo "missing \$CC!" >&2
+	exit 1
+fi
+
+# debian.*.sh must be run first
+if [ "$ARCH" ]; then
+	ARCH=":$ARCH"
+	unset CC
+else
+	apt update
+fi
+
+# ibmswtpm2 requires gcc
+[ "$CC" = "gcc" ] || CC="gcc $CC"
+
+case "$TSS" in
+ibmtss) TSS="libtss-dev";;
+tpm2-tss) TSS="libtss2-dev";;
+'') echo "Missing TSS!" >&2; exit 1;;
+*) [ "$TSS" ] && echo "Unsupported TSS: '$TSS'!" >&2; exit 1;;
+esac
+
+apt="apt install -y --no-install-recommends"
+
+$apt \
+	$CC $TSS \
+	asciidoc \
+	attr \
+	autoconf \
+	automake \
+	diffutils \
+	debianutils \
+	docbook-xml \
+	docbook-xsl \
+	gzip \
+	libattr1-dev$ARCH \
+	libkeyutils-dev$ARCH \
+	libssl-dev$ARCH \
+	libtool \
+	make \
+	openssl \
+	pkg-config \
+	procps \
+	sudo \
+	wget \
+	xsltproc \
+
+$apt xxd || $apt vim-common
+$apt libengine-gost-openssl1.1$ARCH || true
diff --git a/travis/fedora.sh b/travis/fedora.sh
new file mode 100755
index 0000000..d3459e4
--- /dev/null
+++ b/travis/fedora.sh
@@ -0,0 +1,49 @@
+#!/bin/sh
+# Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
+set -e
+
+if [ -z "$CC" ]; then
+	echo "missing \$CC!" >&2
+	exit 1
+fi
+
+case "$TSS" in
+ibmtss) TSS="tss2-devel";;
+tpm2-tss) TSS="tpm2-tss-devel";;
+'') echo "Missing TSS!" >&2; exit 1;;
+*) echo "Unsupported TSS: '$TSS'!" >&2; exit 1;;
+esac
+
+# ibmswtpm2 requires gcc
+[ "$CC" = "gcc" ] || CC="gcc $CC"
+
+yum -y install \
+	$CC $TSS \
+	asciidoc \
+	attr \
+	autoconf \
+	automake \
+	diffutils \
+	docbook-xsl \
+	gzip \
+	keyutils-libs-devel \
+	libattr-devel \
+	libtool \
+	libxslt \
+	make \
+	openssl \
+	openssl-devel \
+	pkg-config \
+	procps \
+	sudo \
+	vim-common \
+	wget \
+	which
+
+yum -y install docbook5-style-xsl || true
+
+# FIXME: debug
+echo "find /tss2_esys.h"
+find /usr/ 2>/dev/null |grep /tss2_esys.h || true
+echo "cat /usr/include/tss2/tss2_esys.h"
+cat /usr/include/tss2/tss2_esys.h || true
diff --git a/travis/opensuse.sh b/travis/opensuse.sh
new file mode 120000
index 0000000..11c5f4b
--- /dev/null
+++ b/travis/opensuse.sh
@@ -0,0 +1 @@
+tumbleweed.sh
\ No newline at end of file
diff --git a/travis/tumbleweed.sh b/travis/tumbleweed.sh
new file mode 100755
index 0000000..ec4dc43
--- /dev/null
+++ b/travis/tumbleweed.sh
@@ -0,0 +1,45 @@
+#!/bin/sh
+# Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
+set -ex
+
+if [ -z "$CC" ]; then
+	echo "missing \$CC!" >&2
+	exit 1
+fi
+
+case "$TSS" in
+ibmtss) TSS="ibmtss-devel";;
+tpm2-tss) TSS="tpm2-0-tss-devel";;
+'') echo "Missing TSS!" >&2; exit 1;;
+*) echo "Unsupported TSS: '$TSS'!" >&2; exit 1;;
+esac
+
+# clang has some gcc dependency
+[ "$CC" = "gcc" ] || CC="gcc $CC"
+
+zypper --non-interactive install --force-resolution --no-recommends \
+	$CC $TSS \
+	asciidoc \
+	attr \
+	autoconf \
+	automake \
+	diffutils \
+	docbook_5 \
+	docbook5-xsl-stylesheets \
+	gzip \
+	ibmswtpm2 \
+	keyutils-devel \
+	libattr-devel \
+	libopenssl-devel \
+	libtool \
+	make \
+	openssl \
+	pkg-config \
+	procps \
+	sudo \
+	vim \
+	wget \
+	which \
+	xsltproc
+
+[ -f /usr/lib/ibmtss/tpm_server ] && ln -s /usr/lib/ibmtss/tpm_server /usr/local/bin
diff --git a/travis/ubuntu.sh b/travis/ubuntu.sh
new file mode 120000
index 0000000..0edcb8b
--- /dev/null
+++ b/travis/ubuntu.sh
@@ -0,0 +1 @@
+debian.sh
\ No newline at end of file
-- 
2.28.0


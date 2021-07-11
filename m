Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA94A3C3C07
	for <lists+linux-integrity@lfdr.de>; Sun, 11 Jul 2021 13:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbhGKL63 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 11 Jul 2021 07:58:29 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:43924 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232710AbhGKL63 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 11 Jul 2021 07:58:29 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 5795872C8B4;
        Sun, 11 Jul 2021 14:55:41 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [193.43.10.9])
        by imap.altlinux.org (Postfix) with ESMTPSA id 3CFD84A46ED;
        Sun, 11 Jul 2021 14:55:41 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH] CI: Add GitHub Actions for ALT Linux
Date:   Sun, 11 Jul 2021 14:55:39 +0300
Message-Id: <20210711115539.2400162-1-vt@altlinux.org>
X-Mailer: git-send-email 2.29.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Build on Sisyphus branch which is bleeding edge repo.
Package manager is apt-rpm (not APT as it may look from the scripts).

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 .github/workflows/ci.yml | 13 ++++++++++++-
 ci/alt.sh                | 24 ++++++++++++++++++++++++
 tests/install-swtpm.sh   | 14 +++++++++++---
 3 files changed, 47 insertions(+), 4 deletions(-)
 create mode 100755 ci/alt.sh

diff --git .github/workflows/ci.yml .github/workflows/ci.yml
index f08733a..088c041 100644
--- .github/workflows/ci.yml
+++ .github/workflows/ci.yml
@@ -92,6 +92,11 @@ jobs:
               CC: clang
               TSS: ibmtss
 
+          - container: "alt:sisyphus"
+            env:
+              CC: gcc
+              TSS: libtpm2-tss-devel
+
     container:
       image: ${{ matrix.container }}
       env: ${{ matrix.env }}
@@ -112,7 +117,13 @@ jobs:
         ARCH="$ARCH" CC="$CC" TSS="$TSS" ./ci/$INSTALL.sh
 
     - name: Build swtpm
-      run: if [ ! "$VARIANT" ]; then which tpm_server || which swtpm || ./tests/install-swtpm.sh; fi
+      run: |
+        if [ ! "$VARIANT" ]; then
+          which tpm_server || which swtpm || \
+            if which tssstartup; then
+              ./tests/install-swtpm.sh;
+            fi
+        fi
 
     - name: Compiler version
       run: $CC --version
diff --git ci/alt.sh ci/alt.sh
new file mode 100755
index 0000000..4996890
--- /dev/null
+++ ci/alt.sh
@@ -0,0 +1,24 @@
+#!/bin/sh -ex
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Build env install script for ALT Linux.
+
+apt-get update -y
+
+# rpm-build brings basic build envirenment with gcc, make, autotools, etc.
+apt-get install -y \
+	$CC \
+	$TSS \
+	asciidoc \
+	attr \
+	docbook-style-xsl \
+	libattr-devel \
+	libkeyutils-devel \
+	libssl-devel \
+	openssl \
+	openssl-gost-engine \
+	rpm-build \
+	wget \
+	xsltproc \
+	xxd
+
diff --git tests/install-swtpm.sh tests/install-swtpm.sh
index 2666748..b344a69 100755
--- tests/install-swtpm.sh
+++ tests/install-swtpm.sh
@@ -1,5 +1,13 @@
-#!/bin/sh
-set -ex
+#!/bin/sh -ex
+
+# No need to run via sudo if we already have permissions, such as in Docker.
+# Some distros do not have sudo configured for root:
+#   `root is not in the sudoers file.  This incident will be reported.'
+if [ -w /usr/local/bin ]; then
+	SUDO=
+else
+	SUDO=sudo
+fi
 
 version=1637
 
@@ -9,5 +17,5 @@ cd ibmtpm$version
 tar --no-same-owner -xvzf ../download
 cd src
 make -j$(nproc)
-sudo cp tpm_server /usr/local/bin/
+$SUDO cp tpm_server /usr/local/bin/
 cd ../..
-- 
2.29.3


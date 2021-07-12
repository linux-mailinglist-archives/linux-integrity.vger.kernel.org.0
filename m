Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A47AE3C4371
	for <lists+linux-integrity@lfdr.de>; Mon, 12 Jul 2021 07:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbhGLFUJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 12 Jul 2021 01:20:09 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:34158 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbhGLFUJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Jul 2021 01:20:09 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id ACBF872C8B4;
        Mon, 12 Jul 2021 08:17:20 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [193.43.10.9])
        by imap.altlinux.org (Postfix) with ESMTPSA id 94E994A46ED;
        Mon, 12 Jul 2021 08:17:20 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH ima-evm-utils 3/3] CI: Add support for ALT Linux
Date:   Mon, 12 Jul 2021 08:16:44 +0300
Message-Id: <20210712051644.2469633-3-vt@altlinux.org>
X-Mailer: git-send-email 2.29.3
In-Reply-To: <20210712051644.2469633-1-vt@altlinux.org>
References: <20210712051644.2469633-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Build on Sisyphus branch which is bleeding edge repository.
Package manager is apt-rpm (not APT as it may look from the scripts).

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 .github/workflows/ci.yml |  5 +++++
 .travis.yml              |  4 ++++
 ci/alt.sh                | 24 ++++++++++++++++++++++++
 3 files changed, 33 insertions(+)
 create mode 100755 ci/alt.sh

diff --git .github/workflows/ci.yml .github/workflows/ci.yml
index 2e0b1b0..088c041 100644
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
diff --git .travis.yml .travis.yml
index 94fbb94..7a76273 100644
--- .travis.yml
+++ .travis.yml
@@ -67,6 +67,10 @@ matrix:
           env: DISTRO=debian:stable TSS=ibmtss
           compiler: gcc
 
+        - os: linux
+          env: DISTRO=alt:sisyphus TSS=libtpm2-tss-devel
+          compiler: gcc
+
 before_install:
     # Tumbleweed requires podman and newest runc due docker incompatible with glibc 2.33 (faccessat2)
     - CONTAINER="${CONTAINER:-docker}"
diff --git ci/alt.sh ci/alt.sh
new file mode 100755
index 0000000..e7a891f
--- /dev/null
+++ ci/alt.sh
@@ -0,0 +1,24 @@
+#!/bin/sh -ex
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Install build env for ALT Linux
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
-- 
2.29.3


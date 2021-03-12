Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1765338BB8
	for <lists+linux-integrity@lfdr.de>; Fri, 12 Mar 2021 12:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbhCLLmc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 12 Mar 2021 06:42:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:55640 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233923AbhCLLmE (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 12 Mar 2021 06:42:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1AD44B02F;
        Fri, 12 Mar 2021 11:42:03 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH ima-evm-utils] travis: Fix openSUSE Tumbleweed
Date:   Fri, 12 Mar 2021 12:41:52 +0100
Message-Id: <20210312114152.20475-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

openSUSE Tumbleweed build fails due broken permission detection due
faccessat2() incompatibility in libseccomp/runc used in old docker with
old kernel on Ubuntu Focal on hosts in Travis CI together with guests
with the newest glibc 2.33.

Fixing Tumbleweed required switch to podman and downloading newest runc
release (v1.0.0-rc93) which contains the fix [1], because proposed glibc
fix [2] aren't going to merged to upstream [3] nor to Tumbleweed
downstream glibc [4].

Using podman requires --no-same-owner tar option to workaround
running out of subuids/subgids:
tar: ./LICENSE: Cannot change ownership to uid 339315, gid 578953: Invalid argument
(sudo would also work)

Sooner or later it will be required for more distros (Fedora, Debian
Ubuntu), but don't waste build time until required.

[1] https://github.com/opencontainers/runc/pull/2750
[2] https://sourceware.org/pipermail/libc-alpha/2020-November/119955.html
[3] https://sourceware.org/pipermail/libc-alpha/2020-November/119978.html
[4] https://bugzilla.opensuse.org/1182451

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .travis.yml            | 27 +++++++++++++++++++++++----
 tests/install-swtpm.sh |  2 +-
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index e73b24e..e30e04f 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -1,4 +1,7 @@
+# Copyright (c) 2017-2021 Petr Vorel <pvorel@suse.cz>
+
 dist: bionic
+sudo: required
 language: C
 services:
     - docker
@@ -30,7 +33,7 @@ matrix:
 
         # glibc (gcc/clang)
         - os: linux
-          env: DISTRO=opensuse/tumbleweed TSS=ibmtss
+          env: DISTRO=opensuse/tumbleweed TSS=ibmtss CONTAINER=podman CONTAINER_ARGS="--runtime=/usr/bin/runc"
           compiler: clang
 
         - os: linux
@@ -66,13 +69,29 @@ matrix:
           compiler: gcc
 
 before_install:
-    - df -hT
+    # Tumbleweed requires podman and newest runc due docker incompatible with glibc 2.33 (faccessat2)
+    - CONTAINER="${CONTAINER:-docker}"
+    - >
+        if [ "$CONTAINER" = "podman" ]; then
+            # podman
+            . /etc/os-release
+            sudo sh -c "echo 'deb http://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/ /' > /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list"
+            wget -nv https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable/xUbuntu_${VERSION_ID}/Release.key -O- | sudo apt-key add -
+            sudo apt update
+            sudo apt -y install podman slirp4netns
+
+            # runc
+            sudo curl -L https://github.com/opencontainers/runc/releases/download/v1.0.0-rc93/runc.amd64 -o /usr/bin/runc
+            sudo chmod +x /usr/bin/runc
+        fi
+    - $CONTAINER info
+
     - DIR="/usr/src/ima-evm-utils"
     - printf "FROM $DISTRO\nRUN mkdir -p $DIR\nWORKDIR $DIR\nCOPY . $DIR\n" > Dockerfile
     - cat Dockerfile
-    - docker build -t ima-evm-utils .
+    - $CONTAINER build $CONTAINER_ARGS -t ima-evm-utils .
 
 script:
     - INSTALL="${DISTRO%%:*}"
     - INSTALL="${INSTALL%%/*}"
-    - docker run -t ima-evm-utils /bin/sh -c "cd travis && if [ \"$VARIANT\" ]; then ARCH=\"$ARCH\" ./$INSTALL.$VARIANT.sh; fi && ARCH=\"$ARCH\" CC=\"$CC\" TSS=\"$TSS\" ./$INSTALL.sh && if [ ! \"$VARIANT\" ]; then which tpm_server || which swtpm || ../tests/install-swtpm.sh; fi && CC=\"$CC\" VARIANT=\"$VARIANT\" ../build.sh"
+    - $CONTAINER run $CONTAINER_ARGS -t ima-evm-utils /bin/sh -c "cd travis && if [ \"$VARIANT\" ]; then ARCH=\"$ARCH\" ./$INSTALL.$VARIANT.sh; fi && ARCH=\"$ARCH\" CC=\"$CC\" TSS=\"$TSS\" ./$INSTALL.sh && if [ ! \"$VARIANT\" ]; then which tpm_server || which swtpm || ../tests/install-swtpm.sh; fi && CC=\"$CC\" VARIANT=\"$VARIANT\" ../build.sh"
diff --git a/tests/install-swtpm.sh b/tests/install-swtpm.sh
index 2d8293a..2666748 100755
--- a/tests/install-swtpm.sh
+++ b/tests/install-swtpm.sh
@@ -6,7 +6,7 @@ version=1637
 wget --no-check-certificate https://sourceforge.net/projects/ibmswtpm2/files/ibmtpm${version}.tar.gz/download
 mkdir ibmtpm$version
 cd ibmtpm$version
-tar -xvzf ../download
+tar --no-same-owner -xvzf ../download
 cd src
 make -j$(nproc)
 sudo cp tpm_server /usr/local/bin/
-- 
2.30.1


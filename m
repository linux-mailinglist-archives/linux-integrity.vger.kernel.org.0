Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3329236E48D
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Apr 2021 07:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238584AbhD2Fk1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 29 Apr 2021 01:40:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:52290 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230103AbhD2FkY (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 29 Apr 2021 01:40:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7864DAEAC;
        Thu, 29 Apr 2021 05:39:25 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH 1/1] travis: Fix Fedora
Date:   Thu, 29 Apr 2021 07:39:18 +0200
Message-Id: <20210429053918.10240-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Fedora recently got 2.33, which requires on Travis CI to use podman.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi Mimi,

Tested [1].

Previously Fedora fails on autoconf issue [2], which is caused by
faccessat2 incompatibility on glibc 2.33:

/usr/bin/autoconf: This script requires a shell more modern than all
/usr/bin/autoconf: the shells that I found on your system.
/usr/bin/autoconf: Please tell bug-autoconf@gnu.org about your system,
/usr/bin/autoconf: including any error possibly output before this
/usr/bin/autoconf: message. Then install a modern shell, or manually run
/usr/bin/autoconf: the script under such a shell if you do have one.
autoreconf: /usr/bin/autoconf failed with exit status: 1

[1] https://travis-ci.org/github/pevik/ima-evm-utils/builds/768789641
[2] https://travis-ci.org/github/pevik/ima-evm-utils/jobs/767259578

 .travis.yml | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index fde774e..fa3cbae 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -32,7 +32,7 @@ matrix:
 
         # glibc (gcc/clang)
         - os: linux
-          env: DISTRO=opensuse/tumbleweed TSS=ibmtss CONTAINER=podman CONTAINER_ARGS="--runtime=/usr/bin/runc --network=host"
+          env: DISTRO=opensuse/tumbleweed TSS=ibmtss CONTAINER=podman
           compiler: clang
 
         - os: linux
@@ -48,7 +48,7 @@ matrix:
           compiler: clang
 
         - os: linux
-          env: DISTRO=fedora:latest TSS=ibmtss
+          env: DISTRO=fedora:latest TSS=ibmtss CONTAINER=podman
           compiler: clang
 
         - os: linux
@@ -68,11 +68,12 @@ matrix:
           compiler: gcc
 
 before_install:
-    # Tumbleweed requires podman and newest runc due docker incompatible with glibc 2.33 (faccessat2)
     - CONTAINER="${CONTAINER:-docker}"
+    # distros with glibc >=2.33 require podman and newest runc due docker faccessat2 incompatibility
     - >
         if [ "$CONTAINER" = "podman" ]; then
             # podman
+            CONTAINER_ARGS="--runtime=/usr/bin/runc --network=host"
             . /etc/os-release
             sudo sh -c "echo 'deb http://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/ /' > /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list"
             wget -nv https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable/xUbuntu_${VERSION_ID}/Release.key -O- | sudo apt-key add -
-- 
2.31.1


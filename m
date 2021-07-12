Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE1803C436E
	for <lists+linux-integrity@lfdr.de>; Mon, 12 Jul 2021 07:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhGLFT5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 12 Jul 2021 01:19:57 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:33914 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbhGLFT5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Jul 2021 01:19:57 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 4BAF172C8B4;
        Mon, 12 Jul 2021 08:17:08 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [193.43.10.9])
        by imap.altlinux.org (Postfix) with ESMTPSA id 34FBF4A46ED;
        Mon, 12 Jul 2021 08:17:08 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH ima-evm-utils 1/3] CI: Do not install swtpm if it cannot work anyway
Date:   Mon, 12 Jul 2021 08:16:42 +0300
Message-Id: <20210712051644.2469633-1-vt@altlinux.org>
X-Mailer: git-send-email 2.29.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Do not need to waste CPU cycles and time to install swtpm in CI
container if distribution does not have tssstartup, because we will
be not able to start it.

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 .github/workflows/ci.yml | 8 +++++++-
 .travis.yml              | 2 +-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git .github/workflows/ci.yml .github/workflows/ci.yml
index f08733a..2e0b1b0 100644
--- .github/workflows/ci.yml
+++ .github/workflows/ci.yml
@@ -112,7 +112,13 @@ jobs:
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
diff --git .travis.yml .travis.yml
index 5b07711..94fbb94 100644
--- .travis.yml
+++ .travis.yml
@@ -93,4 +93,4 @@ before_install:
 script:
     - INSTALL="${DISTRO%%:*}"
     - INSTALL="${INSTALL%%/*}"
-    - $CONTAINER run $CONTAINER_ARGS -t ima-evm-utils /bin/sh -c "if [ \"$VARIANT\" ]; then ARCH=\"$ARCH\" ./ci/$INSTALL.$VARIANT.sh; fi && ARCH=\"$ARCH\" CC=\"$CC\" TSS=\"$TSS\" ./ci/$INSTALL.sh && if [ ! \"$VARIANT\" ]; then which tpm_server || which swtpm || ./tests/install-swtpm.sh; fi && CC=\"$CC\" VARIANT=\"$VARIANT\" ./build.sh"
+    - $CONTAINER run $CONTAINER_ARGS -t ima-evm-utils /bin/sh -c "if [ \"$VARIANT\" ]; then ARCH=\"$ARCH\" ./ci/$INSTALL.$VARIANT.sh; fi && ARCH=\"$ARCH\" CC=\"$CC\" TSS=\"$TSS\" ./ci/$INSTALL.sh && if [ ! \"$VARIANT\" ]; then which tpm_server || which swtpm || if which tssstartup; then ./tests/install-swtpm.sh; fi; fi && CC=\"$CC\" VARIANT=\"$VARIANT\" ./build.sh"
-- 
2.29.3


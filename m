Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42FC63E676
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Dec 2022 01:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbiLAA1C (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Nov 2022 19:27:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiLAA1C (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Nov 2022 19:27:02 -0500
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C5D4258BC9
        for <linux-integrity@vger.kernel.org>; Wed, 30 Nov 2022 16:26:59 -0800 (PST)
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 8B13B72C98C;
        Thu,  1 Dec 2022 03:26:58 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [193.43.10.9])
        by imap.altlinux.org (Postfix) with ESMTPSA id DDB514A5058;
        Thu,  1 Dec 2022 03:26:57 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH ima-evm-utils] Experimental fsverity.test related GA CI improvements
Date:   Thu,  1 Dec 2022 03:26:54 +0300
Message-Id: <20221201002654.2238906-1-vt@altlinux.org>
X-Mailer: git-send-email 2.33.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Mimi Zohar <zohar@linux.ibm.com>

This does not make fsverity.test working on GA CI, though.

- `--device /dev/loop-control' is required for losetup(8) to work.
- `--privileged' is required foo mount(8) to work, and this makes
  `--security-opt seccomp=unconfined' redundant.
- GA container does not have `/sys/kernel/security' mounted which is
  needed for `/sys/kernel/security/integrity/ima/policy'.
- Enable `set -x` in CI as the logs is everything we have to analyze on
  failures.

Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 .github/workflows/ci.yml |  2 +-
 build.sh                 | 12 +++++++++++-
 tests/fsverity.test      |  2 +-
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/.github/workflows/ci.yml b/.github/workflows/ci.yml
index 8223b87..d2afdfe 100644
--- a/.github/workflows/ci.yml
+++ b/.github/workflows/ci.yml
@@ -98,7 +98,7 @@ jobs:
     container:
       image: ${{ matrix.container }}
       env: ${{ matrix.env }}
-      options: --security-opt seccomp=unconfined
+      options: --privileged --device /dev/loop-control
 
     steps:
     - name: Show OS
diff --git a/build.sh b/build.sh
index cc5a258..4e2f1bb 100755
--- a/build.sh
+++ b/build.sh
@@ -1,6 +1,16 @@
 #!/bin/sh
 # Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
 
+if [ -n "$CI" ]; then
+	# If we under CI only thing we can analyze is logs so better to enable
+	# verbosity to a maximum.
+	set -x
+	# This is to make stdout and stderr synchronous in the logs.
+	exec 2>&1
+
+	mount -t securityfs -o rw securityfs /sys/kernel/security
+fi
+
 set -e
 
 CC="${CC:-gcc}"
@@ -100,7 +110,7 @@ if [ $ret -eq 0 ]; then
 	tail -20 tests/boot_aggregate.log
 
 	if [ -f tests/fsverity.log ]; then
-		tail -4 tests/fsverity.log
+		[ -n "$CI" ] && cat tests/fsverity.log || tail tests/fsverity.log
 		grep "skipped" tests/fsverity.log  && \
 		   grep "skipped" tests/fsverity.log | wc -l
 	fi
diff --git a/tests/fsverity.test b/tests/fsverity.test
index def06f8..1bb8362 100755
--- a/tests/fsverity.test
+++ b/tests/fsverity.test
@@ -78,7 +78,7 @@ mount_loopback_file() {
 		exit "$FAIL"
 	fi
 
-	mount -o loop ${TST_IMG} $TST_MNT
+	mount -v -o loop ${TST_IMG} $TST_MNT
 	ret=$?
 
 	if [ "${ret}" -eq 0 ]; then
-- 
2.33.4


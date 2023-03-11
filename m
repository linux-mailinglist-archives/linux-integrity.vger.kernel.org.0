Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A206B5A08
	for <lists+linux-integrity@lfdr.de>; Sat, 11 Mar 2023 10:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjCKJYf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 11 Mar 2023 04:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbjCKJYJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 11 Mar 2023 04:24:09 -0500
X-Greylist: delayed 328 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 11 Mar 2023 01:22:22 PST
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C2C82133A60
        for <linux-integrity@vger.kernel.org>; Sat, 11 Mar 2023 01:22:22 -0800 (PST)
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id D004972C8D0;
        Sat, 11 Mar 2023 12:16:53 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [193.43.10.9])
        by imap.altlinux.org (Postfix) with ESMTPSA id C6C9436D018A;
        Sat, 11 Mar 2023 12:16:53 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH ima-evm-utils] Fix fsverity.test mount failure for ppc64
Date:   Sat, 11 Mar 2023 12:16:44 +0300
Message-Id: <20230311091644.647214-1-vt@altlinux.org>
X-Mailer: git-send-email 2.33.7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

fsverity requires fs blocksize to be equal to pagesoze, which is
different on ppc64 (64K). Default mkfs blocksize if 4K. This difference
causes mount failure and following error message:

  INFO: Mounting loopback filesystem
  mount: /tmp/fsverity-test: wrong fs type, bad option, bad superblock on /dev/loop0, missing codepage or helper program, or other error.
         dmesg(1) may have more information after failed mount system call.
  FAILURE: mounting loopback filesystem

It's said this limitation is removed in Linux v6.3, but for backward
compatibility better to leave workaround for it.

Fixes: b259a2b ("tests: add fsverity measurement test")
Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 tests/fsverity.test | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/fsverity.test b/tests/fsverity.test
index 01d5c35..5ad7634 100755
--- a/tests/fsverity.test
+++ b/tests/fsverity.test
@@ -120,6 +120,9 @@ create_loopback_file() {
 	case $fs_type in
 	ext4|f2fs)
 		options="-O verity"
+		# verity requires blocksize to be equal to pagesize.
+		pagesize=$(getconf PAGE_SIZE)
+		[ "$pagesize" -eq 4096 ] || options+=" -b $pagesize"
 		;;
 	btrfs)
 		;;
@@ -136,7 +139,7 @@ create_loopback_file() {
 	fi
 
 	echo "INFO: Building an $fs_type filesystem"
-	if ! mkfs -t "$fs_type" -q "${TST_IMG}" "$options"; then
+	if ! mkfs -t "$fs_type" -q "${TST_IMG}" $options; then
 		echo "${RED}FAILURE: Creating $fs_type filesystem${NORM}"
 		exit "$FAIL"
 	fi
-- 
2.33.7


Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 425C344180
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Jun 2019 18:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbfFMQOy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Jun 2019 12:14:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:34146 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731187AbfFMQOs (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Jun 2019 12:14:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A94CDAE20;
        Thu, 13 Jun 2019 16:14:47 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Ignaz Forster <iforster@suse.de>,
        linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH v4 2/4] shell: Add $TST_DEVICE as default parameter to tst_umount
Date:   Thu, 13 Jun 2019 18:14:12 +0200
Message-Id: <20190613161414.29161-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190613161414.29161-1-pvorel@suse.cz>
References: <20190613161414.29161-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

+ use it directly as a cleanup function in df01.sh

Acked-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/test-writing-guidelines.txt                            | 4 ++--
 testcases/commands/df/df01.sh                              | 7 +------
 testcases/commands/mkfs/mkfs01.sh                          | 2 +-
 testcases/kernel/security/integrity/ima/tests/ima_setup.sh | 2 +-
 testcases/lib/tst_test.sh                                  | 2 +-
 5 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index f1912dc12..fc64b418b 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -2115,8 +2115,8 @@ The 'tst_mount' mounts '$TST_DEVICE' of '$TST_FS_TYPE' (optional) to
 '$TST_MNT_PARAMS'. The '$TST_MNTPOINT' directory is created if it didn't
 exist prior to the function call.
 
-If the path passed to the 'tst_umount' is not mounted (present in '/proc/mounts')
-it's noop.
+If the path passed (optional, defaults to '$TST_DEVICE') to the 'tst_umount' is
+not mounted (present in '/proc/mounts') it's noop.
 Otherwise it retries to umount the filesystem a few times on a failure, which
 is a workaround since there are a daemons dumb enough to probe all newly
 mounted filesystems, which prevents them from umounting shortly after they
diff --git a/testcases/commands/df/df01.sh b/testcases/commands/df/df01.sh
index 9b0be76fe..3876816dc 100755
--- a/testcases/commands/df/df01.sh
+++ b/testcases/commands/df/df01.sh
@@ -18,7 +18,7 @@
 
 TST_CNT=12
 TST_SETUP=setup
-TST_CLEANUP=cleanup
+TST_CLEANUP=tst_umount
 TST_TESTFUNC=test
 TST_OPTS="f:"
 TST_USAGE=usage
@@ -54,11 +54,6 @@ setup()
 	DF_FS_TYPE=$(mount | grep "$TST_DEVICE" | awk '{print $5}')
 }
 
-cleanup()
-{
-	tst_umount $TST_DEVICE
-}
-
 df_test()
 {
 	local cmd="$1 -P"
diff --git a/testcases/commands/mkfs/mkfs01.sh b/testcases/commands/mkfs/mkfs01.sh
index 88f7f0baa..28af890b3 100755
--- a/testcases/commands/mkfs/mkfs01.sh
+++ b/testcases/commands/mkfs/mkfs01.sh
@@ -71,7 +71,7 @@ mkfs_verify_size()
 {
 	tst_mount
 	local blocknum=`df -P -B 1k mntpoint | tail -n1 | awk '{print $2}'`
-	tst_umount "$TST_DEVICE"
+	tst_umount
 
 	if [ $blocknum -gt "$2" ]; then
 		return 1
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index cbded42c2..da49eb1b2 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -105,7 +105,7 @@ ima_cleanup()
 
 	if [ "$TST_NEEDS_DEVICE" = 1 ]; then
 		cd $TST_TMPDIR
-		tst_umount $TST_DEVICE
+		tst_umount
 	fi
 }
 
diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 512732315..740253df1 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -259,7 +259,7 @@ tst_mount()
 
 tst_umount()
 {
-	local device="$1"
+	local device="${1:-$TST_DEVICE}"
 	local i=0
 
 	if ! grep -q "$device" /proc/mounts; then
-- 
2.21.0


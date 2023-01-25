Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8CA67ACD2
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Jan 2023 09:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234431AbjAYIwC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 25 Jan 2023 03:52:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjAYIwC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Jan 2023 03:52:02 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3F5EB
        for <linux-integrity@vger.kernel.org>; Wed, 25 Jan 2023 00:52:01 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4P1y7209r6z9xHvP
        for <linux-integrity@vger.kernel.org>; Wed, 25 Jan 2023 16:43:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwD3fQmG7dBjf2fGAA--.15976S6;
        Wed, 25 Jan 2023 09:51:47 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        stefanb@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH ima-evm-utils v3 04/11] Pass cleanup function and its arguments to _report_exit_and_cleanup()
Date:   Wed, 25 Jan 2023 09:50:23 +0100
Message-Id: <20230125085030.1568256-5-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230125085030.1568256-1-roberto.sassu@huaweicloud.com>
References: <20230125085030.1568256-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwD3fQmG7dBjf2fGAA--.15976S6
X-Coremail-Antispam: 1UD129KBjvJXoWxuF45WFy8Ar45XFy3CFyUJrb_yoW5AFWUpa
        1DWa4IkrZ5ta40qr48Cwn2va4xt3y5Zw45Zr4kCF4Duw1rXrykKF4xK3W2qFWUWrZavrWf
        C3y0qrn5Kr1DCrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvKb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
        WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
        bVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
        WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
        67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
        IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
        0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
        VjvjDU0xZFpf9x07UZo7tUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAIBF1jj4gLNgAAsJ
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

If an error occurs before any test is executed, _report_exit_and_cleanup()
returns 77 ($SKIP) as exit code, which might not reflect the real exit code
at the time the script terminated its execution.

If the function registered in the shell trap() is a cleanup function
calling _report_exit_and_cleanup() inside, the latter will not have access
to the exit code at the time of the trap but instead to the exit code of
the cleanup function.

To solve this issue, pass the cleanup function and its arguments to
_report_exit_and_cleanup(), so that the latter can first get the script
exit code and then can execute the cleanup function.

Finally, if no test was executed, return the exit code at the time of the
trap() instead of 77.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 tests/boot_aggregate.test |  2 +-
 tests/fsverity.test       |  3 +--
 tests/functions.sh        | 10 ++++++++--
 3 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/tests/boot_aggregate.test b/tests/boot_aggregate.test
index d7115660385f..ca5faf9cd97d 100755
--- a/tests/boot_aggregate.test
+++ b/tests/boot_aggregate.test
@@ -12,7 +12,7 @@
 # for verifying the calculated boot_aggregate is included in this
 # directory as well.
 
-trap cleanup SIGINT SIGTERM EXIT
+trap '_report_exit_and_cleanup cleanup' SIGINT SIGTERM EXIT
 
 # Base VERBOSE on the environment variable, if set.
 VERBOSE="${VERBOSE:-0}"
diff --git a/tests/fsverity.test b/tests/fsverity.test
index 549c42a32608..be9594010de5 100755
--- a/tests/fsverity.test
+++ b/tests/fsverity.test
@@ -47,7 +47,7 @@ FSVERITY="$(which fsverity)"
 _require dd mkfs blkid e2fsck tune2fs evmctl setfattr
 ./gen-keys.sh >/dev/null 2>&1
 
-trap cleanup SIGINT SIGTERM EXIT
+trap '_report_exit_and_cleanup cleanup' SIGINT SIGTERM EXIT
 
 cleanup() {
         if [ -e $TST_MNT ]; then
@@ -58,7 +58,6 @@ cleanup() {
 			rm "$TST_IMG"
 		fi
 	fi
-	_report_exit_and_cleanup
 }
 
 # Loopback mount a file
diff --git a/tests/functions.sh b/tests/functions.sh
index 8f6f02dfcd95..cf83ad21562f 100755
--- a/tests/functions.sh
+++ b/tests/functions.sh
@@ -250,10 +250,14 @@ _enable_gost_engine() {
 # Show test stats and exit into automake test system
 # with proper exit code (same as ours). Do cleanups.
 _report_exit_and_cleanup() {
+  local exit_code=$?
+
   if [ -n "${WORKDIR}" ]; then
     rm -rf "${WORKDIR}"
   fi
 
+  "$@"
+
   if [ $testsfail -gt 0 ]; then
     echo "================================="
     echo " Run with FAILEARLY=1 $0 $*"
@@ -271,8 +275,10 @@ _report_exit_and_cleanup() {
     exit "$FAIL"
   elif [ $testspass -gt 0 ]; then
     exit "$OK"
-  else
+  elif [ $testsskip -gt 0 ]; then
     exit "$SKIP"
+  else
+    exit $exit_code
   fi
 }
 
@@ -312,4 +318,4 @@ _softhsm_teardown() {
   rm -rf "${SOFTHSM_SETUP_CONFIGDIR}"
   unset SOFTHSM_SETUP_CONFIGDIR SOFTHSM2_CONF PKCS11_KEYURI \
     EVMCTL_ENGINE OPENSSL_ENGINE OPENSSL_KEYFORM
-}
\ No newline at end of file
+}
-- 
2.25.1


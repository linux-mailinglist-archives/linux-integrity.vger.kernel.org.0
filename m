Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B5067CD0C
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Jan 2023 14:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjAZN7N (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 26 Jan 2023 08:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbjAZN7E (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 26 Jan 2023 08:59:04 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868BF59994
        for <linux-integrity@vger.kernel.org>; Thu, 26 Jan 2023 05:58:58 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4P2htl3Cswz9xFQN
        for <linux-integrity@vger.kernel.org>; Thu, 26 Jan 2023 21:50:55 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwB39P_4htJj+ajLAA--.553S6;
        Thu, 26 Jan 2023 14:58:46 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        stefanb@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH ima-evm-utils v4 04/11] Pass cleanup function and its arguments to _report_exit_and_cleanup()
Date:   Thu, 26 Jan 2023 14:58:00 +0100
Message-Id: <20230126135807.1848668-5-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230126135807.1848668-1-roberto.sassu@huaweicloud.com>
References: <20230126135807.1848668-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwB39P_4htJj+ajLAA--.553S6
X-Coremail-Antispam: 1UD129KBjvJXoWxuF45WFy8Ar45XFyfJw45Awb_yoW5Cr4kpa
        1DWa4IkrZ5ta40qrW8Cwn2va4xt3y5Zw43Zr48CFWDuw4rXr1kKF4xKw12qFWUWrZavFWf
        Cay0qrn5Kr1DCrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvEb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AK
        xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
        xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
        z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
        v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
        1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
        AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
        42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
        evJa73UjIFyTuYvjxUFgAwUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAJBF1jj4ggcwABsn
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
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
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
index 8f6f02dfcd95..d0a9e8e62ca5 100755
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
+    exit "$exit_code"
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


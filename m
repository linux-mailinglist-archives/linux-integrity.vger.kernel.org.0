Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B707B683221
	for <lists+linux-integrity@lfdr.de>; Tue, 31 Jan 2023 17:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjAaQDc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 31 Jan 2023 11:03:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjAaQDb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 31 Jan 2023 11:03:31 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318CA3A597
        for <linux-integrity@vger.kernel.org>; Tue, 31 Jan 2023 08:03:19 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4P5qPq5W3vz9xFGX
        for <linux-integrity@vger.kernel.org>; Tue, 31 Jan 2023 23:55:11 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwAn+2GzO9ljT5LfAA--.11028S2;
        Tue, 31 Jan 2023 17:03:05 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        stefanb@linux.ibm.com, Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH ima-evm-utils v2] Introduce expect_pass_if() and expect_fail_if()
Date:   Tue, 31 Jan 2023 17:02:30 +0100
Message-Id: <20230131160230.2327345-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwAn+2GzO9ljT5LfAA--.11028S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJFWfXF1DGr17GrW3Xr15XFb_yoW5Xw15p3
        93Wr13C3WkX3WxAF93GF1vy3WrCw48JrWUJrZ3J3yUur4a9F97ta1fKrWUuF1jgrn5ZF93
        Ja1Fvrn5WF1UAFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUy0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
        c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
        CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
        MIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6r
        W3Jr1lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
        YxBIdaVFxhVjvjDU0xZFpf9x07UCg4fUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAOBF1jj4hY2gAAsw
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Introduce these functions to let the developer specify which kernel patches
are required for the tests to be successful (either pass or fail). If a
test is not successful, print those patches in the test result summary.

First, the developer should declare an array, named PATCHES, with the list
of all kernel patches that are required by the tests. For example:

PATCHES=(
'patch 1 title'
...
'patch N title'
)

Second, the developer could replace the existing expect_pass() and
expect_fail() respectively with expect_pass_if() and expect_fail_if(), and
add the indexes in the PATCHES array as the first argument, enclosed with
quotes. The other parameters of expect_pass() and expect_fail() remain the
same.

In the following example, the PATCHES array has been added to a new test
script, tests/mmap_check.test:

PATCHES=(
'ima: Align ima_file_mmap() parameters with mmap_file LSM hook'
'ima: Introduce MMAP_CHECK_REQPROT hook'
)

Then, expect_pass() has been replaced with expect_pass_if():

expect_pass_if '0' check_mmap "MMAP_CHECK" "read_implies_exec"

The resulting output when a test fails (if the required patch is not
applied) is:

Test: check_mmap (hook="MMAP_CHECK", test_mmap arg: "read_implies_exec")
Result (expect found): not found
Possibly missing patches:
 - ima: Align ima_file_mmap() parameters with mmap_file LSM hook

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
Changelog

v1:
- Declare idx variables as local

 tests/functions.sh | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tests/functions.sh b/tests/functions.sh
index 2c4d20536316..ed06040b394d 100755
--- a/tests/functions.sh
+++ b/tests/functions.sh
@@ -100,6 +100,25 @@ expect_pass() {
   return $ret
 }
 
+expect_pass_if() {
+  local indexes="$1"
+  local ret idx
+
+  shift
+
+  expect_pass "$@"
+  ret=$?
+
+  if [ $ret -ne 0 ] && [ $ret -ne 77 ] && [ -n "$PATCHES" ]; then
+    echo $YELLOW"Possibly missing patches:"$NORM
+    for idx in $indexes; do
+      echo $YELLOW" - ${PATCHES[$((idx))]}"$NORM
+    done
+  fi
+
+  return $ret
+}
+
 # Eval negative test (one that should fail) and account its result
 expect_fail() {
   local ret
@@ -137,6 +156,25 @@ expect_fail() {
   return $ret
 }
 
+expect_fail_if() {
+  local indexes="$1"
+  local ret idx
+
+  shift
+
+  expect_fail "$@"
+  ret=$?
+
+  if { [ $ret -eq 0 ] || [ $ret -eq 99 ]; } && [ -n "$PATCHES" ]; then
+    echo $YELLOW"Possibly missing patches:"$NORM
+    for idx in $indexes; do
+      echo $YELLOW" - ${PATCHES[$((idx))]}"$NORM
+    done
+  fi
+
+  return $ret
+}
+
 # return true if current test is positive
 _test_expected_to_pass() {
   [ ! $TFAIL ]
-- 
2.25.1


Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEECA228826
	for <lists+linux-integrity@lfdr.de>; Tue, 21 Jul 2020 20:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbgGUSYr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 21 Jul 2020 14:24:47 -0400
Received: from linux.microsoft.com ([13.77.154.182]:56832 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgGUSYr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Jul 2020 14:24:47 -0400
Received: from localhost.localdomain (c-73-187-218-229.hsd1.pa.comcast.net [73.187.218.229])
        by linux.microsoft.com (Postfix) with ESMTPSA id 643FF20B4908;
        Tue, 21 Jul 2020 11:24:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 643FF20B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1595355886;
        bh=/VTibjakL9ELXNXCLpaG4W/MeSCeCvg41MnPXUUsxWQ=;
        h=From:To:Cc:Subject:Date:From;
        b=Nu//DrmMWHY65Jxlrp5mBy40V+jzWFWBsy33cgAPkcjRonSWpC0jqeRCG5HGA3U9m
         5VAe4WI/Hx4mxYqTk7chL9ze6LXi9P8F/SdRVJLv/oaw0OBeVpBkvY/BdN3YLGrcG4
         yHeQLR2Q3ZsL0UeWL69a3P1fd1Fa+AAcTm4vi6L4=
From:   Lachlan Sneff <t-josne@linux.microsoft.com>
To:     zohar@linux.ibm.com, pvorel@suse.cz, ltp@lists.linux.it
Cc:     nramas@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org
Subject: [PATCH] IMA: Add test for kexec cmdline measurement
Date:   Tue, 21 Jul 2020 14:24:40 -0400
Message-Id: <20200721182440.4169-1-t-josne@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

IMA policy can be set to measure the command line passed in the kexec system call.
There needs to be a test to validate this kexec command line measurement.

Add a testcase that verifies that the IMA subsystem has correctly
measured the cmdline specified during a kexec.

Note that this test does not actually reboot.

Signed-off-by: Lachlan Sneff <t-josne@linux.microsoft.com>
---
 runtest/ima                                   |  1 +
 .../kernel/security/integrity/ima/README.md   | 11 +++
 .../security/integrity/ima/tests/ima_kexec.sh | 93 +++++++++++++++++++
 3 files changed, 105 insertions(+)
 create mode 100644 testcases/kernel/security/integrity/ima/tests/ima_kexec.sh

diff --git a/runtest/ima b/runtest/ima
index 309d47420..5f4b4a7a1 100644
--- a/runtest/ima
+++ b/runtest/ima
@@ -4,4 +4,5 @@ ima_policy ima_policy.sh
 ima_tpm ima_tpm.sh
 ima_violations ima_violations.sh
 ima_keys ima_keys.sh
+ima_kexec ima_kexec.sh
 evm_overlay evm_overlay.sh
diff --git a/testcases/kernel/security/integrity/ima/README.md b/testcases/kernel/security/integrity/ima/README.md
index db8819a99..926eb8478 100644
--- a/testcases/kernel/security/integrity/ima/README.md
+++ b/testcases/kernel/security/integrity/ima/README.md
@@ -30,6 +30,17 @@ measure func=KEY_CHECK keyrings=key_import_test template=ima-buf
 
 The test also requires loaded policy with `func=KEY_CHECK`, see example in `keycheck.policy`.
 
+### IMA kexec test
+
+This test requires that the ima policy contains:
+```
+measure func=KEXEC_CMDLINE
+```
+
+Even though the test does not actually reboot, it does require a valid,
+signed kernel image. By default, the test will look in `/boot/vmlinuz-$(uname r)`,
+but if no image is accessible there, a valid image be must be placed at `/tmp/Image`.
+
 ## EVM tests
 
 `evm_overlay.sh` requires a builtin IMA appraise tcb policy (e.g. `ima_policy=appraise_tcb`
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh b/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
new file mode 100644
index 000000000..7d71557ee
--- /dev/null
+++ b/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
@@ -0,0 +1,93 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2020 Microsoft Corporation
+# Author: Lachlan Sneff <t-josne@linux.microsoft.com>
+#
+# Verify that kexec cmdline is measured correctly.
+
+TST_NEEDS_CMDS="kexec sed xargs printf grep"
+TST_CNT=1
+TST_NEEDS_DEVICE=1
+
+. ima_setup.sh
+
+# Since the test is executed inside some sort of
+# separate shell, *most* environment variables are
+# not accessible, so there's no way to set it from
+# the outside.
+#
+# `/boot/vmlinuz-$(uname-r)` is where the image is
+# located on many systems, but not all. Therefore,
+# if the image is not located there, require the
+# user to copy it to `/tmp/Image`.
+#
+# Ideally, this test shouldn't even require an image,
+# since it doesn't actually reboot, but the IMA cmdline
+# measurement occurs after the image is parsed and verified,
+# so we must pass a valid kernel image. There is a possiblity of
+# putting together a "faux" kernel image that has the right headers
+# and appears to be signed correctly, but doesn't actually contain any
+# code, but, after investigating that possiblity, it appears to be
+# quite difficult (and would require a new faux kernel for each arch).
+IMAGE="/boot/vmlinuz-$(uname -r)"
+if [ ! -f $IMAGE ]; then
+    IMAGE="/tmp/Image"
+fi
+
+measure() {
+    local found temp_file="file.txt" temp_file2="file2.txt" algorithm \
+        digest expected_digest
+
+    echo -n "$1" > $temp_file
+    grep "kexec-cmdline" $ASCII_MEASUREMENTS > $temp_file2
+
+    while read found
+    do
+        algorithm=$(echo "$found" | cut -d' ' -f4 | cut -d':' -f1)
+        digest=$(echo "$found" | cut -d' ' -f4 | cut -d':' -f2)
+
+        expected_digest=$(compute_digest $algorithm $temp_file)
+
+        if [ "$digest" = "$expected_digest" ]; then
+            return 0
+        fi
+    done < $temp_file2
+
+    return 1
+}
+
+# Test that the kexec cmdline is measured correctly.
+# NOTE: This does *not* actually reboot.
+test1() {
+    # Strip the `BOOT_IMAGE=...` part from the cmdline.
+    local cmdline="$(sed 's/BOOT_IMAGE=[^ ]* //' /proc/cmdline)"
+    if ! kexec -sl $IMAGE --reuse-cmdline; then
+        tst_brk TCONF "kexec failed: $?"
+    fi
+
+    if ! measure "$cmdline"; then
+        tst_brk TFAIL "kexec cmdline was measured incorrectly"
+    fi
+
+    cmdline="foo"
+    if ! kexec -sl $IMAGE --append=$cmdline; then
+        tst_brk TCONF "kexec failed: $?"
+    fi
+
+    if ! measure "$cmdline"; then
+        tst_brk TFAIL "kexec cmdline was measured incorrectly"
+    fi
+
+    cmdline="bar"
+    if ! kexec -sl $IMAGE --command-line=$cmdline; then
+        tst_brk TCONF "kexec failed: $?"
+    fi
+
+    if ! measure "$cmdline"; then
+        tst_brk TFAIL "kexec cmdline was measured incorrectly"
+    fi
+
+    tst_res TPASS "kexec cmldine was measured correctly"
+}
+
+tst_run
-- 
2.25.1


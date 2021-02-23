Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A628D323420
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Feb 2021 00:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbhBWXJq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 Feb 2021 18:09:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:52152 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233958AbhBWXAT (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Feb 2021 18:00:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 28362AF49;
        Tue, 23 Feb 2021 22:59:38 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        agk@redhat.com, snitzer@redhat.com, gmazyland@gmail.com,
        linux-integrity@vger.kernel.org, dm-devel@redhat.com,
        Petr Vorel <pvorel@suse.cz>
Subject: [PATCH v3 2/2] IMA: Add test for dm-crypt measurement
Date:   Tue, 23 Feb 2021 23:59:30 +0100
Message-Id: <20210223225930.27095-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210223225930.27095-1-pvorel@suse.cz>
References: <20210223225930.27095-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Tushar Sugandhi <tusharsu@linux.microsoft.com>

New functionality is being added to IMA to measure data provided by
kernel components. With this feature, IMA policy can be set to enable
measuring data provided by device-mapper targets. Currently one such
device-mapper target - dm-crypt, is being updated to use this
functionality. This new functionality needs test automation in LTP.

Add a testcase which verifies that the IMA subsystem correctly measures
the data coming from a device-mapper target - dm-crypt.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
[ pvorel: adapt to previous commit changes, removed template=ima-buf,
further cleanup ]
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
I wonder if $input_digest and $input_digest_found is needed to be
considered in loop. Maybe there could be return after first check when
$input_digest is passed to test_policy_measurement().

 runtest/ima                                   |  1 +
 .../kernel/security/integrity/ima/README.md   | 20 +++++++++
 .../integrity/ima/tests/ima_dm_crypt.sh       | 41 +++++++++++++++++++
 .../security/integrity/ima/tests/ima_setup.sh | 11 ++++-
 4 files changed, 72 insertions(+), 1 deletion(-)
 create mode 100755 testcases/kernel/security/integrity/ima/tests/ima_dm_crypt.sh

diff --git a/runtest/ima b/runtest/ima
index 5f4b4a7a1..123b6c8b0 100644
--- a/runtest/ima
+++ b/runtest/ima
@@ -5,4 +5,5 @@ ima_tpm ima_tpm.sh
 ima_violations ima_violations.sh
 ima_keys ima_keys.sh
 ima_kexec ima_kexec.sh
+ima_dm_crypt ima_dm_crypt.sh
 evm_overlay evm_overlay.sh
diff --git a/testcases/kernel/security/integrity/ima/README.md b/testcases/kernel/security/integrity/ima/README.md
index 68d046678..007662fae 100644
--- a/testcases/kernel/security/integrity/ima/README.md
+++ b/testcases/kernel/security/integrity/ima/README.md
@@ -37,6 +37,26 @@ see example in `kexec.policy`.
 The test attempts to kexec the existing running kernel image.
 To kexec a different kernel image export `IMA_KEXEC_IMAGE=<pathname>`.
 
+### IMA DM target (dm-crypt) measurement test
+
+To enable IMA to measure device-mapper target - dm-crypt,
+`ima_dm_crypt.sh` requires a readable IMA policy, as well as
+a loaded measure policy with
+`func=CRITICAL_DATA data_sources=dm-crypt`
+
+As well as what's required for the IMA tests, dm-crypt measurement test require
+reading the IMA policy allowed in the kernel configuration:
+```
+CONFIG_IMA_READ_POLICY=y
+```
+
+The following kernel configuration is also required. It enables compiling
+the device-mapper target module dm-crypt, which allows to create a device
+that transparently encrypts the data on it.
+```
+CONFIG_DM_CRYPT
+```
+
 ## EVM tests
 
 `evm_overlay.sh` requires a builtin IMA appraise tcb policy (e.g. `ima_policy=appraise_tcb`
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_dm_crypt.sh b/testcases/kernel/security/integrity/ima/tests/ima_dm_crypt.sh
new file mode 100755
index 000000000..b49662f73
--- /dev/null
+++ b/testcases/kernel/security/integrity/ima/tests/ima_dm_crypt.sh
@@ -0,0 +1,41 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2021 Microsoft Corporation
+# Copyright (c) 2021 Petr Vorel <pvorel@suse.cz>
+# Author: Tushar Sugandhi <tusharsu@linux.microsoft.com>
+#
+# Verify that DM target dm-crypt are measured correctly based on policy.
+
+TST_NEEDS_CMDS="dmsetup"
+TST_NEEDS_DEVICE=1
+TST_SETUP=setup
+TST_CLEANUP=cleanup
+
+. ima_setup.sh
+
+FUNC='func=CRITICAL_DATA'
+PATTERN='data_sources=[^[:space:]]+'
+REQUIRED_POLICY="^measure.*($FUNC.*$PATTERN|$PATTERN.*$FUNC)"
+
+setup()
+{
+	require_ima_policy_content "$REQUIRED_POLICY" '-E' > $TST_TMPDIR/policy.txt
+}
+
+cleanup()
+{
+	ROD "dmsetup remove test-crypt"
+}
+
+test1()
+{
+	local input_digest="039d8ff71918608d585adca3e5aab2e3f41f84d6"
+	local key="faf453b4ee938cff2f0d2c869a0b743f59125c0a37f5bcd8f1dbbd911a78abaa"
+
+	tst_res TINFO "verifying dm-crypt target measurement"
+
+	ROD dmsetup create test-crypt --table "0 1953125 crypt aes-xts-plain64 $key 0 /dev/loop0 0 1 allow_discards"
+	check_policy_measurement data_sources $TST_TMPDIR/policy.txt $input_digest
+}
+
+tst_run
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index 605db0ff6..22bb4649d 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -289,7 +289,7 @@ test_policy_measurement()
 	local input_digest="$3"
 	local test_file="$TST_TMPDIR/test.txt"
 	local grep_file="$TST_TMPDIR/grep.txt"
-	local i sources templates
+	local i input_digest_found sources templates
 
 	tst_require_cmds cut sed xxd
 
@@ -326,8 +326,17 @@ test_policy_measurement()
 			tst_res TFAIL "incorrect digest was found for $src_line $policy_option"
 			return
 		fi
+
+		if [ "$input_digest" -a "$digest" = "$input_digest" ]; then
+			input_digest_found=1
+		fi
 	done < $grep_file
 
+	if [ "$input_digest" -a "$input_digest_found" != 1 ]; then
+		tst_res TFAIL "expected digest '$input_digest' not found"
+		return
+	fi
+
 	tst_res TPASS "$policy_option measured correctly"
 }
 
-- 
2.30.1


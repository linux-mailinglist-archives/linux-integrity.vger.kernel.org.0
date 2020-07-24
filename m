Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC17422BE7A
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Jul 2020 09:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbgGXHAr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 24 Jul 2020 03:00:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:58914 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726753AbgGXHAq (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 24 Jul 2020 03:00:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 11B59ACB5;
        Fri, 24 Jul 2020 07:00:53 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Lachlan Sneff <t-josne@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        balajib@linux.microsoft.com, linux-integrity@vger.kernel.org,
        Petr Vorel <pvorel@suse.cz>
Subject: [PATCH v4 2/2] IMA: Add test for kexec cmdline measurement
Date:   Fri, 24 Jul 2020 09:00:38 +0200
Message-Id: <20200724070038.29491-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200724070038.29491-1-pvorel@suse.cz>
References: <20200724070038.29491-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Lachlan Sneff <t-josne@linux.microsoft.com>

IMA policy can be set to measure the command line passed in the kexec
system call. Add a testcase that verifies that the IMA subsystem
correctly measure the cmdline specified during a kexec.

Note that this test does not actually reboot.

Ideally, test shouldn't even require an image, since it doesn't actually
reboot, but the IMA cmdline measurement occurs after the image is parsed
and verified, so we must pass a valid kernel image.

There is a possibility of putting together a dummy kernel image that has
the right headers and appears to be signed correctly, but doesn't
actually contain any code, but, after investigating that possibility, it
appears to be quite difficult (and would require a dummy kernel for each
arch).

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Lachlan Sneff <t-josne@linux.microsoft.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

sent version with few my fixes.
@Mimi: could you please have a quick look? (I know you reviewed previous
version.)

Kind regards,
Petr

 runtest/ima                                   |   1 +
 .../kernel/security/integrity/ima/README.md   |  11 ++
 .../security/integrity/ima/tests/ima_kexec.sh | 100 ++++++++++++++++++
 3 files changed, 112 insertions(+)
 create mode 100755 testcases/kernel/security/integrity/ima/tests/ima_kexec.sh

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
index 732cd912f..f28bc8e8c 100644
--- a/testcases/kernel/security/integrity/ima/README.md
+++ b/testcases/kernel/security/integrity/ima/README.md
@@ -36,6 +36,17 @@ CONFIG_SYSTEM_TRUSTED_KEYS="/etc/keys/ima-local-ca.pem"
 
 Test also requires loaded policy with `func=KEY_CHECK`, see example in `keycheck.policy`.
 
+### IMA kexec test
+
+This test requires that the ima policy contains:
+```
+measure func=KEXEC_CMDLINE
+```
+
+Even though the test does not actually reboot, it does require a valid,
+signed kernel image (defined with `$IMA_KEXEC_IMAGE` environment variable,
+default `/boot/vmlinuz-$(uname r)`).
+
 ## EVM tests
 
 `evm_overlay.sh` requires a builtin IMA appraise tcb policy (e.g. `ima_policy=appraise_tcb`
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh b/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
new file mode 100755
index 000000000..15bbca03d
--- /dev/null
+++ b/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
@@ -0,0 +1,100 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2020 Microsoft Corporation
+# Author: Lachlan Sneff <t-josne@linux.microsoft.com>
+#
+# Verify that kexec cmdline is measured correctly.
+
+TST_NEEDS_CMDS="grep kexec sed tr xargs"
+TST_CNT=1
+TST_NEEDS_DEVICE=1
+
+. ima_setup.sh
+
+IMA_KEXEC_IMAGE="${IMA_KEXEC_IMAGE:-/boot/vmlinuz-$(uname -r)}"
+
+measure() {
+	local algorithm digest expected_digest found
+	local temp_file="file.txt" temp_file2="file2.txt"
+
+	echo -n "$1" > $temp_file
+	grep "kexec-cmdline" $ASCII_MEASUREMENTS > $temp_file2
+
+	while read found
+	do
+		algorithm=$(echo "$found" | cut -d' ' -f4 | cut -d':' -f1)
+		digest=$(echo "$found" | cut -d' ' -f4 | cut -d':' -f2)
+
+		expected_digest=$(compute_digest $algorithm $temp_file)
+
+		if [ "$digest" = "$expected_digest" ]; then
+			return 0
+		fi
+	done < $temp_file2
+
+	return 1
+}
+
+# Test that the kexec cmdline is measured correctly.
+# NOTE: This does *not* actually reboot.
+test1() {
+	if [ ! -f "$IMA_KEXEC_IMAGE" ]; then
+		tst_brk TCONF "Kernel image not found ('$IMA_KEXEC_IMAGE'), specify it in \$IMA_KEXEC_IMAGE"
+	fi
+
+	# Strip the `BOOT_IMAGE=...` part from the cmdline.
+	local cmdline="$(sed 's/BOOT_IMAGE=[^ ]* //' /proc/cmdline)"
+
+	if ! kexec -sl $IMA_KEXEC_IMAGE --reuse-cmdline; then
+		tst_res TCONF "kexec failed: $?"
+
+		local sb_status="$(bootctl status 2>/dev/null | grep 'Secure Boot' \
+			| tr -d ' ' | sed 's/SecureBoot:*//')"
+
+		if [ "$sb_status" = "enabled" ]; then
+			tst_res TINFO "secure boot is enabled, the specified kernel image may not be signed"
+		fi
+
+		return
+	fi
+
+	kexec -su
+
+	if ! measure "$cmdline"; then
+		tst_res TFAIL "unable to find a correct entry in the IMA log"
+
+		check_policy_readable
+
+		if ! grep "measure func=KEXEC_CMDLINE" $IMA_POLICY >/dev/null; then
+			tst_brk TCONF "The IMA policy does not specify 'measure func=KEXEC_CMDLINE', see IMA test README"
+		fi
+
+		return
+	fi
+
+	cmdline="foo"
+	if ! kexec -sl $IMA_KEXEC_IMAGE --append=$cmdline; then
+		tst_brk TCONF "kexec failed: $?"
+	fi
+
+	kexec -su
+
+	if ! measure "$cmdline"; then
+		tst_brk TFAIL "unable to find a correct entry in the IMA log"
+	fi
+
+	cmdline="bar"
+	if ! kexec -sl $IMA_KEXEC_IMAGE --command-line=$cmdline; then
+		tst_brk TCONF "kexec failed: $?"
+	fi
+
+	kexec -su
+
+	if ! measure "$cmdline"; then
+		tst_brk TFAIL "unable to find a correct entry in the IMA log"
+	fi
+
+	tst_res TPASS "kexec cmdline was measured correctly"
+}
+
+tst_run
-- 
2.27.0


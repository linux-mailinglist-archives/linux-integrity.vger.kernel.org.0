Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC97522FE5C
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Jul 2020 02:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgG1ANK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Jul 2020 20:13:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:35952 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726320AbgG1ANK (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Jul 2020 20:13:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0A877AC48;
        Tue, 28 Jul 2020 00:13:19 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Lachlan Sneff <t-josne@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        balajib@linux.microsoft.com, linux-integrity@vger.kernel.org,
        Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH v6 4/4] IMA: Add test for kexec cmdline measurement
Date:   Tue, 28 Jul 2020 02:13:01 +0200
Message-Id: <20200728001301.31121-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.27.0
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

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Lachlan Sneff <t-josne@linux.microsoft.com>
[ pvorel: improved setup, various LTP API cleanup ]
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v5->v6:
* move --reuse-cmdline from setup to kexec_test()

Sorry for the noise.

Kind regards,
Petr

 runtest/ima                                   |   1 +
 .../kernel/security/integrity/ima/README.md   |   8 ++
 .../integrity/ima/datafiles/kexec.policy      |   1 +
 .../security/integrity/ima/tests/ima_kexec.sh | 120 ++++++++++++++++++
 4 files changed, 130 insertions(+)
 create mode 100644 testcases/kernel/security/integrity/ima/datafiles/kexec.policy
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
index 732cd912f..d4644ba39 100644
--- a/testcases/kernel/security/integrity/ima/README.md
+++ b/testcases/kernel/security/integrity/ima/README.md
@@ -36,6 +36,14 @@ CONFIG_SYSTEM_TRUSTED_KEYS="/etc/keys/ima-local-ca.pem"
 
 Test also requires loaded policy with `func=KEY_CHECK`, see example in `keycheck.policy`.
 
+### IMA kexec test
+
+`ima_kexec.sh` requires loaded policy which contains `measure func=KEXEC_CMDLINE`,
+see example in `kexec.policy`.
+
+The test attempts to kexec the existing running kernel image.
+To kexec a different kernel image export `IMA_KEXEC_IMAGE=<pathname>`.
+
 ## EVM tests
 
 `evm_overlay.sh` requires a builtin IMA appraise tcb policy (e.g. `ima_policy=appraise_tcb`
diff --git a/testcases/kernel/security/integrity/ima/datafiles/kexec.policy b/testcases/kernel/security/integrity/ima/datafiles/kexec.policy
new file mode 100644
index 000000000..58d66369e
--- /dev/null
+++ b/testcases/kernel/security/integrity/ima/datafiles/kexec.policy
@@ -0,0 +1 @@
+measure func=KEXEC_CMDLINE
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh b/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
new file mode 100755
index 000000000..30bbd066e
--- /dev/null
+++ b/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
@@ -0,0 +1,120 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2020 Microsoft Corporation
+# Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
+# Author: Lachlan Sneff <t-josne@linux.microsoft.com>
+#
+# Verify that kexec cmdline is measured correctly.
+# Test attempts to kexec the existing running kernel image.
+# To kexec a different kernel image export IMA_KEXEC_IMAGE=<pathname>.
+
+TST_NEEDS_CMDS="grep kexec sed"
+TST_CNT=3
+TST_NEEDS_DEVICE=1
+TST_SETUP="setup"
+
+. ima_setup.sh
+
+IMA_KEXEC_IMAGE="${IMA_KEXEC_IMAGE:-/boot/vmlinuz-$(uname -r)}"
+REQUIRED_POLICY='^measure.*func=KEXEC_CMDLINE'
+
+measure()
+{
+	local cmdline="$1"
+	local algorithm digest expected_digest found
+
+	printf "$cmdline" > file1
+	grep "kexec-cmdline" $ASCII_MEASUREMENTS > file2
+
+	while read found
+	do
+		algorithm=$(echo "$found" | cut -d' ' -f4 | cut -d':' -f1)
+		digest=$(echo "$found" | cut -d' ' -f4 | cut -d':' -f2)
+
+		expected_digest=$(compute_digest $algorithm file1)
+
+		if [ "$digest" = "$expected_digest" ]; then
+			return 0
+		fi
+	done < file2
+
+	return 1
+}
+
+setup()
+{
+	tst_res TINFO "using kernel $IMA_KEXEC_IMAGE"
+
+	if [ ! -f "$IMA_KEXEC_IMAGE" ]; then
+		tst_brk TCONF "kernel image not found, specify path in \$IMA_KEXEC_IMAGE"
+	fi
+
+	if check_policy_readable; then
+		require_ima_policy_content "$REQUIRED_POLICY"
+		policy_readable=1
+	fi
+}
+
+kexec_failure_hint()
+{
+	local sb_enabled
+
+	if tst_cmd_available bootctl; then
+		if bootctl status 2>/dev/null | grep -qi 'Secure Boot: enabled'; then
+			sb_enabled=1
+		fi
+	elif tst_cmd_available dmesg; then
+		if dmesg | grep -qi 'Secure boot enabled'; then
+			sb_enabled=1
+		fi
+	fi
+	if [ "$sb_enabled" ]; then
+		tst_res TWARN "secure boot is enabled, kernel image may not be signed"
+	fi
+
+	if check_ima_policy_content '^appraise.*func=KEXEC_KERNEL_CHECK'; then
+		tst_res TWARN "'func=KEXEC_KERNEL_CHECK' appraise policy loaded, kernel image may not be signed"
+	fi
+}
+
+kexec_test()
+{
+	local param="$1"
+	local cmdline="$2"
+	local res=TFAIL
+	local kexec_cmd
+
+	kexec_cmd="$param=$cmdline"
+	if [ "$param" = '--reuse-cmdline' ]; then
+		cmdline="$(sed 's/BOOT_IMAGE=[^ ]* //' /proc/cmdline)"
+		kexec_cmd="$param"
+	fi
+
+	kexec_cmd="kexec -s -l $IMA_KEXEC_IMAGE $kexec_cmd"
+	tst_res TINFO "testing $kexec_cmd"
+	if ! $kexec_cmd 2>err; then
+		kexec_failure_hint
+		tst_brk TBROK "kexec failed: $(cat err)"
+	fi
+
+	ROD kexec -su
+	if ! measure "$cmdline"; then
+		if [ "$policy_readable" != 1 ]; then
+			tst_res TWARN "policy not readable, it might not contain required policy '$REQUIRED_POLICY'"
+			res=TBROK
+		fi
+		tst_brk $res "unable to find a correct measurement"
+	fi
+	tst_res TPASS "kexec cmdline was measured correctly"
+}
+
+test()
+{
+	case $1 in
+	1) kexec_test '--reuse-cmdline';;
+	2) kexec_test '--append' 'foo';;
+	3) kexec_test '--command-line' 'bar';;
+	esac
+}
+
+tst_run
-- 
2.27.0


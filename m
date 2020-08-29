Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1BAB2563F0
	for <lists+linux-integrity@lfdr.de>; Sat, 29 Aug 2020 03:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgH2BOi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 28 Aug 2020 21:14:38 -0400
Received: from linux.microsoft.com ([13.77.154.182]:34548 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbgH2BOg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 28 Aug 2020 21:14:36 -0400
Received: from tusharsu-Ubuntu.lan (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 910DC20B7178;
        Fri, 28 Aug 2020 18:14:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 910DC20B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1598663674;
        bh=piZlF079Lsoi43izH8zKYkRPAcXQQuvLaQgkdSyTuWo=;
        h=From:To:Cc:Subject:Date:From;
        b=IxdNBZLQ0V1j5wtR4y5ipRCJpmV9OdAPRc/vaiT11ApzsggEbNaTG63PUnoyPyEcp
         fz4sE7isOqdowXVqI9EGJHgWmAQ6jRuTTuVqAPsLfxz40hfy/i00DfO2+4HwoDRsBp
         cjUHMmSOJcTL+aWSXoggBTAihhmAXfXNTMCtaTmk=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, pvorel@suse.cz
Cc:     nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        dm-devel@redhat.com
Subject: [PATCH] IMA: Add test for dm-crypt measurement
Date:   Fri, 28 Aug 2020 18:14:27 -0700
Message-Id: <20200829011427.12893-1-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

IMA subsystem supports measuring data from other kernel components
through func=CRITICAL_DATA policy 'critical_kernel_data_sources'. 
This IMA policy can be set to measure the data coming from device-mapper
targets. This scenario needs test coverage.

Add a testcase which verifies that the IMA subsystem correctly measures
the data provided by one such DM target - dm-crypt.

This series needs a kernel built on the following repo/branch/patches:
 repo: https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
 branch: next-integrity
 commit d012a7190fc1 ("Linux 5.9-rc2") 

And the following patch series should be applied in the order below:
 1. https://patchwork.kernel.org/patch/11709527/
 2. https://patchwork.kernel.org/patch/11742047/
 3. https://patchwork.kernel.org/patch/11743265/
 4. https://patchwork.kernel.org/patch/11743715/

The kernel code required for this series (the patches above)
is still under review. This series will be ready to merge in LTP only
after the above patches are merged.

This series is based on the following commit in LTP branch:
 commit a277498c08a7 ("IMA/ima_keys.sh: Enhance policy checks") 
        
Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 runtest/ima                                   |   1 +
 .../kernel/security/integrity/ima/README.md   |  20 +++
 .../integrity/ima/tests/ima_dm_crypt.sh       | 118 ++++++++++++++++++
 3 files changed, 139 insertions(+)
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
index 68d046678..663c0b624 100644
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
+`func=CRITICAL_DATA critical_kernel_data_sources=dm-crypt`
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
index 000000000..ee572ed01
--- /dev/null
+++ b/testcases/kernel/security/integrity/ima/tests/ima_dm_crypt.sh
@@ -0,0 +1,118 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2020 Microsoft Corporation
+# Author: Tushar Sugandhi <tusharsu@linux.microsoft.com>
+#
+# Verify that DM target dm-crypt is measured correctly based on policy.
+
+TST_NEEDS_CMDS="grep cut sed tr dmsetup"
+TST_CNT=1
+TST_NEEDS_DEVICE=1
+TST_SETUP=setup
+
+. ima_setup.sh
+
+FUNC_CRIT_DATA='func=CRITICAL_DATA'
+TEMPLATE_BUF='template=ima-buf'
+REQUIRED_POLICY="^measure.*($FUNC_CRIT_DATA.*$TEMPLATE_BUF|$TEMPLATE_BUF.*$FUNC_CRIT_DATA)"
+
+setup()
+{
+	tst_res TINFO "inside setup"
+	require_ima_policy_content "$REQUIRED_POLICY" '-E' > policy.txt
+}
+
+check_dm_crypt_policy()
+{
+	local pattern="$1"
+
+	if ! grep -E "$pattern" policy.txt; then
+		tst_res TCONF "IMA policy must specify $pattern, $FUNC_CRIT_DATA, $TEMPLATE_BUF"
+		return 1
+	fi
+	return 0
+}
+
+test1()
+{
+	local dmcheck_lines i dm_targets templates
+	local policy="critical_kernel_data_sources"
+	local pattern='critical_kernel_data_sources=[^[:space:]]+'
+	local tmp_file="tmp.txt"
+	local tokens_file="tokens_file.txt" grep_file="grep_file.txt"
+	local arg cmd key tgt_name
+	local res=0
+
+	tst_res TINFO "verifying dm target - dmcrypt gets measured correctly."
+
+	check_dm_crypt_policy "$pattern" > $tmp_file || return
+
+	dmcheck_lines=$(cat $tmp_file)
+	dm_targets=$(for i in $dmcheck_lines; do echo "$i" | grep "$policy" | \
+		sed "s/\./\\\./g" | cut -d'=' -f2; done | sed ':a;N;$!ba;s/\n/|/g')
+	if [ -z "$dm_targets" ]; then
+		tst_res TCONF "IMA policy has a $policy key-value specifier, but no specified sources."
+		return
+	fi
+
+	templates=$(for i in $dmcheck_lines; do echo "$i" | grep "template" | \
+		cut -d'=' -f2; done | sed ':a;N;$!ba;s/\n/|/g')
+
+	tst_res TINFO "dm_targets: '$dm_targets'"
+	tst_res TINFO "templates: '$templates'"
+
+	tgt="crypt"
+	key="faf453b4ee938cff2f0d2c869a0b743f59125c0a37f5bcd8f1dbbd911a78abaa"
+
+	arg="'0 1953125 crypt aes-xts-plain64 "
+	arg="$arg $key 0 "
+	arg="$arg /dev/loop0 0 1 allow_discards'"
+	tgt_name="test-crypt"
+	cmd="dmsetup create $tgt_name --table $arg"
+
+	tst_res TINFO "Executing: $cmd"
+	eval $cmd
+
+	grep -E "($templates)*($dm_targets)" $ASCII_MEASUREMENTS > $grep_file
+
+	while read line
+	do
+		local act_digest exp_digest comp_digest algorithm
+
+		act_digest=$(echo "$line" | cut -d' ' -f4 | cut -d':' -f2)
+		algorithm=$(echo "$line" | cut -d' ' -f4 | cut -d':' -f1)
+		dmtgt_evtname=$(echo "$line" | cut -d' ' -f5)
+
+		echo "$line" | cut -d' ' -f6 | xxd -r -p > $tokens_file
+		plain_text=$(echo "$line" | cut -d' ' -f6 | xxd -r -p)
+
+		#expected digest for $cmd
+		exp_digest="039d8ff71918608d585adca3e5aab2e3f41f84d6"
+		comp_digest="$(compute_digest $algorithm $tokens_file)" || \
+			tst_brk TCONF "cannot compute digest for $algorithm"
+
+		if [ "$act_digest" != "$comp_digest" ]; then
+			tst_res TFAIL "Incorrect digest for ($dmtgt_evtname)."
+			tst_res TFAIL "Expected digest:($comp_digest)."
+			tst_res TFAIL "Actual digest:($act_digest)."
+			tst_res TINFO "Removing DM target $tgt_name."
+			dmsetup remove $tgt_name
+			return
+		fi
+
+		if [ "$act_digest" = "$exp_digest" ]; then
+			res=1
+		fi
+
+	done < $grep_file
+
+	if [ $res -eq 1 ]; then
+		tst_res TPASS "dm-crypt target verification passed."
+	else
+		tst_res TFAIL "dm-crypt target verification failed."
+	fi
+	tst_res TINFO "Removing DM target $tgt_name."
+	dmsetup remove $tgt_name
+}
+
+tst_run
-- 
2.17.1


Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF2DA27B5A0
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Sep 2020 21:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgI1Trg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 28 Sep 2020 15:47:36 -0400
Received: from linux.microsoft.com ([13.77.154.182]:45028 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbgI1Trg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 28 Sep 2020 15:47:36 -0400
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 17BC220B7179;
        Mon, 28 Sep 2020 12:47:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 17BC220B7179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1601322454;
        bh=KvfNIbFDMbn3S8wd56UnTg/lBGI2Dxwm7Tjj4xkV5cU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BNzcVVVs6VrASH3AFTlYisHBvYVp7ePgX6Ia/oBxpegme3C9BVhF9mzL9zAFHXn6s
         JqjFDdaxMs513plNfyeq5qvJx7sgPj6fVNIzVsbncf6MhVIvqwtBexJE/hai3n2VYd
         9gMZZBywjCXbxcc54PbwWI/qGxZxha8P+0Ii4Ezc=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     pvorel@suse.cz, zohar@linux.ibm.com,
        stephen.smalley.work@gmail.com, paul@paul-moore.com
Cc:     tusharsu@linux.microsoft.com, ltp@lists.linux.it,
        linux-integrity@vger.kernel.org
Subject: [PATCH v1 1/1] ima: Add test for selinux measurement
Date:   Mon, 28 Sep 2020 12:47:30 -0700
Message-Id: <20200928194730.20862-2-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200928194730.20862-1-nramas@linux.microsoft.com>
References: <20200928194730.20862-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

New functionality is being added to IMA to measure data provided by
kernel components. With this feature, IMA policy can be set to enable
measuring data provided by Linux Security Modules (LSM). Currently one
such LSM namely selinux is being updated to use this functionality.
This new functionality needs test automation in LTP.

Add test cases which verify that the IMA subsystem correctly measures
the data provided by selinux.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 runtest/ima                                   |   2 +
 .../kernel/security/integrity/ima/README.md   |  19 +++
 .../integrity/ima/tests/ima_selinux_policy.sh |  72 ++++++++++
 .../integrity/ima/tests/ima_selinux_state.sh  | 136 ++++++++++++++++++
 .../security/integrity/ima/tests/ima_setup.sh |  28 ++++
 5 files changed, 257 insertions(+)
 create mode 100755 testcases/kernel/security/integrity/ima/tests/ima_selinux_policy.sh
 create mode 100755 testcases/kernel/security/integrity/ima/tests/ima_selinux_state.sh

diff --git a/runtest/ima b/runtest/ima
index 123b6c8b0..8e60bf629 100644
--- a/runtest/ima
+++ b/runtest/ima
@@ -5,5 +5,7 @@ ima_tpm ima_tpm.sh
 ima_violations ima_violations.sh
 ima_keys ima_keys.sh
 ima_kexec ima_kexec.sh
+ima_selinux_state ima_selinux_state.sh
+ima_selinux_policy ima_selinux_policy.sh
 ima_dm_crypt ima_dm_crypt.sh
 evm_overlay evm_overlay.sh
diff --git a/testcases/kernel/security/integrity/ima/README.md b/testcases/kernel/security/integrity/ima/README.md
index 007662fae..c0644b083 100644
--- a/testcases/kernel/security/integrity/ima/README.md
+++ b/testcases/kernel/security/integrity/ima/README.md
@@ -37,6 +37,25 @@ see example in `kexec.policy`.
 The test attempts to kexec the existing running kernel image.
 To kexec a different kernel image export `IMA_KEXEC_IMAGE=<pathname>`.
 
+### IMA SELinux test
+
+To enable IMA to measure SELinux state and policy, `ima_selinux_policy.sh`
+and `ima_selinux_state.sh` require a readable IMA policy, as well as
+a loaded measure policy with
+`measure func=CRITICAL_DATA data_sources=selinux template=ima-buf`
+
+As well as what's required for the IMA tests, SELinux tests require reading
+the IMA policy allowed in the kernel configuration:
+```
+CONFIG_IMA_READ_POLICY=y
+
+```
+The following kernel configuration is also required. It enables compiling
+the Linux Security Module (LSM) namely SELinux.
+```
+CONFIG_SECURITY_SELINUX=y
+```
+
 ### IMA DM target (dm-crypt) measurement test
 
 To enable IMA to measure device-mapper target - dm-crypt,
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_selinux_policy.sh b/testcases/kernel/security/integrity/ima/tests/ima_selinux_policy.sh
new file mode 100755
index 000000000..c1e81bdde
--- /dev/null
+++ b/testcases/kernel/security/integrity/ima/tests/ima_selinux_policy.sh
@@ -0,0 +1,72 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2020 Microsoft Corporation
+# Author: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
+#
+# Verify measurement of selinux policy
+
+TST_NEEDS_CMDS="cut grep tail"
+TST_CNT=1
+TST_NEEDS_DEVICE=1
+TST_SETUP="setup"
+
+. ima_setup.sh
+
+FUNC_CRITICAL_DATA='func=CRITICAL_DATA'
+TEMPLATE_BUF='template=ima-buf'
+REQUIRED_POLICY="^measure.*($FUNC_CRITICAL_DATA.*$TEMPLATE_BUF|$TEMPLATE_BUF.*$FUNC_CRITICAL_DATA)"
+
+setup()
+{
+	check_selinux_state
+
+	require_ima_policy_content "$REQUIRED_POLICY" '-E' > $TST_TMPDIR/policy.txt
+}
+
+#
+# Trigger measurement of selinux constructs and verify that
+# the measured selinux policy matches the current policy loaded
+# for selinux.
+#
+test1()
+{
+	local policy_digest expected_policy_digest algorithm
+	local data_source_name="selinux"
+	local pattern="data_sources=[^[:space:]]*$data_source_name"
+	local tmp_file="$TST_TMPDIR/selinux_policy_tmp_file.txt"
+
+	check_policy_pattern "$pattern" $FUNC_CRITICAL_DATA $TEMPLATE_BUF > $tmp_file || return
+
+	tst_res TINFO "Verifying selinux policy measurement"
+
+	#
+	# Trigger a measurement by changing selinux state
+	#
+	update_selinux_state
+
+	#
+	# Verify selinux policy is measured and then validate that 
+	# the measured policy matches the policy currently loaded
+	# for selinux
+	#
+	line=$(grep -E "selinux-policy-hash" $ASCII_MEASUREMENTS | tail -1)
+	if [ -z "$line" ]; then
+		tst_res TFAIL "selinux policy not measured"
+		return
+	fi
+
+	algorithm=$(echo "$line" | cut -d' ' -f4 | cut -d':' -f1)
+	policy_digest=$(echo "$line" | cut -d' ' -f6)
+
+	expected_policy_digest="$(compute_digest $algorithm $SELINUX_FOLDER/policy)" || \
+		tst_brk TCONF "cannot compute digest for $algorithm"
+
+	if [ "$policy_digest" != "$expected_policy_digest" ]; then
+		tst_res TFAIL "Digest mismatch. Expected $expected_policy_digest, Actual $policy_digest"
+		return
+	fi
+
+	tst_res TPASS "selinux policy measured correctly"
+}
+
+tst_run
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_selinux_state.sh b/testcases/kernel/security/integrity/ima/tests/ima_selinux_state.sh
new file mode 100755
index 000000000..077de5081
--- /dev/null
+++ b/testcases/kernel/security/integrity/ima/tests/ima_selinux_state.sh
@@ -0,0 +1,136 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2020 Microsoft Corporation
+# Author: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
+#
+# Verify measurement of selinux state
+
+TST_NEEDS_CMDS="awk cut grep tail xxd"
+TST_CNT=1
+TST_NEEDS_DEVICE=1
+TST_SETUP="setup"
+
+. ima_setup.sh
+
+FUNC_CRITICAL_DATA='func=CRITICAL_DATA'
+TEMPLATE_BUF='template=ima-buf'
+REQUIRED_POLICY="^measure.*($FUNC_CRITICAL_DATA.*$TEMPLATE_BUF|$TEMPLATE_BUF.*$FUNC_CRITICAL_DATA)"
+
+setup()
+{
+	check_selinux_state
+
+	require_ima_policy_content "$REQUIRED_POLICY" '-E' > $TST_TMPDIR/policy.txt
+}
+
+#
+# Format of the measured selinux state data.
+#
+# initialized=1;enabled=1;enforcing=0;checkreqprot=1;
+# network_peer_controls=1;open_perms=1;extended_socket_class=1;
+# always_check_network=0;cgroup_seclabel=1;nnp_nosuid_transition=1;
+# genfs_seclabel_symlinks=0;
+#
+validate_policy_capabilities()
+{
+	local measured_cap measured_value expected_value inx result
+
+	result=1
+
+	#
+	# Policy capabilities flags start from "network_peer_controls"
+	# in the measured selinux state at offset 9 for 'awk'
+	#
+	inx=9
+	while [ $inx -lt 22 ]
+	do
+		measured_cap=$(echo $1 | awk -F'[=;]' -v inx="$inx" '{print $inx}')
+		inx=$(( $inx + 1 ))
+
+		measured_value=$(echo $1 | awk -F'[=;]' -v inx="$inx" '{print $inx}')
+		expected_value=$(cat "$SELINUX_FOLDER/policy_capabilities/$measured_cap")
+		if [ "$measured_value" != "$expected_value" ];then
+			tst_res TWARN "$measured_cap: Expected $expected_value, Actual $measured_value"
+			result=0
+		fi
+
+		inx=$(( $inx + 1 ))
+	done
+
+	return $result
+}
+
+#
+# Trigger measurement of selinux constructs and verify that
+# the measured selinux state matches the current selinux
+# configuration.
+#
+test1()
+{
+	local measured_data state_file="$TST_TMPDIR/selinux_state.txt"
+	local digest expected_digest algorithm
+	local enforced_value expected_enforced_value
+	local checkreqprot_value expected_checkreqprot_value
+	local data_source_name="selinux"
+	local pattern="data_sources=[^[:space:]]*$data_source_name"
+	local tmp_file="$TST_TMPDIR/selinux_state_tmp_file.txt"
+
+	tst_res TINFO "Verifying selinux state measurement"
+
+	check_policy_pattern "$pattern" $FUNC_CRITICAL_DATA $TEMPLATE_BUF > $tmp_file || return
+
+	#
+	# Trigger a measurement by changing selinux state
+	#
+	update_selinux_state
+
+	#
+	# Verify selinux state is measured and then validate the measured
+	# state matches that currently set for selinux
+	#
+	line=$(grep -E "selinux-state" $ASCII_MEASUREMENTS | tail -1)
+	if [ -z "$line" ]; then
+		tst_res TFAIL "selinux state not measured"
+		return
+	fi
+
+	digest=$(echo "$line" | cut -d' ' -f4 | cut -d':' -f2)
+	algorithm=$(echo "$line" | cut -d' ' -f4 | cut -d':' -f1)
+
+	echo "$line" | cut -d' ' -f6 | xxd -r -p > $state_file
+
+	expected_digest="$(compute_digest $algorithm $state_file)" || \
+	tst_brk TCONF "cannot compute digest for $algorithm"
+
+	if [ "$digest" != "$expected_digest" ]; then
+		tst_res TFAIL "Digest mismatch. Expected $expected_digest, Actual $digest"
+		return
+	fi
+
+	measured_data=$(cat $state_file)
+
+	enforced_value=$(echo $measured_data | awk -F'[=;]' '{print $6}')
+	expected_enforced_value=$(cat $SELINUX_FOLDER/enforce)
+	if [ "$expected_enforced_value" != "$enforced_value" ];then
+		tst_res TFAIL "enforce: Expected $expected_enforced_value, Actual $enforced_value"
+		return
+	fi
+
+	checkreqprot_value=$(echo $measured_data | awk -F'[=;]' '{print $8}')
+	expected_checkreqprot_value=$(cat $SELINUX_FOLDER/checkreqprot)
+	if [ "$expected_checkreqprot_value" != "$checkreqprot_value" ];then
+		tst_res TFAIL "checkreqprot. Expected $expected_checkreqprot_value, Actual $checkreqprot_value"
+		return
+	fi
+
+	validate_policy_capabilities $measured_data
+	result=$?
+	if [ $result = 0 ]; then
+		tst_res TFAIL "Policy capabilities did not match"
+		return
+	fi
+
+	tst_res TPASS "selinux state measured correctly"
+}
+
+tst_run
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index 2841d7df5..1d7dca086 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -186,6 +186,33 @@ require_ima_policy_cmdline()
 	tst_brk TCONF "IMA measurement tests require builtin IMA $policy policy (e.g. ima_policy=$policy kernel parameter)"
 }
 
+#
+# Update selinux state. This is used for validating IMA
+# measurement of selinux constructs.
+#
+update_selinux_state()
+{
+	local cur_val new_val
+
+	cur_val=$(cat $SELINUX_FOLDER/checkreqprot)
+
+	if [ $cur_val = 1 ]; then
+		new_val=0
+	else
+		new_val=1
+	fi
+
+	echo $new_val > $SELINUX_FOLDER/checkreqprot
+}
+
+#
+# Verify selinux is enabled in the system
+#
+check_selinux_state()
+{
+	[ -d $SELINUX_FOLDER ] || tst_brk TCONF "selinux is not enabled"
+}
+
 mount_helper()
 {
 	local type="$1"
@@ -238,6 +265,7 @@ ima_setup()
 	ASCII_MEASUREMENTS="$IMA_DIR/ascii_runtime_measurements"
 	BINARY_MEASUREMENTS="$IMA_DIR/binary_runtime_measurements"
 	IMA_POLICY="$IMA_DIR/policy"
+	SELINUX_FOLDER="$SYSFS/fs/selinux"
 
 	# hack to support running tests locally from ima/tests directory
 	if [ ! -d "$TST_DATAROOT" ]; then
-- 
2.28.0


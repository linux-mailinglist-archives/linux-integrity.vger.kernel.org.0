Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18CDD320F7B
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Feb 2021 03:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbhBVCiv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 21 Feb 2021 21:38:51 -0500
Received: from linux.microsoft.com ([13.77.154.182]:52066 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbhBVCiv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 21 Feb 2021 21:38:51 -0500
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8961920B6C40;
        Sun, 21 Feb 2021 18:38:09 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8961920B6C40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1613961489;
        bh=5KvW/s1L3KxjQMGjE8r5fo5XZtEuSl5ktw7ngrqUDIY=;
        h=From:To:Cc:Subject:Date:From;
        b=pqtExRAA5Vnm+Gk8wedQQxfVBj9GLrb2dKIOuQ/sTStiMdHOMSFQKntTA7Vj+Sr5q
         kD4DLP6+kQlcsv2L+z8mhPwoc0z/76FgNfLDaJLfzS6a+w1klFeQmxH5rgOq3m4jnO
         QNsomi5Rb28Zzkt8zX9zstZ0TOXxxHXj+FVkaqs4=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     pvorel@suse.cz, zohar@linux.ibm.com, paul@paul-moore.com,
        stephen.smalley.work@gmail.com
Cc:     tusharsu@linux.microsoft.com, ltp@lists.linux.it,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Subject: [PATCH] IMA: Add test for selinux measurement
Date:   Sun, 21 Feb 2021 18:38:05 -0800
Message-Id: <20210222023805.12846-1-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

New functionality has been added in IMA to measure data that is
critical to the integrity of the system.  SELinux uses this feature
to measure the hash of the SELinux policy loaded in kernel memory,
and the current state of various SELinux configuration.  This new
functionality needs test automation in LTP.

Add test cases which verify that the IMA subsystem correctly
measures the data provided by SELinux.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
This patch is based on commit c7c4cd5e7f3b
("tst_security.sh: Add SELinux helpers")
in https://github.com/pevik/ltp/commits/ima/selinux.v2.draft
in branch ima/selinux.v2.draft.

 runtest/ima                                   |   1 +
 .../kernel/security/integrity/ima/README.md   |  19 ++
 .../security/integrity/ima/datafiles/Makefile |   2 +-
 .../ima/datafiles/ima_selinux/Makefile        |  11 ++
 .../ima/datafiles/ima_selinux/selinux.policy  |   1 +
 .../integrity/ima/tests/ima_selinux.sh        | 180 ++++++++++++++++++
 6 files changed, 213 insertions(+), 1 deletion(-)
 create mode 100644 testcases/kernel/security/integrity/ima/datafiles/ima_selinux/Makefile
 create mode 100644 testcases/kernel/security/integrity/ima/datafiles/ima_selinux/selinux.policy
 create mode 100755 testcases/kernel/security/integrity/ima/tests/ima_selinux.sh

diff --git a/runtest/ima b/runtest/ima
index 5f4b4a7a1..29caa034a 100644
--- a/runtest/ima
+++ b/runtest/ima
@@ -5,4 +5,5 @@ ima_tpm ima_tpm.sh
 ima_violations ima_violations.sh
 ima_keys ima_keys.sh
 ima_kexec ima_kexec.sh
+ima_selinux ima_selinux.sh
 evm_overlay evm_overlay.sh
diff --git a/testcases/kernel/security/integrity/ima/README.md b/testcases/kernel/security/integrity/ima/README.md
index 68d046678..8f2249767 100644
--- a/testcases/kernel/security/integrity/ima/README.md
+++ b/testcases/kernel/security/integrity/ima/README.md
@@ -37,6 +37,25 @@ see example in `kexec.policy`.
 The test attempts to kexec the existing running kernel image.
 To kexec a different kernel image export `IMA_KEXEC_IMAGE=<pathname>`.
 
+### IMA SELinux test
+
+To enable IMA to measure SELinux state and policy, `ima_selinux.sh`
+requires a readable IMA policy, as well as a loaded measure policy with
+`measure func=CRITICAL_DATA label=selinux`,
+see example in `selinux.policy`.
+
+As well as what's required for the IMA tests, SELinux tests require reading
+the IMA policy allowed in the kernel configuration:
+```
+CONFIG_IMA_READ_POLICY=y
+```
+
+The following kernel configuration is also required. It enables compiling
+the Linux Security Module (LSM) namely SELinux.
+```
+CONFIG_SECURITY_SELINUX=y
+```
+
 ## EVM tests
 
 `evm_overlay.sh` requires a builtin IMA appraise tcb policy (e.g. `ima_policy=appraise_tcb`
diff --git a/testcases/kernel/security/integrity/ima/datafiles/Makefile b/testcases/kernel/security/integrity/ima/datafiles/Makefile
index 47a470416..280175b17 100644
--- a/testcases/kernel/security/integrity/ima/datafiles/Makefile
+++ b/testcases/kernel/security/integrity/ima/datafiles/Makefile
@@ -26,6 +26,6 @@ top_srcdir	?= ../../../../../..
 
 include	$(top_srcdir)/include/mk/env_pre.mk
 
-SUBDIRS	:= ima_kexec ima_keys ima_policy
+SUBDIRS	:= ima_kexec ima_keys ima_policy ima_selinux
 
 include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/kernel/security/integrity/ima/datafiles/ima_selinux/Makefile b/testcases/kernel/security/integrity/ima/datafiles/ima_selinux/Makefile
new file mode 100644
index 000000000..35088fdbc
--- /dev/null
+++ b/testcases/kernel/security/integrity/ima/datafiles/ima_selinux/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) Linux Test Project, 2021
+
+top_srcdir	?= ../../../../../../..
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+
+INSTALL_DIR		:= testcases/data/ima_selinux
+INSTALL_TARGETS	:= *.policy
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/security/integrity/ima/datafiles/ima_selinux/selinux.policy b/testcases/kernel/security/integrity/ima/datafiles/ima_selinux/selinux.policy
new file mode 100644
index 000000000..7cbe9352d
--- /dev/null
+++ b/testcases/kernel/security/integrity/ima/datafiles/ima_selinux/selinux.policy
@@ -0,0 +1 @@
+measure func=CRITICAL_DATA label=selinux
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh b/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
new file mode 100755
index 000000000..e5060a5e3
--- /dev/null
+++ b/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
@@ -0,0 +1,180 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2021 Microsoft Corporation
+# Author: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
+#
+# Verify measurement of SELinux policy hash and state.
+
+TST_NEEDS_CMDS="awk cut grep tail"
+TST_CNT=2
+TST_NEEDS_DEVICE=1
+TST_SETUP="setup"
+
+. ima_setup.sh
+
+FUNC_CRITICAL_DATA='func=CRITICAL_DATA'
+REQUIRED_POLICY="^measure.*($FUNC_CRITICAL_DATA)"
+
+setup()
+{
+	SELINUX_DIR=$(tst_get_selinux_dir)
+	if [ -z "$SELINUX_DIR" ]; then
+		tst_brk TCONF "SELinux is not enabled"
+		return
+	fi
+	require_ima_policy_content "$REQUIRED_POLICY" '-E' > $TST_TMPDIR/policy.txt
+}
+
+# Format of the measured SELinux state data.
+#
+# initialized=1;enforcing=0;checkreqprot=1;
+# network_peer_controls=1;open_perms=1;extended_socket_class=1;
+# always_check_network=0;cgroup_seclabel=1;nnp_nosuid_transition=1;
+# genfs_seclabel_symlinks=0;
+validate_policy_capabilities()
+{
+	local measured_cap measured_value expected_value
+	local result=1
+	local inx=7
+
+	# Policy capabilities flags start from "network_peer_controls"
+	# in the measured SELinux state at offset 7 for 'awk'
+	while [ $inx -lt 20 ]; do
+		measured_cap=$(echo $1 | awk -F'[=;]' -v inx="$inx" '{print $inx}')
+		inx=$(( $inx + 1 ))
+
+		measured_value=$(echo $1 | awk -F'[=;]' -v inx="$inx" '{print $inx}')
+		expected_value=$(cat "$SELINUX_DIR/policy_capabilities/$measured_cap")
+		if [ "$measured_value" != "$expected_value" ];then
+			tst_res TWARN "$measured_cap: expected: $expected_value, got: $digest"
+			result=0
+		fi
+
+		inx=$(( $inx + 1 ))
+	done
+
+	return $result
+}
+
+# Trigger measurement of SELinux constructs and verify that
+# the measured SELinux policy hash matches the hash of the policy
+# loaded in kernel memory for SELinux.
+test1()
+{
+	local policy_digest expected_policy_digest algorithm
+	local data_source_name="selinux"
+	local pattern="data_sources=[^[:space:]]*$data_source_name"
+	local tmp_file="$TST_TMPDIR/selinux_policy_tmp_file.txt"
+
+	tst_res TINFO "verifying SELinux policy hash measurement"
+
+	# Trigger a measurement by changing SELinux state
+	tst_update_selinux_state
+
+	# Verify SELinux policy hash is measured and then validate that
+	# the measured policy hash matches the hash of the policy currently
+	# in kernel memory for SELinux
+	line=$(grep -E "selinux-policy-hash" $ASCII_MEASUREMENTS | tail -1)
+	if [ -z "$line" ]; then
+		tst_res TFAIL "SELinux policy hash not measured"
+		return
+	fi
+
+	algorithm=$(echo "$line" | cut -d' ' -f4 | cut -d':' -f1)
+	policy_digest=$(echo "$line" | cut -d' ' -f6)
+
+	expected_policy_digest="$(compute_digest $algorithm $SELINUX_DIR/policy)" || \
+		tst_brk TCONF "cannot compute digest for $algorithm"
+
+	if [ "$policy_digest" != "$expected_policy_digest" ]; then
+		tst_res TFAIL "Digest mismatch: expected: $expected_policy_digest, got: $policy_digest"
+		return
+	fi
+
+	tst_res TPASS "SELinux policy hash measured correctly"
+}
+
+# Trigger measurement of SELinux constructs and verify that
+# the measured SELinux state matches the current SELinux
+# configuration.
+test2()
+{
+	tst_check_cmds xxd || return
+
+	local measured_data state_file="$TST_TMPDIR/selinux_state.txt"
+	local data_source_name="selinux"
+	local pattern="data_sources=[^[:space:]]*$data_source_name"
+	local tmp_file="$TST_TMPDIR/selinux_state_tmp_file.txt"
+	local digest expected_digest algorithm
+	local initialized_value
+	local enforced_value expected_enforced_value
+	local checkreqprot_value expected_checkreqprot_value
+	local result
+
+	tst_res TINFO "verifying SELinux state measurement"
+
+	# Trigger a measurement by changing SELinux state
+	tst_update_selinux_state
+
+	# Verify SELinux state is measured and then validate the measured
+	# state matches that currently set for SELinux
+	line=$(grep -E "selinux-state" $ASCII_MEASUREMENTS | tail -1)
+	if [ -z "$line" ]; then
+		tst_res TFAIL "SELinux state not measured"
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
+		tst_res TFAIL "digest mismatch: expected: $expected_digest, got: $digest"
+		return
+	fi
+
+	# SELinux state is measured as the following string
+	#   initialized=1;enforcing=0;checkreqprot=1;
+	# Value of 0 indicates the state is ON, and 1 indicates OFF
+	#
+	# enforce and checkreqprot measurement can be verified by
+	# comparing the value of the file "enforce" and "checkreqprot"
+	# respectively in the SELinux directory.
+	# "initialized" is an internal state and should be set to 1
+	# if enforce and checkreqprot are measured correctly.
+	measured_data=$(cat $state_file)
+	enforced_value=$(echo $measured_data | awk -F'[=;]' '{print $4}')
+	expected_enforced_value=$(cat $SELINUX_DIR/enforce)
+	if [ "$expected_enforced_value" != "$enforced_value" ];then
+		tst_res TFAIL "enforce: expected: $expected_enforced_value, got: $enforced_value"
+		return
+	fi
+
+	checkreqprot_value=$(echo $measured_data | awk -F'[=;]' '{print $6}')
+	expected_checkreqprot_value=$(cat $SELINUX_DIR/checkreqprot)
+	if [ "$expected_checkreqprot_value" != "$checkreqprot_value" ];then
+		tst_res TFAIL "checkreqprot: expected: $expected_checkreqprot_value, got: $checkreqprot_value"
+		return
+	fi
+
+	initialized_value=$(echo $measured_data | awk -F'[=;]' '{print $2}')
+	if [ "$initialized_value" != "1" ];then
+		tst_res TFAIL "initialized: expected 1, got: $initialized_value"
+		return
+	fi
+
+	validate_policy_capabilities $measured_data
+	result=$?
+	if [ $result = 0 ]; then
+		tst_res TFAIL "policy capabilities did not match"
+		return
+	fi
+
+	tst_res TPASS "SELinux state measured correctly"
+}
+
+tst_run
-- 
2.30.0


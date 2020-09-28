Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1570B27A608
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Sep 2020 05:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgI1D4U (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 27 Sep 2020 23:56:20 -0400
Received: from linux.microsoft.com ([13.77.154.182]:39246 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgI1D4U (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 27 Sep 2020 23:56:20 -0400
Received: from tusharsu-Ubuntu.lan (c-71-197-163-6.hsd1.wa.comcast.net [71.197.163.6])
        by linux.microsoft.com (Postfix) with ESMTPSA id 73DD9208ABC7;
        Sun, 27 Sep 2020 20:56:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 73DD9208ABC7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1601265379;
        bh=rzh9do29mmz5gxBiNXt0gG2p7pXuvKOF0Ny99h/ur8o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S+ur5vCfr4zMrfzvWHeoy9ro+gwLce9UZ0zvY+d69GNtc5cnHfEgjfx8lZQJWoRkE
         dMtizeiTeu4zbjfz57Fpq4vXEysjsn6QVzFaYmKBp9Oo2q6HHiGfr4ZcWX2avFzIY9
         ESM+6vBee947haVG4G2oWmzN+HMK2IrwJFbOBWxM=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, pvorel@suse.cz
Cc:     nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        dm-devel@redhat.com, ltp@lists.linux.it
Subject: [PATCH v2 2/2] IMA: Add test for dm-crypt measurement
Date:   Sun, 27 Sep 2020 20:56:05 -0700
Message-Id: <20200928035605.22701-3-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200928035605.22701-1-tusharsu@linux.microsoft.com>
References: <20200928035605.22701-1-tusharsu@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

New functionality is being added to IMA to measure data provided by
kernel components. With this feature, IMA policy can be set to enable
measuring data provided by device-mapper targets. Currently one such
device-mapper target - dm-crypt, is being updated to use this
functionality. This new functionality needs test automation in LTP.

Add a testcase which verifies that the IMA subsystem correctly measures
the data coming from a device-mapper target - dm-crypt.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
---
 runtest/ima                                   |  1 +
 .../kernel/security/integrity/ima/README.md   | 20 +++++++
 .../integrity/ima/tests/ima_dm_crypt.sh       | 60 +++++++++++++++++++
 3 files changed, 81 insertions(+)
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
index 000000000..396033f8d
--- /dev/null
+++ b/testcases/kernel/security/integrity/ima/tests/ima_dm_crypt.sh
@@ -0,0 +1,60 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2020 Microsoft Corporation
+# Author: Tushar Sugandhi <tusharsu@linux.microsoft.com>
+#
+# Verify that DM target dm-crypt are measured correctly based on policy.
+
+TST_NEEDS_CMDS="dmsetup"
+TST_CNT=1
+TST_NEEDS_DEVICE=1
+TST_SETUP=setup
+TST_CLEANUP=cleanup
+
+. ima_setup.sh
+
+FUNC_CRIT_DATA='func=CRITICAL_DATA'
+TEMPLATE_BUF='template=ima-buf'
+REQUIRED_POLICY="^measure.*($FUNC_CRIT_DATA.*$TEMPLATE_BUF|$TEMPLATE_BUF.*$FUNC_CRIT_DATA)"
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
+	local pattern='data_sources=[^[:space:]]+'
+	local tmp_file="$TST_TMPDIR/dm_crypt_tmp.txt"
+	local policy="data_sources"
+	local arg key res
+
+	tst_res TINFO "verifying dm target - dmcrypt gets measured correctly"
+
+	check_policy_pattern "$pattern" $FUNC_CRIT_DATA $TEMPLATE_BUF > $tmp_file || return
+
+	tgt="crypt"
+	key="faf453b4ee938cff2f0d2c869a0b743f59125c0a37f5bcd8f1dbbd911a78abaa"
+
+	arg="'0 1953125 crypt aes-xts-plain64 "
+	arg="$arg $key 0 "
+	arg="$arg /dev/loop0 0 1 allow_discards'"
+
+	ROD "dmsetup create test-crypt --table $arg"
+
+	res="$(check_ima_ascii_log_for_policy $policy $tmp_file $input_digest)"
+
+	if [ $res = "0" ]; then
+		tst_res TPASS "dm-crypt target verification passed"
+	else
+		tst_res TFAIL "dm-crypt target verification failed"
+	fi
+}
+
+tst_run
-- 
2.17.1


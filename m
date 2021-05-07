Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02CC1376A8E
	for <lists+linux-integrity@lfdr.de>; Fri,  7 May 2021 21:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbhEGTP0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 7 May 2021 15:15:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:54982 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229512AbhEGTPX (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 7 May 2021 15:15:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0D4A1B164;
        Fri,  7 May 2021 19:14:22 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, Petr Vorel <pvorel@suse.cz>
Subject: [PATCH v4 3/3] IMA: Add test for dm-crypt measurement
Date:   Fri,  7 May 2021 21:14:14 +0200
Message-Id: <20210507191414.14795-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210507191414.14795-1-pvorel@suse.cz>
References: <20210507191414.14795-1-pvorel@suse.cz>
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
[ pvorel: rebased: removed template=ima-buf, added policy example, cleanup ]
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
The same as in v3.

 .../kernel/security/integrity/ima/README.md   | 20 ++++++++
 .../security/integrity/ima/datafiles/Makefile |  2 +-
 .../ima/datafiles/ima_dm_crypt/Makefile       | 11 +++++
 .../ima_dm_crypt/ima_dm_crypt.policy          |  1 +
 .../integrity/ima/tests/ima_dm_crypt.sh       | 47 +++++++++++++++++++
 5 files changed, 80 insertions(+), 1 deletion(-)
 create mode 100644 testcases/kernel/security/integrity/ima/datafiles/ima_dm_crypt/Makefile
 create mode 100644 testcases/kernel/security/integrity/ima/datafiles/ima_dm_crypt/ima_dm_crypt.policy
 create mode 100755 testcases/kernel/security/integrity/ima/tests/ima_dm_crypt.sh

diff --git a/testcases/kernel/security/integrity/ima/README.md b/testcases/kernel/security/integrity/ima/README.md
index 5b261a191..767d98a22 100644
--- a/testcases/kernel/security/integrity/ima/README.md
+++ b/testcases/kernel/security/integrity/ima/README.md
@@ -65,6 +65,26 @@ CONFIG_SECURITY_SELINUX=y
 CONFIG_IMA_READ_POLICY=y
 ```
 
+### IMA DM target (dm-crypt) measurement test
+
+To enable IMA to measure device-mapper target - dm-crypt,
+`ima_dm_crypt.sh` requires a readable IMA policy, as well as
+a loaded measure policy with `func=CRITICAL_DATA data_sources=dm-crypt`,
+see example in `ima_dm_crypt.policy`.
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
diff --git a/testcases/kernel/security/integrity/ima/datafiles/Makefile b/testcases/kernel/security/integrity/ima/datafiles/Makefile
index 280175b17..eef857c41 100644
--- a/testcases/kernel/security/integrity/ima/datafiles/Makefile
+++ b/testcases/kernel/security/integrity/ima/datafiles/Makefile
@@ -26,6 +26,6 @@ top_srcdir	?= ../../../../../..
 
 include	$(top_srcdir)/include/mk/env_pre.mk
 
-SUBDIRS	:= ima_kexec ima_keys ima_policy ima_selinux
+SUBDIRS	:= ima_dm_crypt ima_kexec ima_keys ima_policy
 
 include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/kernel/security/integrity/ima/datafiles/ima_dm_crypt/Makefile b/testcases/kernel/security/integrity/ima/datafiles/ima_dm_crypt/Makefile
new file mode 100644
index 000000000..d9efdce3f
--- /dev/null
+++ b/testcases/kernel/security/integrity/ima/datafiles/ima_dm_crypt/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) Linux Test Project, 2021
+
+top_srcdir	?= ../../../../../../..
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+
+INSTALL_DIR		:= testcases/data/ima_dm_crypt
+INSTALL_TARGETS	:= *.policy
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/security/integrity/ima/datafiles/ima_dm_crypt/ima_dm_crypt.policy b/testcases/kernel/security/integrity/ima/datafiles/ima_dm_crypt/ima_dm_crypt.policy
new file mode 100644
index 000000000..226b6a4b7
--- /dev/null
+++ b/testcases/kernel/security/integrity/ima/datafiles/ima_dm_crypt/ima_dm_crypt.policy
@@ -0,0 +1 @@
+measure func=CRITICAL_DATA data_sources=dm-crypt template=ima-buf
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_dm_crypt.sh b/testcases/kernel/security/integrity/ima/tests/ima_dm_crypt.sh
new file mode 100755
index 000000000..5c4842245
--- /dev/null
+++ b/testcases/kernel/security/integrity/ima/tests/ima_dm_crypt.sh
@@ -0,0 +1,47 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2021 Microsoft Corporation
+# Copyright (c) 2021 Petr Vorel <pvorel@suse.cz>
+# Author: Tushar Sugandhi <tusharsu@linux.microsoft.com>
+#
+# Verify that DM target dm-crypt are measured correctly based on policy.
+#
+# fdd1ffe8a812 ("selinux: include a consumer of the new IMA critical data hook")
+# from v5.12
+
+TST_NEEDS_CMDS="dmsetup"
+TST_NEEDS_DEVICE=1
+TST_SETUP=setup
+TST_CLEANUP=cleanup
+
+. ima_setup.sh
+
+POLICY_FUNC='func=CRITICAL_DATA'
+PATTERN='data_sources=[^[:space:]]+'
+REQUIRED_POLICY="^measure.*($FUNC.*$PATTERN|$PATTERN.*$FUNC)"
+POLICY_FILE="$TST_TMPDIR/policy.txt"
+
+setup()
+{
+	require_ima_policy_content "$REQUIRED_POLICY" '-E' > $POLICY_FILE
+	require_valid_policy_template $FUNC $POLICY_FILE
+}
+
+cleanup()
+{
+	[ "$dmsetup_run" ] || return
+	dmsetup remove test-crypt
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
+	check_policy_measurement $policy $POLICY_FILE $input_digest
+}
+
+tst_run
-- 
2.31.1


Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA40523AC0F
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Aug 2020 19:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgHCR7s (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 Aug 2020 13:59:48 -0400
Received: from linux.microsoft.com ([13.77.154.182]:58026 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728722AbgHCR7q (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 Aug 2020 13:59:46 -0400
Received: from localhost.localdomain (c-73-187-218-229.hsd1.pa.comcast.net [73.187.218.229])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9EBCD20B490F;
        Mon,  3 Aug 2020 10:59:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9EBCD20B490F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1596477584;
        bh=DLvQ4C4TeXE4TD6ysUpuenrcARQ84MejV5TONMhUnOQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qfQ1LSmmZ8/k3JqDhJxLLB1/zXKEWkoSw4a4ZSF9WUQuMUEd7EHGtkuoborqliORi
         0Hx25hi+6x7eF/iEt37cmgfuUY4/SIj3RwIiyK8hB0OTMbUWrUEpGtzKaB/RaSGngO
         KLZPmUSHvTU007gvyeaALU+ucYRoBmk8b2Zbq+jw=
From:   Lachlan Sneff <t-josne@linux.microsoft.com>
To:     pvorel@suse.cz, zohar@linux.ibm.com, ltp@lists.linux.it
Cc:     nramas@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org, tytyhicks@linux.microsoft.com,
        yaneurabeya@gmail.com, zhang.jia@linux.alibaba.com
Subject: [PATCH 3/3] IMA: Add a test to verify measurement of certificate imported into a keyring
Date:   Mon,  3 Aug 2020 13:59:04 -0400
Message-Id: <20200803175904.40269-4-t-josne@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200803175904.40269-1-t-josne@linux.microsoft.com>
References: <20200803175904.40269-1-t-josne@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The IMA subsystem supports measuring certificates that have been
imported into either system built-in or user-defined keyrings.
A test to verify measurement of a certificate imported
into a keyring is required.

Add an IMA measurement test that verifies that an x509 certificate
can be imported into a newly-created, user-defined keyring and measured
correctly by the IMA subsystem.

A certificate used by the test is included in the `datafiles/keys`
directory.

There can be restrictions on importing a certificate into a builtin
trusted keyring. For example, the `.ima` keyring requires that
imported certs be signed by a kernel private key in certain
kernel configurations. For this reason, this test defines
a user-defined keyring and imports a certificate into that.

Signed-off-by: Lachlan Sneff <t-josne@linux.microsoft.com>
---
 .../kernel/security/integrity/ima/README.md   |  14 ++++++
 .../security/integrity/ima/datafiles/Makefile |   2 +-
 .../integrity/ima/datafiles/keys/Makefile     |  15 ++++++
 .../integrity/ima/datafiles/keys/x509_ima.der | Bin 0 -> 650 bytes
 .../security/integrity/ima/tests/ima_keys.sh  |  44 +++++++++++++++++-
 5 files changed, 72 insertions(+), 3 deletions(-)
 create mode 100644 testcases/kernel/security/integrity/ima/datafiles/keys/Makefile
 create mode 100644 testcases/kernel/security/integrity/ima/datafiles/keys/x509_ima.der

diff --git a/testcases/kernel/security/integrity/ima/README.md b/testcases/kernel/security/integrity/ima/README.md
index 2956ac7fd..bfa015191 100644
--- a/testcases/kernel/security/integrity/ima/README.md
+++ b/testcases/kernel/security/integrity/ima/README.md
@@ -23,6 +23,20 @@ Mandatory kernel configuration for IMA:
 ```
 CONFIG_IMA_READ_POLICY=y
 ```
+The certificate import test in `ima_keys.sh` also requires that
+the `key_import_test` keyring is specified in the IMA policy.
+
+One way to do this is to modify an existing KEY_CHECK entry
+in the IMA policy by adding `key_import_test` for keyrings:
+```
+measure func=KEY_CHECK keyrings=.ima|.evm|key_import_test template=ima-buf
+```
+
+If KEY_CHECK entry does not exist in the IMA policy then by adding
+the following line:
+```
+measure func=KEY_CHECK keyrings=key_import_test template=ima-buf
+```
 
 ### IMA kexec test
 
diff --git a/testcases/kernel/security/integrity/ima/datafiles/Makefile b/testcases/kernel/security/integrity/ima/datafiles/Makefile
index 3772e9a03..4b4c46b82 100644
--- a/testcases/kernel/security/integrity/ima/datafiles/Makefile
+++ b/testcases/kernel/security/integrity/ima/datafiles/Makefile
@@ -24,6 +24,6 @@ top_srcdir		?= ../../../../../..
 
 include	$(top_srcdir)/include/mk/env_pre.mk
 
-SUBDIRS			:= policy
+SUBDIRS			:= policy keys
 
 include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/kernel/security/integrity/ima/datafiles/keys/Makefile b/testcases/kernel/security/integrity/ima/datafiles/keys/Makefile
new file mode 100644
index 000000000..a8ab7a1b5
--- /dev/null
+++ b/testcases/kernel/security/integrity/ima/datafiles/keys/Makefile
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2020 Microsoft Corporation
+# Author: Lachlan Sneff <t-josne@linux.microsoft.com>
+#
+# IMA datafiles/keys Makefile
+
+top_srcdir		?= ../../../../../../..
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+
+INSTALL_DIR		:= testcases/data/ima_keys
+
+INSTALL_TARGETS		:= x509_ima.der
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/security/integrity/ima/datafiles/keys/x509_ima.der b/testcases/kernel/security/integrity/ima/datafiles/keys/x509_ima.der
new file mode 100644
index 0000000000000000000000000000000000000000..92be058da22adffa9d6b6e51efa0c737ebbbbdcd
GIT binary patch
literal 650
zcmXqLVrnyJVtl`VnTe5!NhJD#vj69`9|BBf8}FEsx@^_9$Clp>c-c6$+C196^D;7W
zvoaV27z!HjvoVLVaPe?t<QJFZCFZ6YN*hRmgqV4R$}{p4b2Al+Gt=`j^U@WvQ!5SS
z3}oO&a59SVLzFncG#ki?^BP(jSQr@@7#Ud_7)6Qm8W{k&hEOgIY;2s5>?=lA2Ij_I
z27|^<rp88wchfeduxmMW^j9qUxkIugeev4q7u7yrJR_rW$*!>VOo=tim8DK0r^FsU
zl)K`}`+CO4@4KBkoLmcj?fH`%wbDvU<d=4Z>6-SMf6Eh}{&)1rdsOoNQ-1fgBQ1t{
zVTqGwuK95LlFE)6i{@=vlP6!2`Y}x<BF&oXU_nlDxy@C+CNp&=W=00a#jys_20XwZ
zl@(@W{LjK<z+k`);_<VvFf*|?7|4P+d@N!tBCNWX-0#?!UAx9s`mgFmW+nI2#6kmk
zkhC(3gn?Lt$m4W@56wQ)?QVKW<nOtpT)HJrB?Q^`z&K?FdV8b(y8m)~mOOvswu^9m
z-o7mOwCAzaT*~`Y4wxFtmNA_89`W;j{r#iww*5OC5vgEziqD_%=ki$*`;s}`Pfwi{
zbotZ0X`ckHOmaVLm85n@E9hN_K;~PUB>DFAzh(;(UoMln9V>g;W#-LUGS7A`nYQKY
WBem{7L5JThS+;$vggi%(*E;~nlJ80Y

literal 0
HcmV?d00001

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
index 3aea26056..f34f40132 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
@@ -6,9 +6,10 @@
 #
 # Verify that keys are measured correctly based on policy.
 
-TST_NEEDS_CMDS="cut grep sed tr xxd"
-TST_CNT=1
+TST_NEEDS_CMDS="grep cut sed tr xxd evmctl openssl keyctl"
+TST_CNT=2
 TST_NEEDS_DEVICE=1
+TST_NEEDS_ROOT=1
 
 . ima_setup.sh
 
@@ -58,4 +59,43 @@ test1()
 	tst_res TPASS "specified keyrings were measured correctly"
 }
 
+# Create a new keyring, import a certificate into it, and verify
+# that the certificate is measured correctly by IMA.
+test2() {
+	local new_keyring_id temp_file="file.txt" \
+		cert_file="$TST_DATAROOT/x509_ima.der"
+
+	if ! check_ima_policy_content '^measure.*func=KEY_CHECK.*keyrings=.*key_import_test'; then
+		tst_brk TCONF "the IMA policy does not include the key_import_test keyring. See the LTP IMA README."
+	fi
+
+	# Assuming this test is executed in a separate shell,
+	# create a new session that will be cleaned up when
+	# the shell exits.
+	keyctl new_session > /dev/null
+
+	new_keyring_id=$(keyctl newring key_import_test @s) || \
+		tst_brk TCONF "unable to create a new keyring"
+
+	tst_is_num "$new_keyring_id" || \
+		tst_brk TCONF "unable to parse the new keyring id"
+
+	evmctl import "$cert_file" "$new_keyring_id" > /dev/null || \
+		tst_brk TCONF "unable to import a cert into a the key_import_test keyring"
+
+	grep "key_import_test" "$ASCII_MEASUREMENTS" | tail -n1 | cut -d' ' -f6 | \
+		xxd -r -p > "$temp_file" || \
+		tst_brk TCONF "keyring not found in $ASCII_MEASUREMENTS"
+
+	if ! openssl x509 -in "$temp_file" -inform der > /dev/null; then
+		tst_brk TCONF "the cert logged in $ASCII_MEASUREMENTS is not a valid x509 certificate"
+	fi
+
+	if cmp -s "$temp_file" "$cert_file"; then
+		tst_res TPASS "logged cert matches original cert"
+	else
+		tst_res TFAIL "logged cert does not match original cert"
+	fi
+}
+
 tst_run
-- 
2.25.1


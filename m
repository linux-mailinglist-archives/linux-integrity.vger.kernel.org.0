Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE5A376A8C
	for <lists+linux-integrity@lfdr.de>; Fri,  7 May 2021 21:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbhEGTP0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 7 May 2021 15:15:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:54960 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229488AbhEGTPW (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 7 May 2021 15:15:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D00C7B040;
        Fri,  7 May 2021 19:14:21 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v4 2/3] IMA: Generalize key measurement tests
Date:   Fri,  7 May 2021 21:14:13 +0200
Message-Id: <20210507191414.14795-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210507191414.14795-1-pvorel@suse.cz>
References: <20210507191414.14795-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Based on previous Tushar's work.

Co-developed-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Rewritten

 .../security/integrity/ima/tests/ima_keys.sh  | 78 +++----------------
 .../security/integrity/ima/tests/ima_setup.sh | 76 +++++++++++++++++-
 2 files changed, 87 insertions(+), 67 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
index 3476b8007..571f72d2d 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
@@ -6,7 +6,7 @@
 #
 # Verify that keys are measured correctly based on policy.
 
-TST_NEEDS_CMDS="cmp cut grep sed xxd"
+TST_NEEDS_CMDS="cmp cut grep xxd"
 TST_CNT=2
 TST_NEEDS_DEVICE=1
 TST_SETUP=setup
@@ -14,13 +14,14 @@ TST_CLEANUP=cleanup
 
 . ima_setup.sh
 
-FUNC_KEYCHECK='func=KEY_CHECK'
-REQUIRED_POLICY="^measure.*$FUNC_KEYCHECK"
+POLICY_FUNC='func=KEY_CHECK'
+REQUIRED_POLICY="^measure.*$POLICY_FUNC"
+POLICY_FILE="$TST_TMPDIR/policy.txt"
 
 setup()
 {
-	require_ima_policy_content "$REQUIRED_POLICY" '-E' > $TST_TMPDIR/policy.txt
-	require_valid_policy_template
+	require_ima_policy_content "$REQUIRED_POLICY" '-E' > $POLICY_FILE
+	require_valid_policy_template $FUNC $POLICY_FILE
 }
 
 cleanup()
@@ -28,74 +29,19 @@ cleanup()
 	tst_is_num $KEYRING_ID && keyctl clear $KEYRING_ID
 }
 
-
-require_valid_policy_template()
-{
-	while read line; do
-	if echo $line | grep -q 'template=' && ! echo $line | grep -q 'template=ima-buf'; then
-		tst_brk TCONF "only template=ima-buf can be specified for KEY_CHECK"
-	fi
-	done < $TST_TMPDIR/policy.txt
-}
-
-check_keys_policy()
-{
-	local pattern="$1"
-
-	if ! grep -E "$pattern" $TST_TMPDIR/policy.txt; then
-		tst_res TCONF "IMA policy must specify $pattern, $FUNC_KEYCHECK"
-		return 1
-	fi
-	return 0
-}
-
 # Based on https://lkml.org/lkml/2019/12/13/564.
 # (450d0fd51564 - "IMA: Call workqueue functions to measure queued keys")
 test1()
 {
 	local keycheck_lines i keyrings templates
 	local pattern='keyrings=[^[:space:]]+'
-	local test_file="file.txt" tmp_file="file2.txt"
+	local policy="keyrings"
+	local tmp_file="$TST_TMPDIR/keycheck_tmp_file.txt"
 
 	tst_res TINFO "verify key measurement for keyrings and templates specified in IMA policy"
 
-	check_keys_policy "$pattern" > $tmp_file || return
-	keycheck_lines=$(cat $tmp_file)
-	keyrings=$(for i in $keycheck_lines; do echo "$i" | grep "keyrings" | \
-		sed "s/\./\\\./g" | cut -d'=' -f2; done | sed ':a;N;$!ba;s/\n/|/g')
-	if [ -z "$keyrings" ]; then
-		tst_res TCONF "IMA policy has a keyring key-value specifier, but no specified keyrings"
-		return
-	fi
-
-	templates=$(for i in $keycheck_lines; do echo "$i" | grep "template" | \
-		cut -d'=' -f2; done | sed ':a;N;$!ba;s/\n/|/g')
-
-	tst_res TINFO "keyrings: '$keyrings'"
-	tst_res TINFO "templates: '$templates'"
-
-	grep -E "($templates).*($keyrings)" $ASCII_MEASUREMENTS | while read line
-	do
-		local digest expected_digest algorithm
-
-		digest=$(echo "$line" | cut -d' ' -f4 | cut -d':' -f2)
-		algorithm=$(echo "$line" | cut -d' ' -f4 | cut -d':' -f1)
-		keyring=$(echo "$line" | cut -d' ' -f5)
-
-		echo "$line" | cut -d' ' -f6 | xxd -r -p > $test_file
-
-		if ! expected_digest="$(compute_digest $algorithm $test_file)"; then
-			tst_res TCONF "cannot compute digest for $algorithm"
-			return
-		fi
-
-		if [ "$digest" != "$expected_digest" ]; then
-			tst_res TFAIL "incorrect digest was found for $keyring keyring"
-			return
-		fi
-	done
-
-	tst_res TPASS "specified keyrings were measured correctly"
+	check_policy_pattern "$pattern" $POLICY_FUNC $POLICY_FILE > $tmp_file || return
+	test_policy_measurement $policy $temp_file
 }
 
 # Create a new keyring, import a certificate into it, and verify
@@ -109,11 +55,11 @@ test2()
 	local cert_file="$TST_DATAROOT/x509_ima.der"
 	local keyring_name="key_import_test"
 	local pattern="keyrings=[^[:space:]]*$keyring_name"
-	local temp_file="file.txt"
+	local temp_file="$TST_TMPDIR/key_import_test_file.txt"
 
 	tst_res TINFO "verify measurement of certificate imported into a keyring"
 
-	check_keys_policy "$pattern" >/dev/null || return
+	check_policy_pattern "$pattern" $POLICY_FUNC $POLICY_FILE >/dev/null || return
 
 	KEYRING_ID=$(keyctl newring $keyring_name @s) || \
 		tst_brk TBROK "unable to create a new keyring"
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index 565f0bc3e..b442d49be 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2009 IBM Corporation
-# Copyright (c) 2018-2020 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2018-2021 Petr Vorel <pvorel@suse.cz>
 # Author: Mimi Zohar <zohar@linux.ibm.com>
 
 TST_TESTFUNC="test"
@@ -54,6 +54,80 @@ compute_digest()
 	return 1
 }
 
+require_valid_policy_template()
+{
+	local func="$1"
+	local policy_file="$2"
+
+	while read line; do
+	if echo $line | grep -q 'template=' && ! echo $line | grep -q 'template=ima-buf'; then
+		tst_brk TCONF "only template=ima-buf can be specified for $func"
+	fi
+	done < $policy_file
+}
+
+check_policy_pattern()
+{
+	local pattern="$1"
+	local func="$2"
+	local policy_file="$3"
+
+	if ! grep -E "$pattern" $policy_file; then
+		tst_res TCONF "IMA policy must specify $pattern, $func"
+		return 1
+	fi
+	return 0
+}
+
+test_policy_measurement()
+{
+	local policy_option="$1"
+	local lines="$(cat $2)"
+	local input_digest="$3"
+	local test_file="$TST_TMPDIR/test.txt"
+	local grep_file="$TST_TMPDIR/grep.txt"
+	local i sources templates
+
+	tst_require_cmds cut sed xxd
+
+	sources=$(for i in $lines; do echo "$i" | grep "$policy_option" | \
+		sed "s/\./\\\./g" | cut -d'=' -f2; done | sed ':a;N;$!ba;s/\n/|/g')
+	if [ -z "$sources" ]; then
+		tst_res TCONF "IMA policy $policy_option is a key-value specifier, but no values specified"
+		return
+	fi
+
+	templates=$(for i in $lines; do echo "$i" | grep "template" | \
+		cut -d'=' -f2; done | sed ':a;N;$!ba;s/\n/|/g')
+
+	tst_res TINFO "policy sources: '$sources'"
+	tst_res TINFO "templates: '$templates'"
+
+	grep -E "($templates).*($sources)" $ASCII_MEASUREMENTS > $grep_file
+
+	while read line; do
+		local algorithm digest expected_digest src_line
+
+		digest=$(echo "$line" | cut -d' ' -f4 | cut -d':' -f2)
+		algorithm=$(echo "$line" | cut -d' ' -f4 | cut -d':' -f1)
+		src_line=$(echo "$line" | cut -d' ' -f5)
+
+		echo "$line" | cut -d' ' -f6 | xxd -r -p > $test_file
+
+		if ! expected_digest="$(compute_digest $algorithm $test_file)"; then
+			tst_res TCONF "cannot compute digest for $algorithm"
+			return
+		fi
+
+		if [ "$digest" != "$expected_digest" ]; then
+			tst_res TFAIL "incorrect digest was found for $src_line $policy_option"
+			return
+		fi
+	done < $grep_file
+
+	tst_res TPASS "$policy_option measured correctly"
+}
+
 check_policy_readable()
 {
 	if [ ! -f $IMA_POLICY ]; then
-- 
2.31.1


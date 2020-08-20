Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48D3824B1B4
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Aug 2020 11:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725885AbgHTJIr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 20 Aug 2020 05:08:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:39628 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726215AbgHTJIn (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 20 Aug 2020 05:08:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7A79CB761;
        Thu, 20 Aug 2020 09:09:05 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Petr Vorel <pvorel@suse.cz>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Subject: [LTP v4 5/5] IMA/ima_keys.sh: Enhance policy checks
Date:   Thu, 20 Aug 2020 11:08:24 +0200
Message-Id: <20200820090824.3033-6-pvorel@suse.cz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820090824.3033-1-pvorel@suse.cz>
References: <20200820090824.3033-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Add check_keys_policy helper to check for all policy's keyrings and
templates (removed head) and reuse policy check code.

Replaced tr with sed to cut down the dependencies.

Log keyrings and templates for easier debugging.

NOTE: check_keys_policy cannot be used with subhell $() redirection
(unless previously checked with other helpers), thus use redirection to
the file.

Tested on 2 policies with more lines than example policy
in keycheck.policy:

measure func=KEY_CHECK keyrings=.ima|.evm|.builtin_trusted_keys|.blacklist|key_import_test template=ima-buf
measure func=KEY_CHECK keyrings=key_import_test template=ima-buf

measure func=KEY_CHECK template=ima-buf keyrings=.ima|.builtin_trusted_keys
measure func=KEY_CHECK template=ima-buf keyrings=key_import_test

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
changes v3->v4:
* update check_keys_policy() and checking the policy in general
* remove new line when working policy to find keyrings and templates
* replace tr with sed

 .../security/integrity/ima/tests/ima_keys.sh  | 60 ++++++++++++-------
 1 file changed, 37 insertions(+), 23 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
index ad3cbbdc7..c5a6d2591 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
@@ -6,48 +6,63 @@
 #
 # Verify that keys are measured correctly based on policy.
 
-TST_NEEDS_CMDS="cmp cut grep sed tr xxd"
+TST_NEEDS_CMDS="cmp cut grep sed xxd"
 TST_CNT=2
 TST_NEEDS_DEVICE=1
+TST_SETUP=setup
 TST_CLEANUP=cleanup
 
 . ima_setup.sh
 
+FUNC_KEYCHECK='func=KEY_CHECK'
+TEMPLATE_BUF='template=ima-buf'
+REQUIRED_POLICY="^measure.*($FUNC_KEYCHECK.*$TEMPLATE_BUF|$TEMPLATE_BUF.*$FUNC_KEYCHECK)"
+
+setup()
+{
+	require_ima_policy_content "$REQUIRED_POLICY" '-E' > policy.txt
+}
+
 cleanup()
 {
 	tst_is_num $KEYRING_ID && keyctl clear $KEYRING_ID
 }
 
+check_keys_policy()
+{
+	local pattern="$1"
+
+	if ! grep -E "$pattern" policy.txt; then
+		tst_res TCONF "IMA policy must specify $pattern, $FUNC_KEYCHECK, $TEMPLATE_BUF"
+		return 1
+	fi
+	return 0
+}
+
 # Based on https://lkml.org/lkml/2019/12/13/564.
 # (450d0fd51564 - "IMA: Call workqueue functions to measure queued keys")
 test1()
 {
-	local keyrings keycheck_lines keycheck_line templates
-	local func='func=KEY_CHECK'
-	local buf='template=ima-buf'
-	local pattern="($func.*$buf|$buf.*$func)"
-	local test_file="file.txt"
-
-	tst_res TINFO "verifying key measurement for keyrings and templates specified in IMA policy file"
+	local keycheck_lines i keyrings templates
+	local pattern='keyrings=[^[:space:]]+'
+	local test_file="file.txt" tmp_file="file2.txt"
 
-	require_ima_policy_content "$pattern" '-Eq'
-	keycheck_lines=$(check_ima_policy_content "$pattern" '-E')
-	keycheck_line=$(echo "$keycheck_lines" | grep "keyrings" | head -n1)
+	tst_res TINFO "verify key measurement for keyrings and templates specified in IMA policy"
 
-	if [ -z "$keycheck_line" ]; then
-		tst_res TCONF "IMA policy does not specify a keyrings to check"
-		return
-	fi
-
-	keyrings=$(echo "$keycheck_line" | tr " " "\n" | grep "keyrings" | \
-		sed "s/\./\\\./g" | cut -d'=' -f2)
+	check_keys_policy "$pattern" > $tmp_file || return
+	keycheck_lines=$(cat $tmp_file)
+	keyrings=$(for i in $keycheck_lines; do echo "$i" | grep "keyrings" | \
+		sed "s/\./\\\./g" | cut -d'=' -f2; done | sed ':a;N;$!ba;s/\n/|/g')
 	if [ -z "$keyrings" ]; then
 		tst_res TCONF "IMA policy has a keyring key-value specifier, but no specified keyrings"
 		return
 	fi
 
-	templates=$(echo "$keycheck_line" | tr " " "\n" | grep "template" | \
-		cut -d'=' -f2)
+	templates=$(for i in $keycheck_lines; do echo "$i" | grep "template" | \
+		cut -d'=' -f2; done | sed ':a;N;$!ba;s/\n/|/g')
+
+	tst_res TINFO "keyrings: '$keyrings'"
+	tst_res TINFO "templates: '$templates'"
 
 	grep -E "($templates).*($keyrings)" $ASCII_MEASUREMENTS | while read line
 	do
@@ -81,13 +96,12 @@ test2()
 
 	local cert_file="$TST_DATAROOT/x509_ima.der"
 	local keyring_name="key_import_test"
+	local pattern="keyrings=[^[:space:]]*$keyring_name"
 	local temp_file="file.txt"
 
 	tst_res TINFO "verify measurement of certificate imported into a keyring"
 
-	if ! check_ima_policy_content "^measure.*func=KEY_CHECK.*keyrings=.*$keyring_name"; then
-		tst_brk TCONF "IMA policy does not contain $keyring_name keyring"
-	fi
+	check_keys_policy "$pattern" >/dev/null || return
 
 	KEYRING_ID=$(keyctl newring $keyring_name @s) || \
 		tst_brk TBROK "unable to create a new keyring"
-- 
2.28.0


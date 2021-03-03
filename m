Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9DA332C3BF
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Mar 2021 01:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbhCCX7k (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 3 Mar 2021 18:59:40 -0500
Received: from linux.microsoft.com ([13.77.154.182]:41086 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388039AbhCCUdj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 3 Mar 2021 15:33:39 -0500
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id D33BA20B83EA;
        Wed,  3 Mar 2021 12:32:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D33BA20B83EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1614803578;
        bh=h4q9fAxS+MFSgu5p/zIGjIyIrAME+eYN6saW0Oul8qo=;
        h=From:To:Cc:Subject:Date:From;
        b=P4SvIF4PZ6d0XUb5kY8v4QP4MTya8vbrC1YWy1o2EuL7iD+f11GbxBUf56XvVll/I
         nCmJRVFm/UnWE2Lne9LbxHWDiR3rS398HHH8WGGFesMA2fNVnUFeq46/8rIBaX9jH8
         20+0M43yX7PL4P5UQUakY/dHIMARpRVVY56eNTPk=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     pvorel@suse.cz, zohar@linux.ibm.com
Cc:     tusharsu@linux.microsoft.com, ltp@lists.linux.it,
        linux-integrity@vger.kernel.org
Subject: [PATCH] IMA: Allow only ima-buf template for key measurement
Date:   Wed,  3 Mar 2021 12:32:54 -0800
Message-Id: <20210303203254.12856-1-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

ima-buf is the default IMA template used for all buffer measurements.
Therefore, IMA policy rule for measuring keys need not specify
an IMA template.  But if a template is specified for key measurement
rule then it must be only ima-buf.

Update keys tests to not require a template to be specified for
key measurement rule, but if a template is specified verify it is
only ima-buf.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 .../security/integrity/ima/tests/ima_keys.sh     | 10 +++++++---
 .../security/integrity/ima/tests/ima_setup.sh    | 16 ++++++++++++++++
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
index c9eef4b68..8b214b413 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
@@ -15,8 +15,7 @@ TST_CLEANUP=cleanup
 . ima_setup.sh
 
 FUNC_KEYCHECK='func=KEY_CHECK'
-TEMPLATE_BUF='template=ima-buf'
-REQUIRED_POLICY="^measure.*($FUNC_KEYCHECK.*$TEMPLATE_BUF|$TEMPLATE_BUF.*$FUNC_KEYCHECK)"
+REQUIRED_POLICY="^measure.*$FUNC_KEYCHECK"
 
 setup()
 {
@@ -33,9 +32,10 @@ check_keys_policy()
 	local pattern="$1"
 
 	if ! grep -E "$pattern" $TST_TMPDIR/policy.txt; then
-		tst_res TCONF "IMA policy must specify $pattern, $FUNC_KEYCHECK, $TEMPLATE_BUF"
+		tst_res TCONF "IMA policy must specify $pattern, $FUNC_KEYCHECK"
 		return 1
 	fi
+
 	return 0
 }
 
@@ -49,6 +49,8 @@ test1()
 
 	tst_res TINFO "verify key measurement for keyrings and templates specified in IMA policy"
 
+	check_policy_template "template=ima-buf" $FUNC_KEYCHECK || return
+
 	check_keys_policy "$pattern" > $tmp_file || return
 	keycheck_lines=$(cat $tmp_file)
 	keyrings=$(for i in $keycheck_lines; do echo "$i" | grep "keyrings" | \
@@ -101,6 +103,8 @@ test2()
 
 	tst_res TINFO "verify measurement of certificate imported into a keyring"
 
+	check_policy_template "template=ima-buf" $FUNC_KEYCHECK || return
+
 	check_keys_policy "$pattern" >/dev/null || return
 
 	KEYRING_ID=$(keyctl newring $keyring_name @s) || \
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index 59a7ffeac..01ebec2b6 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -107,6 +107,22 @@ check_ima_policy_cmdline()
 	return 1
 }
 
+check_policy_template()
+{
+	local template="$1"
+	local func="$2"
+	grep -E "template=" $TST_TMPDIR/policy.txt | while read line
+	do
+		ima_template=$(echo $line | grep $template)
+		if [ -z "$ima_template" ]; then
+			tst_res TCONF "Only $template can be specified for $func"
+			return 1
+		fi
+	done
+
+	return 0
+}
+
 require_ima_policy_cmdline()
 {
 	local policy="$1"
-- 
2.30.0


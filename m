Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2B523F3F4
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Aug 2020 22:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbgHGUrC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 7 Aug 2020 16:47:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:49258 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728479AbgHGUrB (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 7 Aug 2020 16:47:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 76FE5AD0B;
        Fri,  7 Aug 2020 20:47:18 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Petr Vorel <pvorel@suse.cz>,
        Lachlan Sneff <t-josne@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v2 4/4] IMA/ima_keys.sh: Enhance policy checks
Date:   Fri,  7 Aug 2020 22:46:52 +0200
Message-Id: <20200807204652.5928-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200807204652.5928-1-pvorel@suse.cz>
References: <20200807204652.5928-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Reuse policy check code.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../security/integrity/ima/tests/ima_keys.sh  | 39 ++++++++++++-------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
index 30950904e..5735568ee 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
@@ -9,27 +9,41 @@
 TST_NEEDS_CMDS="cmp cut grep sed tr xxd"
 TST_CNT=2
 TST_NEEDS_DEVICE=1
+TST_SETUP="setup"
 
 . ima_setup.sh
 
+KEYCHECK_POLICY='func=KEY_CHECK'
+
+setup()
+{
+	require_ima_policy_content "^measure.*$KEYCHECK_POLICY"
+}
+
+check_keys_policy()
+{
+	local pattern="$1"
+
+	pattern="^measure.*($KEYCHECK_POLICY.*$pattern|$pattern.*$KEYCHECK_POLICY)"
+	if ! check_ima_policy_content "$pattern" '-E'; then
+		tst_res TCONF "IMA policy does not specify '$pattern'"
+		return 1
+	fi
+	return 0
+}
+
+
 # Based on https://lkml.org/lkml/2019/12/13/564.
 # (450d0fd51564 - "IMA: Call workqueue functions to measure queued keys")
 test1()
 {
-	local keyrings keycheck_lines keycheck_line templates
-	local pattern="func=KEY_CHECK"
+	local keycheck_line keyrings templates
+	local pattern='keyrings=[^[:space:]]+'
 	local test_file="file.txt"
 
 	tst_res TINFO "verify key measurement for keyrings and templates specified in IMA policy"
 
-	require_ima_policy_content "$pattern"
-	keycheck_lines=$(check_ima_policy_content "$pattern" "")
-	keycheck_line=$(echo "$keycheck_lines" | grep "keyrings" | head -n1)
-
-	if [ -z "$keycheck_line" ]; then
-		tst_res TCONF "IMA policy does not specify a keyrings to check"
-		return
-	fi
+	keycheck_line=$(check_keys_policy "$pattern") || return
 
 	keyrings=$(echo "$keycheck_line" | tr " " "\n" | grep "keyrings" | \
 		sed "s/\./\\\./g" | cut -d'=' -f2)
@@ -73,14 +87,13 @@ test2()
 
 	local cert_file="$TST_DATAROOT/x509_ima.der"
 	local keyring_name="key_import_test"
+	local pattern="keyrings=[^[:space:]]*$keyring_name"
 	local temp_file="file.txt"
 	local keyring_id
 
 	tst_res TINFO "verify measurement of certificate imported into a keyring"
 
-	if ! check_ima_policy_content "^measure.*func=KEY_CHECK.*keyrings=.*$keyring_name"; then
-		tst_brk TCONF "IMA policy does not contain $keyring_name keyring"
-	fi
+	check_keys_policy "$pattern" >/dev/null || return
 
 	keyctl new_session > /dev/null
 
-- 
2.28.0


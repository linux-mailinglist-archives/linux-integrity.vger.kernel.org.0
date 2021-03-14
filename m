Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC3C33A8DB
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Mar 2021 00:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhCNXhQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 14 Mar 2021 19:37:16 -0400
Received: from linux.microsoft.com ([13.77.154.182]:54290 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbhCNXgv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 14 Mar 2021 19:36:51 -0400
Received: from localhost.localdomain (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id DC15020B39C5;
        Sun, 14 Mar 2021 16:36:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DC15020B39C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1615765011;
        bh=9wi0f3H3ip86QGPiTWiYDomXo3fNUV261DgfPDEivlI=;
        h=From:To:Cc:Subject:Date:From;
        b=VXXsOLzJFxWwP7Q1aq7/PGFMY2XQJ9C5hT2jxKDYrFVkfRaiPz+jhyxQDGEAlVZrx
         y1YGttKB7oSHXhKRdfsP1JRa00joBx6KQI2xdXj9iVDbPXCu/m5a979yhhbHiuVnC/
         9JGe7rbcbYCUZAylY7MFg2ZNBWY6epkPWvB79Bo4=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     pvorel@suse.cz, zohar@linux.ibm.com
Cc:     tusharsu@linux.microsoft.com, ltp@lists.linux.it,
        linux-integrity@vger.kernel.org
Subject: [PATCH v2] IMA: Allow only ima-buf template for key measurement
Date:   Sun, 14 Mar 2021 16:36:46 -0700
Message-Id: <20210314233646.2925-1-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.30.2
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
 .../security/integrity/ima/tests/ima_keys.sh  | 20 ++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
index c9eef4b68..b9bef4feb 100755
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
@@ -28,12 +27,23 @@ cleanup()
 	tst_is_num $KEYRING_ID && keyctl clear $KEYRING_ID
 }
 
+check_policy_template()
+{
+	while read line; do
+	if ( echo $line | grep -q 'template=') && ( ! echo $line | grep -q 'template=ima-buf' ); then
+		tst_res TCONF "only template=ima-buf can be specified for KEY_CHECK"
+		return 1
+	fi
+	done < $TST_TMPDIR/policy.txt
+	return 0
+}
+
 check_keys_policy()
 {
 	local pattern="$1"
 
 	if ! grep -E "$pattern" $TST_TMPDIR/policy.txt; then
-		tst_res TCONF "IMA policy must specify $pattern, $FUNC_KEYCHECK, $TEMPLATE_BUF"
+		tst_res TCONF "IMA policy must specify $pattern, $FUNC_KEYCHECK"
 		return 1
 	fi
 	return 0
@@ -49,6 +59,8 @@ test1()
 
 	tst_res TINFO "verify key measurement for keyrings and templates specified in IMA policy"
 
+	check_policy_template || return
+
 	check_keys_policy "$pattern" > $tmp_file || return
 	keycheck_lines=$(cat $tmp_file)
 	keyrings=$(for i in $keycheck_lines; do echo "$i" | grep "keyrings" | \
@@ -101,6 +113,8 @@ test2()
 
 	tst_res TINFO "verify measurement of certificate imported into a keyring"
 
+	check_policy_template || return
+
 	check_keys_policy "$pattern" >/dev/null || return
 
 	KEYRING_ID=$(keyctl newring $keyring_name @s) || \
-- 
2.30.1


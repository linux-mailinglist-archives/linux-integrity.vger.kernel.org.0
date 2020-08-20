Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD67924B1B2
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Aug 2020 11:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbgHTJIo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 20 Aug 2020 05:08:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:39544 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbgHTJIj (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 20 Aug 2020 05:08:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DFBB8B75C;
        Thu, 20 Aug 2020 09:09:04 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Petr Vorel <pvorel@suse.cz>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Subject: [LTP v4 2/5] IMA/ima_keys.sh: Require template=ima-buf, fix grep pattern
Date:   Thu, 20 Aug 2020 11:08:21 +0200
Message-Id: <20200820090824.3033-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820090824.3033-1-pvorel@suse.cz>
References: <20200820090824.3033-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

test1 (and following test2 which will be added) require ima-buf template
which contains 'buf' identifier (the buffer data that was used to
generate the hash without size limitations). For simplicity we ignore
custom templates (ima_template_fmt kernel command line parameter), which
could also define it.

Also fix grep format for searching in the policy: add missing '.'
Searching for lines with specified templates *and* keyrings in the
measurement, but there is algorithm and hash in between, thus '.*'.
Previously template was just ignored due using just '*'.

Fixes: d2768c84e ("IMA: Add a test to verify measurement of keys")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
New commit (maybe I should have split them into 2 commits).

 .../kernel/security/integrity/ima/tests/ima_keys.sh    | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
index 53c289054..015a3c115 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
@@ -17,13 +17,15 @@ TST_NEEDS_DEVICE=1
 test1()
 {
 	local keyrings keycheck_lines keycheck_line templates
-	local pattern="func=KEY_CHECK"
+	local func='func=KEY_CHECK'
+	local buf='template=ima-buf'
+	local pattern="($func.*$buf|$buf.*$func)"
 	local test_file="file.txt"
 
 	tst_res TINFO "verifying key measurement for keyrings and templates specified in IMA policy file"
 
-	require_ima_policy_content "$pattern"
-	keycheck_lines=$(check_ima_policy_content "$pattern" "")
+	require_ima_policy_content "$pattern" '-Eq'
+	keycheck_lines=$(check_ima_policy_content "$pattern" '-E')
 	keycheck_line=$(echo "$keycheck_lines" | grep "keyrings" | head -n1)
 
 	if [ -z "$keycheck_line" ]; then
@@ -39,7 +41,7 @@ test1()
 	templates=$(echo "$keycheck_line" | tr " " "\n" | grep "template" | \
 		cut -d'=' -f2)
 
-	grep -E "($templates)*($keyrings)" $ASCII_MEASUREMENTS | while read line
+	grep -E "($templates).*($keyrings)" $ASCII_MEASUREMENTS | while read line
 	do
 		local digest expected_digest algorithm
 
-- 
2.28.0


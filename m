Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B470A376A8D
	for <lists+linux-integrity@lfdr.de>; Fri,  7 May 2021 21:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbhEGTP0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 7 May 2021 15:15:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:54942 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229482AbhEGTPW (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 7 May 2021 15:15:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9F566B008;
        Fri,  7 May 2021 19:14:21 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v4 1/3] ima_keys.sh: Check policy only once
Date:   Fri,  7 May 2021 21:14:12 +0200
Message-Id: <20210507191414.14795-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210507191414.14795-1-pvorel@suse.cz>
References: <20210507191414.14795-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Not needed to check the same policy twice.
Rename to contain 'require' as we use tst_brk.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
new in v4

 .../security/integrity/ima/tests/ima_keys.sh       | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
index 9951ab999..3476b8007 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2020 Microsoft Corporation
-# Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2020-2021 Petr Vorel <pvorel@suse.cz>
 # Author: Lachlan Sneff <t-josne@linux.microsoft.com>
 #
 # Verify that keys are measured correctly based on policy.
@@ -20,6 +20,7 @@ REQUIRED_POLICY="^measure.*$FUNC_KEYCHECK"
 setup()
 {
 	require_ima_policy_content "$REQUIRED_POLICY" '-E' > $TST_TMPDIR/policy.txt
+	require_valid_policy_template
 }
 
 cleanup()
@@ -27,15 +28,14 @@ cleanup()
 	tst_is_num $KEYRING_ID && keyctl clear $KEYRING_ID
 }
 
-check_policy_template()
+
+require_valid_policy_template()
 {
 	while read line; do
 	if echo $line | grep -q 'template=' && ! echo $line | grep -q 'template=ima-buf'; then
-		tst_res TCONF "only template=ima-buf can be specified for KEY_CHECK"
-		return 1
+		tst_brk TCONF "only template=ima-buf can be specified for KEY_CHECK"
 	fi
 	done < $TST_TMPDIR/policy.txt
-	return 0
 }
 
 check_keys_policy()
@@ -59,8 +59,6 @@ test1()
 
 	tst_res TINFO "verify key measurement for keyrings and templates specified in IMA policy"
 
-	check_policy_template || return
-
 	check_keys_policy "$pattern" > $tmp_file || return
 	keycheck_lines=$(cat $tmp_file)
 	keyrings=$(for i in $keycheck_lines; do echo "$i" | grep "keyrings" | \
@@ -115,8 +113,6 @@ test2()
 
 	tst_res TINFO "verify measurement of certificate imported into a keyring"
 
-	check_policy_template || return
-
 	check_keys_policy "$pattern" >/dev/null || return
 
 	KEYRING_ID=$(keyctl newring $keyring_name @s) || \
-- 
2.31.1


Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF18D22BE8A
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Jul 2020 09:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgGXHD2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 24 Jul 2020 03:03:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:58900 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726739AbgGXHAp (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 24 Jul 2020 03:00:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D4785AC20;
        Fri, 24 Jul 2020 07:00:52 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Petr Vorel <pvorel@suse.cz>,
        Lachlan Sneff <t-josne@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        balajib@linux.microsoft.com, linux-integrity@vger.kernel.org
Subject: [PATCH v4 1/2] IMA: Fix policy readability check
Date:   Fri, 24 Jul 2020 09:00:37 +0200
Message-Id: <20200724070038.29491-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Check with cat, because file attributes were fixed in
ffb122de9a60 ("ima: Reflect correct permissions for policy")
in v4.18.

Added into ima_setup.sh as it'll be used next commit in another test.

Fixes: d2768c84e ("IMA: Add a test to verify measurement of keys")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/security/integrity/ima/tests/ima_keys.sh | 4 +---
 .../kernel/security/integrity/ima/tests/ima_setup.sh      | 8 ++++++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
index 904b7515b..26b8eaf84 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
@@ -19,9 +19,7 @@ test1()
 
 	tst_res TINFO "verifying key measurement for keyrings and templates specified in IMA policy file"
 
-	[ -f $IMA_POLICY ] || tst_brk TCONF "missing $IMA_POLICY"
-
-	[ -r $IMA_POLICY ] || tst_brk TCONF "cannot read IMA policy (CONFIG_IMA_READ_POLICY=y required)"
+	check_policy_readable
 
 	keycheck_lines=$(grep "func=KEY_CHECK" $IMA_POLICY)
 	if [ -z "$keycheck_lines" ]; then
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index 8ae477c1c..458f67c30 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -111,6 +111,14 @@ print_ima_config()
 	tst_res TINFO "/proc/cmdline: $(cat /proc/cmdline)"
 }
 
+check_policy_readable()
+{
+	[ -f $IMA_POLICY ] || tst_brk TCONF "missing $IMA_POLICY"
+
+	cat $IMA_POLICY > /dev/null 2>/dev/null || \
+		tst_brk TCONF "cannot read IMA policy (CONFIG_IMA_READ_POLICY=y required)"
+}
+
 ima_setup()
 {
 	SECURITYFS="$(mount_helper securityfs $SYSFS/kernel/security)"
-- 
2.27.0


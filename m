Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 517B322FC27
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Jul 2020 00:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgG0Wax (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Jul 2020 18:30:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:39976 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbgG0Waw (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Jul 2020 18:30:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 258DBAC37;
        Mon, 27 Jul 2020 22:31:02 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Petr Vorel <pvorel@suse.cz>,
        Lachlan Sneff <t-josne@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        balajib@linux.microsoft.com, linux-integrity@vger.kernel.org
Subject: [PATCH v5 1/4] IMA: Rename helper to require_ima_policy_cmdline
Date:   Tue, 28 Jul 2020 00:30:38 +0200
Message-Id: <20200727223041.13110-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727223041.13110-1-pvorel@suse.cz>
References: <20200727223041.13110-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

To be clear we check /proc/cmdline. There will be another helper
function require_ima_policy_content().

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
New in v5.

 testcases/kernel/security/integrity/ima/tests/evm_overlay.sh    | 2 +-
 .../kernel/security/integrity/ima/tests/ima_measurements.sh     | 2 +-
 testcases/kernel/security/integrity/ima/tests/ima_setup.sh      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/evm_overlay.sh b/testcases/kernel/security/integrity/ima/tests/evm_overlay.sh
index ac209e430..9d86778b6 100755
--- a/testcases/kernel/security/integrity/ima/tests/evm_overlay.sh
+++ b/testcases/kernel/security/integrity/ima/tests/evm_overlay.sh
@@ -19,7 +19,7 @@ setup()
 	[ -f "$EVM_FILE" ] || tst_brk TCONF "EVM not enabled in kernel"
 	[ $(cat $EVM_FILE) -eq 1 ] || tst_brk TCONF "EVM not enabled for this boot"
 
-	check_ima_policy "appraise_tcb"
+	require_ima_policy_cmdline "appraise_tcb"
 
 	lower="$TST_MNTPOINT/lower"
 	upper="$TST_MNTPOINT/upper"
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
index 04d8e6353..9a7500c76 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
@@ -15,7 +15,7 @@ TST_NEEDS_DEVICE=1
 
 setup()
 {
-	check_ima_policy "tcb"
+	require_ima_policy_cmdline "tcb"
 
 	TEST_FILE="$PWD/test.txt"
 	POLICY="$IMA_DIR/policy"
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index 8ae477c1c..975ce9cbb 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -54,7 +54,7 @@ compute_digest()
 	return 1
 }
 
-check_ima_policy()
+require_ima_policy_cmdline()
 {
 	local policy="$1"
 	local i
-- 
2.27.0


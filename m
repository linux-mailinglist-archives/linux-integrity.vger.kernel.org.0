Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 555CB22FC28
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Jul 2020 00:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgG0Wax (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Jul 2020 18:30:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:40002 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727091AbgG0Wax (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Jul 2020 18:30:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6C933AF36;
        Mon, 27 Jul 2020 22:31:02 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Petr Vorel <pvorel@suse.cz>,
        Lachlan Sneff <t-josne@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        balajib@linux.microsoft.com, linux-integrity@vger.kernel.org
Subject: [PATCH v5 3/4] IMA/ima_keys.sh: Fix policy readability check
Date:   Tue, 28 Jul 2020 00:30:40 +0200
Message-Id: <20200727223041.13110-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727223041.13110-1-pvorel@suse.cz>
References: <20200727223041.13110-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Using a proper check with cat, because file attributes were fixed in
ffb122de9a60 ("ima: Reflect correct permissions for policy") in v4.18.

Fixes: d2768c84e ("IMA: Add a test to verify measurement of keys")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v4->v5:
* use require_ima_policy_content
* moved helper function to previous commit

 .../kernel/security/integrity/ima/tests/ima_keys.sh    | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
index 2f6c2b027..5a77deec1 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
@@ -19,15 +19,7 @@ test1()
 
 	tst_res TINFO "verifying key measurement for keyrings and templates specified in IMA policy file"
 
-	[ -f $IMA_POLICY ] || tst_brk TCONF "missing $IMA_POLICY"
-
-	[ -r $IMA_POLICY ] || tst_brk TCONF "cannot read IMA policy (CONFIG_IMA_READ_POLICY=y required)"
-
-	keycheck_lines=$(grep "func=KEY_CHECK" $IMA_POLICY)
-	if [ -z "$keycheck_lines" ]; then
-		tst_brk TCONF "ima policy does not specify \"func=KEY_CHECK\""
-	fi
-
+	keycheck_lines=$(require_ima_policy_content "func=KEY_CHECK" "")
 	keycheck_line=$(echo "$keycheck_lines" | grep "keyrings" | head -n1)
 
 	if [ -z "$keycheck_line" ]; then
-- 
2.27.0


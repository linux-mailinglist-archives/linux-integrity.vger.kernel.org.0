Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9B8E3D6D1
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Jun 2019 21:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405437AbfFKTao (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 Jun 2019 15:30:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:48778 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404926AbfFKTao (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 Jun 2019 15:30:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BE062AF7B;
        Tue, 11 Jun 2019 19:30:43 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Ignaz Forster <iforster@suse.de>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v3 3/4] ima/ima_measurements.sh: Require builtin IMA tcb policy
Date:   Tue, 11 Jun 2019 21:30:20 +0200
Message-Id: <20190611193021.17651-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190611193021.17651-1-pvorel@suse.cz>
References: <20190611193021.17651-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Although custom policy which contains tcb can be loaded via dracut,
systemd or later manually from user space, detecting it would require
IMA_READ_POLICY=y. In order to simplify the check and avoid false
positives lets ignore this option and require builtin IMA tcb policy.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../kernel/security/integrity/ima/tests/ima_measurements.sh    | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
index 328affc43..a3aa24d8a 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
@@ -57,7 +57,8 @@ setup()
 	[ -z "$DIGEST_INDEX" ] && tst_brk TCONF \
 		"Cannot find digest index (template: '$template')"
 
-	tst_res TINFO "IMA measurement tests assume tcb policy to be loaded (ima_policy=tcb)"
+	grep -q -e ima_policy=[a-z_]*tcb -e ima_tcb -e ima_appraise_tcb /proc/cmdline || \
+		tst_brk TCONF "IMA measurement tests require builtin IMA tcb policy (ima_policy=tcb or ima_policy=appraise_tcb kernel parameter)"
 }
 
 # TODO: find support for rmd128 rmd256 rmd320 wp256 wp384 tgr128 tgr160
-- 
2.21.0


Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA76E1E830
	for <lists+linux-integrity@lfdr.de>; Wed, 15 May 2019 08:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbfEOGSQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 May 2019 02:18:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:43814 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725877AbfEOGSQ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 May 2019 02:18:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6EE98AD3B;
        Wed, 15 May 2019 06:18:15 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH v2] ima: fix wrong signed policy requirement when not appraising
Date:   Wed, 15 May 2019 08:18:07 +0200
Message-Id: <20190515061807.6257-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Kernel booted just with ima_policy=tcb (not with
ima_policy=appraise_tcb) shouldn't require signed policy.

Regression found with LTP test ima_policy.sh.

Fixes: c52657d93b05 ("ima: refactor ima_init_policy()")

Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changelog v1->v2:
* Use POLICY_CHECK instead of ima_use_appraise_tcb.
Thanks Mimi for obvious hint :).

Kind regards,
Petr

 security/integrity/ima/ima_policy.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index e0cc323f948f..0f6fe53cef09 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -498,10 +498,11 @@ static void add_rules(struct ima_rule_entry *entries, int count,
 
 			list_add_tail(&entry->list, &ima_policy_rules);
 		}
-		if (entries[i].action == APPRAISE)
+		if (entries[i].action == APPRAISE) {
 			temp_ima_appraise |= ima_appraise_flag(entries[i].func);
-		if (entries[i].func == POLICY_CHECK)
-			temp_ima_appraise |= IMA_APPRAISE_POLICY;
+			if (entries[i].func == POLICY_CHECK)
+				temp_ima_appraise |= IMA_APPRAISE_POLICY;
+		}
 	}
 }
 
-- 
2.16.4


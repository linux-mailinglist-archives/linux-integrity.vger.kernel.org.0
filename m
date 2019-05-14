Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 489181E44A
	for <lists+linux-integrity@lfdr.de>; Wed, 15 May 2019 00:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbfENWIw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 May 2019 18:08:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:48042 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726148AbfENWIw (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 May 2019 18:08:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 15882AC94;
        Tue, 14 May 2019 22:08:51 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: [PATCH] ima: fix wrong signed policy requirement when not appraising
Date:   Wed, 15 May 2019 00:08:45 +0200
Message-Id: <20190514220845.408-1-pvorel@suse.cz>
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

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

assuming behavior prior c52657d93b05 was correct.
BTW I admit that using global variable inside helper function is nasty.

Kind regards,
Petr

 security/integrity/ima/ima_policy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index e0cc323f948f..df0e6a1b063b 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -500,7 +500,7 @@ static void add_rules(struct ima_rule_entry *entries, int count,
 		}
 		if (entries[i].action == APPRAISE)
 			temp_ima_appraise |= ima_appraise_flag(entries[i].func);
-		if (entries[i].func == POLICY_CHECK)
+		if (ima_use_appraise_tcb && entries[i].func == POLICY_CHECK)
 			temp_ima_appraise |= IMA_APPRAISE_POLICY;
 	}
 }
-- 
2.16.4


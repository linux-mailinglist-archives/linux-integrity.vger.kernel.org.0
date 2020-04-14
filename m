Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67E6C1A75AD
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Apr 2020 10:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407111AbgDNIRS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Apr 2020 04:17:18 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57892 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2407079AbgDNIRP (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Apr 2020 04:17:15 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7CDE2362AE5C6C96C2F8;
        Tue, 14 Apr 2020 16:16:59 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Tue, 14 Apr 2020 16:15:35 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <zohar@linux.ibm.com>, <dmitry.kasatkin@gmail.com>,
        <jmorris@namei.org>, <serge@hallyn.com>,
        <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] IMA: fix memdup.cocci warnings
Date:   Tue, 14 Apr 2020 16:21:59 +0800
Message-ID: <1586852519-69161-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Fixes coccicheck warning:

security/integrity/ima/ima_policy.c:272:10-17: WARNING opportunity for kmemdup

Use kmemdup rather than duplicating its implementation

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 security/integrity/ima/ima_policy.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index c334e0d..185f8d7 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -269,7 +269,7 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
 	struct ima_rule_entry *nentry;
 	int i;
 
-	nentry = kmalloc(sizeof(*nentry), GFP_KERNEL);
+	nentry = kmemdup(entry, sizeof(*nentry), GFP_KERNEL);
 	if (!nentry)
 		return NULL;
 
@@ -277,7 +277,6 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
 	 * Immutable elements are copied over as pointers and data; only
 	 * lsm rules can change
 	 */
-	memcpy(nentry, entry, sizeof(*nentry));
 	memset(nentry->lsm, 0, sizeof_field(struct ima_rule_entry, lsm));
 
 	for (i = 0; i < MAX_LSM_RULES; i++) {
-- 
2.6.2


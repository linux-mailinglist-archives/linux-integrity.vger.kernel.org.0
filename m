Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C08EB13407A
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Jan 2020 12:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgAHL3e (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Jan 2020 06:29:34 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9125 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726098AbgAHL3d (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Jan 2020 06:29:33 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8AAB3A4388C290F79247;
        Wed,  8 Jan 2020 19:29:31 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Wed, 8 Jan 2020 19:29:24 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <zohar@linux.ibm.com>, <dmitry.kasatkin@gmail.com>,
        <jmorris@namei.org>
CC:     <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chenzhou10@huawei.com>
Subject: [PATCH] ima: use kmemdup
Date:   Wed, 8 Jan 2020 19:25:13 +0800
Message-ID: <20200108112513.39715-1-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Fix memdup.cocci warnings:
./security/integrity/ima/ima_policy.c:268:10-17: WARNING opportunity for kmemdup

Use kmemdup rather than duplicating its implementation.

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 security/integrity/ima/ima_policy.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index ef8dfd4..e31649c 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -265,7 +265,7 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
 	struct ima_rule_entry *nentry;
 	int i, result;
 
-	nentry = kmalloc(sizeof(*nentry), GFP_KERNEL);
+	nentry = kmemdup(entry, sizeof(*nentry), GFP_KERNEL);
 	if (!nentry)
 		return NULL;
 
@@ -273,7 +273,6 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
 	 * Immutable elements are copied over as pointers and data; only
 	 * lsm rules can change
 	 */
-	memcpy(nentry, entry, sizeof(*nentry));
 	memset(nentry->lsm, 0, sizeof_field(struct ima_rule_entry, lsm));
 
 	for (i = 0; i < MAX_LSM_RULES; i++) {
-- 
2.7.4


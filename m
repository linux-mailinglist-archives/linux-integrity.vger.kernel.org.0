Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC4D597B54
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Aug 2022 04:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242671AbiHRCJA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 Aug 2022 22:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242546AbiHRCJA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Aug 2022 22:09:00 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CB039BB0
        for <linux-integrity@vger.kernel.org>; Wed, 17 Aug 2022 19:08:58 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4M7SsX1SybzlWNx;
        Thu, 18 Aug 2022 10:05:52 +0800 (CST)
Received: from huawei.com (10.67.175.31) by dggpemm500024.china.huawei.com
 (7.185.36.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 18 Aug
 2022 10:08:56 +0800
From:   GUO Zihua <guozihua@huawei.com>
To:     <linux-integrity@vger.kernel.org>, <zohar@linux.ibm.com>,
        <dmitry.kasatkin@gmail.com>, <paul@paul-moore.com>
Subject: [PATCH] ima: Handle -ESTALE returned by ima_filter_rule_match()
Date:   Thu, 18 Aug 2022 10:05:51 +0800
Message-ID: <20220818020551.18922-1-guozihua@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.31]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

IMA relies on lsm policy update notifier to be notified when it should
update it's lsm rules.

When SELinux update it's policies, ima would be notified and starts
updating all its lsm rules one-by-one. During this time, -ESTALE would
be returned by ima_filter_rule_match() if it is called with a lsm rule
that has not yet been updated. In ima_match_rules(), -ESTALE is not
handled, and the lsm rule is considered a match, causing extra files
be measured by IMA.

Fix it by retrying for at most three times if -ESTALE is returned by
ima_filter_rule_match().

Fixes: b16942455193 ("ima: use the lsm policy update notifier")
Signed-off-by: GUO Zihua <guozihua@huawei.com>
---
 security/integrity/ima/ima_policy.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index a8802b8da946..6edc8cc48dec 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -609,6 +609,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 	for (i = 0; i < MAX_LSM_RULES; i++) {
 		int rc = 0;
 		u32 osid;
+		int retried = 0;
 
 		if (!rule->lsm[i].rule) {
 			if (!rule->lsm[i].args_p)
@@ -616,6 +617,8 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 			else
 				return false;
 		}
+
+retry:
 		switch (i) {
 		case LSM_OBJ_USER:
 		case LSM_OBJ_ROLE:
@@ -635,6 +638,11 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 		default:
 			break;
 		}
+
+		if (rc == -ESTALE && retried < 3) {
+			retried++;
+			goto retry;
+		}
 		if (!rc)
 			return false;
 	}
-- 
2.17.1


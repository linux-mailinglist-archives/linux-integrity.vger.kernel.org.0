Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4273F5BFE94
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Sep 2022 15:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiIUNB5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 21 Sep 2022 09:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiIUNBx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 21 Sep 2022 09:01:53 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0655E8E98A;
        Wed, 21 Sep 2022 06:01:51 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MXdlS37TqzpV2q;
        Wed, 21 Sep 2022 20:59:00 +0800 (CST)
Received: from huawei.com (10.67.175.31) by dggpemm500024.china.huawei.com
 (7.185.36.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 21 Sep
 2022 21:01:49 +0800
From:   GUO Zihua <guozihua@huawei.com>
To:     <zohar@linux.ibm.com>, <dmitry.kasatkin@gmail.com>,
        <paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>
Subject: [PATCH v5 2/2] ima: Handle -ESTALE returned by ima_filter_rule_match()
Date:   Wed, 21 Sep 2022 20:58:04 +0800
Message-ID: <20220921125804.59490-3-guozihua@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220921125804.59490-1-guozihua@huawei.com>
References: <20220921125804.59490-1-guozihua@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.31]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500024.china.huawei.com (7.185.36.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

IMA relies on the blocking LSM policy notifier callback to update the
LSM based IMA policy rules.

When SELinux update its policies, IMA would be notified and starts
updating all its lsm rules one-by-one. During this time, -ESTALE would
be returned by ima_filter_rule_match() if it is called with a LSM rule
that has not yet been updated. In ima_match_rules(), -ESTALE is not
handled, and the LSM rule is considered a match, causing extra files
to be measured by IMA.

Fix it by re-initializing a temporary rule if -ESTALE is returned by
ima_filter_rule_match(). The origin rule in the rule list would be
updated by the LSM policy notifier callback.

Fixes: b16942455193 ("ima: use the lsm policy update notifier")
Signed-off-by: GUO Zihua <guozihua@huawei.com>
---
 security/integrity/ima/ima_policy.c | 41 ++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 8040215c0252..2edff7f58c25 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -545,6 +545,9 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 			    const char *func_data)
 {
 	int i;
+	bool result = false;
+	struct ima_rule_entry *lsm_rule = rule;
+	bool rule_reinitialized = false;
 
 	if ((rule->flags & IMA_FUNC) &&
 	    (rule->func != func && func != POST_SETATTR))
@@ -606,35 +609,55 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 		int rc = 0;
 		u32 osid;
 
-		if (!rule->lsm[i].rule) {
-			if (!rule->lsm[i].args_p)
+		if (!lsm_rule->lsm[i].rule) {
+			if (!lsm_rule->lsm[i].args_p)
 				continue;
 			else
 				return false;
 		}
+
+retry:
 		switch (i) {
 		case LSM_OBJ_USER:
 		case LSM_OBJ_ROLE:
 		case LSM_OBJ_TYPE:
 			security_inode_getsecid(inode, &osid);
-			rc = ima_filter_rule_match(osid, rule->lsm[i].type,
+			rc = ima_filter_rule_match(osid, lsm_rule->lsm[i].type,
 						   Audit_equal,
-						   rule->lsm[i].rule);
+						   lsm_rule->lsm[i].rule);
 			break;
 		case LSM_SUBJ_USER:
 		case LSM_SUBJ_ROLE:
 		case LSM_SUBJ_TYPE:
-			rc = ima_filter_rule_match(secid, rule->lsm[i].type,
+			rc = ima_filter_rule_match(secid, lsm_rule->lsm[i].type,
 						   Audit_equal,
-						   rule->lsm[i].rule);
+						   lsm_rule->lsm[i].rule);
 			break;
 		default:
 			break;
 		}
-		if (!rc)
-			return false;
+
+		if (rc == -ESTALE && !rule_reinitialized) {
+			lsm_rule = ima_lsm_copy_rule(rule);
+			if (lsm_rule) {
+				rule_reinitialized = true;
+				goto retry;
+			}
+		}
+		if (!rc) {
+			result = false;
+			goto out;
+		}
 	}
-	return true;
+	result = true;
+
+out:
+	if (rule_reinitialized) {
+		for (i = 0; i < MAX_LSM_RULES; i++)
+			ima_filter_rule_free(lsm_rule->lsm[i].rule);
+		kfree(lsm_rule);
+	}
+	return result;
 }
 
 /*
-- 
2.17.1


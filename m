Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3822B59E903
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Aug 2022 19:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344033AbiHWRQl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 Aug 2022 13:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344318AbiHWRP5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Aug 2022 13:15:57 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF46AA3DD
        for <linux-integrity@vger.kernel.org>; Tue, 23 Aug 2022 06:51:09 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MBrDK0PgHznTZL;
        Tue, 23 Aug 2022 21:48:49 +0800 (CST)
Received: from huawei.com (10.67.175.31) by dggpemm500024.china.huawei.com
 (7.185.36.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 23 Aug
 2022 21:51:07 +0800
From:   GUO Zihua <guozihua@huawei.com>
To:     <linux-integrity@vger.kernel.org>, <zohar@linux.ibm.com>,
        <dmitry.kasatkin@gmail.com>, <paul@paul-moore.com>
Subject: [PATCH v2] ima: Handle -ESTALE returned by ima_filter_rule_match()
Date:   Tue, 23 Aug 2022 21:47:56 +0800
Message-ID: <20220823134756.11222-1-guozihua@huawei.com>
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

IMA relies on the blocking LSM policy notifier callback to update the
LSM based IMA policy rules.

When SELinux update its policies, IMA would be notified and starts
updating all its lsm rules one-by-one. During this time, -ESTALE would
be returned by ima_filter_rule_match() if it is called with a LSM rule
that has not yet been updated. In ima_match_rules(), -ESTALE is not
handled, and the LSM rule is considered a match, causing extra files
to be measured by IMA.

Fix it by retrying for at most three times if -ESTALE is returned by
ima_filter_rule_match().

Fixes: b16942455193 ("ima: use the lsm policy update notifier")
Signed-off-by: GUO Zihua <guozihua@huawei.com>
---

v2:
  Fixes message errors pointed out by Mimi

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


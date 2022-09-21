Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343DB5BFE8F
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Sep 2022 15:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiIUNBy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 21 Sep 2022 09:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiIUNBw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 21 Sep 2022 09:01:52 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26368E446;
        Wed, 21 Sep 2022 06:01:50 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MXdjx6CZhzlW43;
        Wed, 21 Sep 2022 20:57:41 +0800 (CST)
Received: from huawei.com (10.67.175.31) by dggpemm500024.china.huawei.com
 (7.185.36.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 21 Sep
 2022 21:01:49 +0800
From:   GUO Zihua <guozihua@huawei.com>
To:     <zohar@linux.ibm.com>, <dmitry.kasatkin@gmail.com>,
        <paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>
Subject: [PATCH v5 1/2] ima: Simplify ima_lsm_copy_rule
Date:   Wed, 21 Sep 2022 20:58:03 +0800
Message-ID: <20220921125804.59490-2-guozihua@huawei.com>
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

Currently ima_lsm_copy_rule() set the arg_p field of the source rule to
NULL, so that the source rule could be freed afterward. It does not make
sense for this behavior to be inside a "copy" function. So move it
outside and let the caller handle this field.

ima_lsm_copy_rule() now produce a shallow copy of the original entry
including args_p field. Meaning only the lsm.rule and the rule itself
should be freed for the original rule. Thus, instead of calling
ima_lsm_free_rule() which frees lsm.rule as well as args_p field, free
the lsm.rule directly.

Signed-off-by: GUO Zihua <guozihua@huawei.com>
---
 security/integrity/ima/ima_policy.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index a8802b8da946..8040215c0252 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -398,12 +398,6 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
 
 		nentry->lsm[i].type = entry->lsm[i].type;
 		nentry->lsm[i].args_p = entry->lsm[i].args_p;
-		/*
-		 * Remove the reference from entry so that the associated
-		 * memory will not be freed during a later call to
-		 * ima_lsm_free_rule(entry).
-		 */
-		entry->lsm[i].args_p = NULL;
 
 		ima_filter_rule_init(nentry->lsm[i].type, Audit_equal,
 				     nentry->lsm[i].args_p,
@@ -417,6 +411,7 @@ static struct ima_rule_entry *ima_lsm_copy_rule(struct ima_rule_entry *entry)
 
 static int ima_lsm_update_rule(struct ima_rule_entry *entry)
 {
+	int i;
 	struct ima_rule_entry *nentry;
 
 	nentry = ima_lsm_copy_rule(entry);
@@ -431,7 +426,8 @@ static int ima_lsm_update_rule(struct ima_rule_entry *entry)
 	 * references and the entry itself. All other memory references will now
 	 * be owned by nentry.
 	 */
-	ima_lsm_free_rule(entry);
+	for (i = 0; i < MAX_LSM_RULES; i++)
+		ima_filter_rule_free(entry->lsm[i].rule);
 	kfree(entry);
 
 	return 0;
-- 
2.17.1


Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3517465669C
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Dec 2022 02:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbiL0BtV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 26 Dec 2022 20:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiL0BtU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Dec 2022 20:49:20 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7587FF21
        for <linux-integrity@vger.kernel.org>; Mon, 26 Dec 2022 17:49:19 -0800 (PST)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NgyGT6RjczmWSl;
        Tue, 27 Dec 2022 09:48:01 +0800 (CST)
Received: from huawei.com (10.67.175.31) by dggpemm500024.china.huawei.com
 (7.185.36.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 27 Dec
 2022 09:49:17 +0800
From:   GUO Zihua <guozihua@huawei.com>
To:     <zohar@linux.ibm.com>, <dmitry.kasatkin@gmail.com>
CC:     <linux-integrity@vger.kernel.org>
Subject: [PATCH] ima: Handle error code from security_audit_rule_match
Date:   Tue, 27 Dec 2022 09:46:33 +0800
Message-ID: <20221227014633.4449-1-guozihua@huawei.com>
X-Mailer: git-send-email 2.17.1
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

commit c7423dbdbc9e ("ima: Handle -ESTALE returned by
ima_filter_rule_match()") introduced the handling of -ESTALE returned by
security_audit_rule_match(). However, security_audit_rule_match() might
return other error codes if some error occurred. We should handle those
error codes as well.

Fixes: c7423dbdbc9e ("ima: Handle -ESTALE returned by ima_filter_rule_match()")
Signed-off-by: GUO Zihua <guozihua@huawei.com>
---
 security/integrity/ima/ima_policy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 6a68ec270822..5561e1b2c376 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -663,7 +663,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 			break;
 		}
 
-		if (rc == -ESTALE && !rule_reinitialized) {
+		if (rc < 0 && !rule_reinitialized) {
 			lsm_rule = ima_lsm_copy_rule(rule);
 			if (lsm_rule) {
 				rule_reinitialized = true;
-- 
2.17.1


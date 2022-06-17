Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1280754F238
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Jun 2022 09:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380138AbiFQHwG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 17 Jun 2022 03:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234463AbiFQHwG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 Jun 2022 03:52:06 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9671C674FE
        for <linux-integrity@vger.kernel.org>; Fri, 17 Jun 2022 00:52:04 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LPWRG0GL9zhXZT;
        Fri, 17 Jun 2022 15:50:02 +0800 (CST)
Received: from huawei.com (10.67.175.31) by dggpemm500024.china.huawei.com
 (7.185.36.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 17 Jun
 2022 15:51:56 +0800
From:   GUO Zihua <guozihua@huawei.com>
To:     <linux-integrity@vger.kernel.org>
CC:     <zohar@linux.ibm.com>, <dmitry.kasatkin@gmail.com>
Subject: [PATCH -next] ima: Refactor hash algo compatibility check
Date:   Fri, 17 Jun 2022 15:49:47 +0800
Message-ID: <20220617074947.56054-1-guozihua@huawei.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.31]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

Make ima_template_hash_algo_allowed a utility function and refector the
compatibility checks in a couple places. This should unify the
compatibility check and make the code more streamlined.

Also, rename the i in hash_setup to algo.

No functional change in this patch.

Signed-off-by: GUO Zihua <guozihua@huawei.com>
---
 security/integrity/ima/ima_main.c         | 23 ++++++++++-------------
 security/integrity/ima/ima_template.c     |  2 +-
 security/integrity/ima/ima_template_lib.c |  8 --------
 security/integrity/ima/ima_template_lib.h |  8 ++++++++
 4 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 040b03ddc1c7..a2c532f82717 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -28,6 +28,7 @@
 #include <linux/fs.h>
 
 #include "ima.h"
+#include "ima_template_lib.h"
 
 #ifdef CONFIG_IMA_APPRAISE
 int ima_appraise = IMA_APPRAISE_ENFORCE;
@@ -45,17 +46,19 @@ static struct notifier_block ima_lsm_policy_notifier = {
 static int __init hash_setup(char *str)
 {
 	struct ima_template_desc *template_desc = ima_template_desc_current();
-	int i;
+	int algo;
 
 	if (hash_setup_done)
 		return 1;
 
+	algo = match_string(hash_algo_name, HASH_ALGO__LAST, str);
+	if (algo < 0) {
+		pr_err("invalid hash algorithm \"%s\"", str);
+		return 1;
+	}
+
 	if (strcmp(template_desc->name, IMA_TEMPLATE_IMA_NAME) == 0) {
-		if (strncmp(str, "sha1", 4) == 0) {
-			ima_hash_algo = HASH_ALGO_SHA1;
-		} else if (strncmp(str, "md5", 3) == 0) {
-			ima_hash_algo = HASH_ALGO_MD5;
-		} else {
+		if (ima_template_hash_algo_allowed(algo)) {
 			pr_err("invalid hash algorithm \"%s\" for template \"%s\"",
 				str, IMA_TEMPLATE_IMA_NAME);
 			return 1;
@@ -63,13 +66,7 @@ static int __init hash_setup(char *str)
 		goto out;
 	}
 
-	i = match_string(hash_algo_name, HASH_ALGO__LAST, str);
-	if (i < 0) {
-		pr_err("invalid hash algorithm \"%s\"", str);
-		return 1;
-	}
-
-	ima_hash_algo = i;
+	ima_hash_algo = algo;
 out:
 	hash_setup_done = 1;
 	return 1;
diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index c25079faa208..b030edb33fa6 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -128,7 +128,7 @@ static int __init ima_template_setup(char *str)
 	 * by the 'ima' template.
 	 */
 	if (template_len == 3 && strcmp(str, IMA_TEMPLATE_IMA_NAME) == 0 &&
-	    ima_hash_algo != HASH_ALGO_SHA1 && ima_hash_algo != HASH_ALGO_MD5) {
+	    !ima_template_hash_algo_allowed(ima_hash_algo)) {
 		pr_err("template does not support hash alg\n");
 		return 1;
 	}
diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index c877f01a5471..7efae3041a40 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -13,14 +13,6 @@
 #include <linux/xattr.h>
 #include <linux/evm.h>
 
-static bool ima_template_hash_algo_allowed(u8 algo)
-{
-	if (algo == HASH_ALGO_SHA1 || algo == HASH_ALGO_MD5)
-		return true;
-
-	return false;
-}
-
 enum data_formats {
 	DATA_FMT_DIGEST = 0,
 	DATA_FMT_DIGEST_WITH_ALGO,
diff --git a/security/integrity/ima/ima_template_lib.h b/security/integrity/ima/ima_template_lib.h
index 9f7c335f304f..c4663595f1c8 100644
--- a/security/integrity/ima/ima_template_lib.h
+++ b/security/integrity/ima/ima_template_lib.h
@@ -66,4 +66,12 @@ int ima_eventinodexattrlengths_init(struct ima_event_data *event_data,
 				    struct ima_field_data *field_data);
 int ima_eventinodexattrvalues_init(struct ima_event_data *event_data,
 				   struct ima_field_data *field_data);
+
+static inline bool ima_template_hash_algo_allowed(int algo)
+{
+	if (algo == HASH_ALGO_SHA1 || algo == HASH_ALGO_MD5)
+		return true;
+
+	return false;
+}
 #endif /* __LINUX_IMA_TEMPLATE_LIB_H */
-- 
2.36.0


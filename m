Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752DB626885
	for <lists+linux-integrity@lfdr.de>; Sat, 12 Nov 2022 10:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234784AbiKLJbZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 12 Nov 2022 04:31:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234562AbiKLJbW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 12 Nov 2022 04:31:22 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69D51DF3B;
        Sat, 12 Nov 2022 01:31:21 -0800 (PST)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N8VbX4YmNzbnb0;
        Sat, 12 Nov 2022 17:27:36 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 12 Nov 2022 17:31:20 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <zohar@linux.ibm.com>, <dmitry.kasatkin@gmail.com>,
        <paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
        <roberto.sassu@polito.it>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <roberto.sassu@huawei.com>
Subject: [PATCH] ima: Fix misuse of dereference of pointer in template_desc_init_fields()
Date:   Sat, 12 Nov 2022 17:27:19 +0800
Message-ID: <20221112092719.224888-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The input parameter @fields is type of struct ima_template_field ***, so
when allocates array memory for @fields, the size of element should be
sizeof(**field) instead of sizeof(*field).

Actually the original code would not cause any runtime error, but it's
better to make it logically right.

Fixes: adf53a778a0a ("ima: new templates management mechanism")
Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 security/integrity/ima/ima_template.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima_template.c b/security/integrity/ima/ima_template.c
index 49f0626928a1..04c49f05cb74 100644
--- a/security/integrity/ima/ima_template.c
+++ b/security/integrity/ima/ima_template.c
@@ -245,11 +245,11 @@ int template_desc_init_fields(const char *template_fmt,
 	}
 
 	if (fields && num_fields) {
-		*fields = kmalloc_array(i, sizeof(*fields), GFP_KERNEL);
+		*fields = kmalloc_array(i, sizeof(**fields), GFP_KERNEL);
 		if (*fields == NULL)
 			return -ENOMEM;
 
-		memcpy(*fields, found_fields, i * sizeof(*fields));
+		memcpy(*fields, found_fields, i * sizeof(**fields));
 		*num_fields = i;
 	}
 
-- 
2.17.1


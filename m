Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA0E5ACD55
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Sep 2022 10:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237166AbiIEH6v (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 5 Sep 2022 03:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237183AbiIEH6n (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Sep 2022 03:58:43 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E0A26ACA;
        Mon,  5 Sep 2022 00:58:41 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MLglx12QZzkWJl;
        Mon,  5 Sep 2022 15:54:53 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 5 Sep 2022 15:58:38 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <zohar@linux.ibm.com>, <dmitry.kasatkin@gmail.com>,
        <paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
        <cuigaosheng1@huawei.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next 2/4] ima: Use DECLARE_FLEX_ARRAY() helper in ima_template_entry
Date:   Mon, 5 Sep 2022 15:58:35 +0800
Message-ID: <20220905075837.1083216-3-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220905075837.1083216-1-cuigaosheng1@huawei.com>
References: <20220905075837.1083216-1-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Zero-length arrays are deprecated and we are moving towards adopting
C99 flexible-array members instead. So, replace zero-length array
declaration with the new DECLARE_FLEX_ARRAY() helper macro in struct
ima_template_entry.

This helper allows for a flexible-array member in a union.

Link: KSPP#21
Link: KSPP#193
Link: KSPP#197
Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 security/integrity/ima/ima.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index be965a8715e4..15687e79944b 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -100,7 +100,7 @@ struct ima_template_entry {
 	struct tpm_digest *digests;
 	struct ima_template_desc *template_desc; /* template descriptor */
 	u32 template_data_len;
-	struct ima_field_data template_data[];	/* template related data */
+	DECLARE_FLEX_ARRAY(struct ima_field_data, template_data); /* template related data */
 };
 
 struct ima_queue_entry {
-- 
2.25.1


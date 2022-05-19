Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1271152C9EC
	for <lists+linux-integrity@lfdr.de>; Thu, 19 May 2022 04:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbiESCsj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 May 2022 22:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbiESCsi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 May 2022 22:48:38 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22733AFB33;
        Wed, 18 May 2022 19:48:37 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L3Z5r6ZVtzhZGM;
        Thu, 19 May 2022 10:47:44 +0800 (CST)
Received: from huawei.com (10.67.175.31) by dggpemm500024.china.huawei.com
 (7.185.36.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 19 May
 2022 10:48:35 +0800
From:   GUO Zihua <guozihua@huawei.com>
To:     <linux-integrity@vger.kernel.org>
CC:     <zohar@linux.ibm.com>, <dhowells@redhat.com>, <jarkko@kernel.org>,
        <keyrings@vger.kernel.org>
Subject: [PATCH] keys: Use struct_size and size_add helper with alloc
Date:   Thu, 19 May 2022 10:47:02 +0800
Message-ID: <20220519024702.215223-1-guozihua@huawei.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.31]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

Use struct_size helper for calculating size of flexible struct to avoid
potential issues and improve readibility. Use size_add to calculate
addition of size to prevent potential issues.

Reference: https://lore.kernel.org/all/CAHk-=wiGWjxs7EVUpccZEi6esvjpHJdgHQ=vtUeJ5crL62hx9A@mail.gmail.com/

Note: HASH_SIZE here is a SHA256_DIGEST_SIZE whoes value is 32, so
adding 1 should be fine here.

Signed-off-by: GUO Zihua <guozihua@huawei.com>
---
 security/keys/encrypted-keys/encrypted.c | 7 +++++--
 security/keys/user_defined.c             | 2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encrypted-keys/encrypted.c
index e05cfc2e49ae..37349580e855 100644
--- a/security/keys/encrypted-keys/encrypted.c
+++ b/security/keys/encrypted-keys/encrypted.c
@@ -613,6 +613,7 @@ static struct encrypted_key_payload *encrypted_key_alloc(struct key *key,
 	long dlen;
 	int i;
 	int ret;
+	size_t epayload_datalen = 0;
 
 	ret = kstrtol(datalen, 10, &dlen);
 	if (ret < 0 || dlen < MIN_DATA_SIZE || dlen > MAX_DATA_SIZE)
@@ -667,8 +668,10 @@ static struct encrypted_key_payload *encrypted_key_alloc(struct key *key,
 	if (ret < 0)
 		return ERR_PTR(ret);
 
-	epayload = kzalloc(sizeof(*epayload) + payload_datalen +
-			   datablob_len + HASH_SIZE + 1, GFP_KERNEL);
+	epayload_datalen = size_add(payload_datalen, datablob_len);
+	epayload_datalen = size_add(epayload_datalen, HASH_SIZE + 1);
+	epayload = kzalloc(struct_size(epayload, payload_data,
+				epayload_datalen), GFP_KERNEL);
 	if (!epayload)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/security/keys/user_defined.c b/security/keys/user_defined.c
index 749e2a4dcb13..334fed36e9f3 100644
--- a/security/keys/user_defined.c
+++ b/security/keys/user_defined.c
@@ -64,7 +64,7 @@ int user_preparse(struct key_preparsed_payload *prep)
 	if (datalen <= 0 || datalen > 32767 || !prep->data)
 		return -EINVAL;
 
-	upayload = kmalloc(sizeof(*upayload) + datalen, GFP_KERNEL);
+	upayload = kmalloc(struct_size(upayload, data, datalen), GFP_KERNEL);
 	if (!upayload)
 		return -ENOMEM;
 
-- 
2.36.0


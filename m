Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECCF053EBEE
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Jun 2022 19:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbiFFKPz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Jun 2022 06:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbiFFKO5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Jun 2022 06:14:57 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452B315A42A;
        Mon,  6 Jun 2022 03:12:45 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LGq6g48zjzpVmH;
        Mon,  6 Jun 2022 18:12:27 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 6 Jun 2022 18:12:43 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <zohar@linux.ibm.com>, <dmitry.kasatkin@gmail.com>,
        <jmorris@namei.org>, <serge@hallyn.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] evm: Use IS_ENABLED to initialize .enabled
Date:   Mon, 6 Jun 2022 18:10:42 +0800
Message-ID: <20220606101042.89638-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Use IS_ENABLED(CONFIG_XXX) instead of #ifdef/#endif statements to
initialize .enabled, minor simplicity improvement.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 security/integrity/evm/evm_main.c | 52 ++++++++++++++-----------------
 1 file changed, 23 insertions(+), 29 deletions(-)

diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index cc88f02c7562..397fea5b3fa6 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -36,42 +36,36 @@ static const char * const integrity_status_msg[] = {
 int evm_hmac_attrs;
 
 static struct xattr_list evm_config_default_xattrnames[] = {
-	{.name = XATTR_NAME_SELINUX,
-#ifdef CONFIG_SECURITY_SELINUX
-	 .enabled = true
-#endif
+	{
+	 .name = XATTR_NAME_SELINUX,
+	 .enabled = IS_ENABLED(CONFIG_SECURITY_SELINUX)
 	},
-	{.name = XATTR_NAME_SMACK,
-#ifdef CONFIG_SECURITY_SMACK
-	 .enabled = true
-#endif
+	{
+	 .name = XATTR_NAME_SMACK,
+	 .enabled = IS_ENABLED(CONFIG_SECURITY_SMACK)
 	},
-	{.name = XATTR_NAME_SMACKEXEC,
-#ifdef CONFIG_EVM_EXTRA_SMACK_XATTRS
-	 .enabled = true
-#endif
+	{
+	 .name = XATTR_NAME_SMACKEXEC,
+	 .enabled = IS_ENABLED(CONFIG_EVM_EXTRA_SMACK_XATTRS)
 	},
-	{.name = XATTR_NAME_SMACKTRANSMUTE,
-#ifdef CONFIG_EVM_EXTRA_SMACK_XATTRS
-	 .enabled = true
-#endif
+	{
+	 .name = XATTR_NAME_SMACKTRANSMUTE,
+	 .enabled = IS_ENABLED(CONFIG_EVM_EXTRA_SMACK_XATTRS)
 	},
-	{.name = XATTR_NAME_SMACKMMAP,
-#ifdef CONFIG_EVM_EXTRA_SMACK_XATTRS
-	 .enabled = true
-#endif
+	{
+	 .name = XATTR_NAME_SMACKMMAP,
+	 .enabled = IS_ENABLED(CONFIG_EVM_EXTRA_SMACK_XATTRS)
 	},
-	{.name = XATTR_NAME_APPARMOR,
-#ifdef CONFIG_SECURITY_APPARMOR
-	 .enabled = true
-#endif
+	{
+	 .name = XATTR_NAME_APPARMOR,
+	 .enabled = IS_ENABLED(CONFIG_SECURITY_APPARMOR)
 	},
-	{.name = XATTR_NAME_IMA,
-#ifdef CONFIG_IMA_APPRAISE
-	 .enabled = true
-#endif
+	{
+	 .name = XATTR_NAME_IMA,
+	 .enabled = IS_ENABLED(CONFIG_IMA_APPRAISE)
 	},
-	{.name = XATTR_NAME_CAPS,
+	{
+	 .name = XATTR_NAME_CAPS,
 	 .enabled = true
 	},
 };
-- 
2.17.1


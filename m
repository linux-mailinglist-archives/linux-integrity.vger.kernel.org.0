Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6854D5ACD50
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Sep 2022 10:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237229AbiIEH6t (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 5 Sep 2022 03:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237188AbiIEH6o (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Sep 2022 03:58:44 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229F2474E9;
        Mon,  5 Sep 2022 00:58:41 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MLgmD0wjmzmV7N;
        Mon,  5 Sep 2022 15:55:08 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 5 Sep 2022 15:58:39 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <zohar@linux.ibm.com>, <dmitry.kasatkin@gmail.com>,
        <paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
        <cuigaosheng1@huawei.com>
CC:     <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next 4/4] integrity: Use DECLARE_FLEX_ARRAY() helper in integrity.h
Date:   Mon, 5 Sep 2022 15:58:37 +0800
Message-ID: <20220905075837.1083216-5-cuigaosheng1@huawei.com>
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
declarations with the new DECLARE_FLEX_ARRAY() helper macro in
integrity.h.

As follows:
	struct evm_ima_xattr_data,
	struct ima_digest_data,
	struct signature_v2_hdr,

This helper allows for a flexible-array member in a union.

Link: KSPP#21
Link: KSPP#193
Link: KSPP#197
Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 security/integrity/integrity.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 7167a6e99bdc..3eeea8d630e0 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -85,7 +85,7 @@ enum evm_ima_xattr_type {
 
 struct evm_ima_xattr_data {
 	u8 type;
-	u8 data[];
+	DECLARE_FLEX_ARRAY(u8, data);
 } __packed;
 
 /* Only used in the EVM HMAC code. */
@@ -110,7 +110,7 @@ struct ima_digest_data {
 		} ng;
 		u8 data[2];
 	} xattr;
-	u8 digest[];
+	DECLARE_FLEX_ARRAY(u8, digest);
 } __packed;
 
 /*
@@ -138,7 +138,7 @@ struct signature_v2_hdr {
 	uint8_t	hash_algo;	/* Digest algorithm [enum hash_algo] */
 	__be32 keyid;		/* IMA key identifier - not X509/PGP specific */
 	__be16 sig_size;	/* signature size */
-	uint8_t sig[];		/* signature payload */
+	DECLARE_FLEX_ARRAY(uint8_t, sig); /* signature payload */
 } __packed;
 
 /*
-- 
2.25.1


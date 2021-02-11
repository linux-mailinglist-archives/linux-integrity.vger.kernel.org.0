Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A699318498
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Feb 2021 06:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbhBKFXZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 11 Feb 2021 00:23:25 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:44307 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229674AbhBKFXY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Feb 2021 00:23:24 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R381e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UOOwYsg_1613020961;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UOOwYsg_1613020961)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 11 Feb 2021 13:22:41 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        linux-integrity@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>
Cc:     tianjia.zhang@linux.alibaba.com
Subject: [PATCH ima-evm-utils v2] ima-evm-utils: Support SM2 algorithm for sign and verify
Date:   Thu, 11 Feb 2021 13:22:41 +0800
Message-Id: <20210211052241.91068-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.3.ge56e4f7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The combination of SM2 and SM3 algorithms has been implemented in the
kernel. At present, the ima-evm-utils signature tool does not support
this combination of algorithms. Because in the current version of
OpenSSL 1.1.1, the SM2 algorithm and the public key using the EC
algorithm share the same ID 'EVP_PKEY_EC', and the specific algorithm
can only be distinguished by the curve name used. This patch supports
this feature.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 src/libimaevm.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index fa6c278..589dd09 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -518,6 +518,16 @@ static int verify_hash_v2(const char *file, const unsigned char *hash, int size,
 		return -1;
 	}
 
+#ifdef EVP_PKEY_SM2
+	/* If EC key are used, check whether it is SM2 key */
+	if (EVP_PKEY_id(pkey) == EVP_PKEY_EC) {
+		EC_KEY *ec = EVP_PKEY_get0_EC_KEY(pkey);
+		int curve = EC_GROUP_get_curve_name(EC_KEY_get0_group(ec));
+		if (curve == NID_sm2)
+			EVP_PKEY_set_alias_type(pkey, EVP_PKEY_SM2);
+	}
+#endif
+
 	st = "EVP_PKEY_CTX_new";
 	if (!(ctx = EVP_PKEY_CTX_new(pkey, NULL)))
 		goto err;
@@ -932,6 +942,16 @@ static int sign_hash_v2(const char *algo, const unsigned char *hash,
 		return -1;
 	}
 
+#ifdef EVP_PKEY_SM2
+	/* If EC key are used, check whether it is SM2 key */
+	if (EVP_PKEY_id(pkey) == EVP_PKEY_EC) {
+		EC_KEY *ec = EVP_PKEY_get0_EC_KEY(pkey);
+		int curve = EC_GROUP_get_curve_name(EC_KEY_get0_group(ec));
+		if (curve == NID_sm2)
+			EVP_PKEY_set_alias_type(pkey, EVP_PKEY_SM2);
+	}
+#endif
+
 	calc_keyid_v2(&keyid, name, pkey);
 	hdr->keyid = keyid;
 
-- 
2.19.1.3.ge56e4f7


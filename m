Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A979E21825C
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Jul 2020 10:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgGHI2i (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Jul 2020 04:28:38 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:55649 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727119AbgGHI2d (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Jul 2020 04:28:33 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R441e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0U26.E3t_1594196905;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0U26.E3t_1594196905)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 08 Jul 2020 16:28:25 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        dhowells@redhat.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, jmorris@namei.org, serge@hallyn.com,
        nramas@linux.microsoft.com, tusharsu@linux.microsoft.com,
        zohar@linux.ibm.com, gilad@benyossef.com, pvanleeuwen@rambus.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, zhang.jia@linux.alibaba.com,
        tianjia.zhang@linux.alibaba.com
Subject: [PATCH v4 8/8] integrity: Asymmetric digsig supports SM2-with-SM3 algorithm
Date:   Wed,  8 Jul 2020 16:28:18 +0800
Message-Id: <20200708082818.5511-9-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200708082818.5511-1-tianjia.zhang@linux.alibaba.com>
References: <20200708082818.5511-1-tianjia.zhang@linux.alibaba.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Asymmetric digsig supports SM2-with-SM3 algorithm combination,
so that IMA can also verify SM2's signature data.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 security/integrity/digsig_asymmetric.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/security/integrity/digsig_asymmetric.c b/security/integrity/digsig_asymmetric.c
index 4e0d6778277e..9350fcfb9bf2 100644
--- a/security/integrity/digsig_asymmetric.c
+++ b/security/integrity/digsig_asymmetric.c
@@ -99,14 +99,22 @@ int asymmetric_verify(struct key *keyring, const char *sig,
 	memset(&pks, 0, sizeof(pks));
 
 	pks.hash_algo = hash_algo_name[hdr->hash_algo];
-	if (hdr->hash_algo == HASH_ALGO_STREEBOG_256 ||
-	    hdr->hash_algo == HASH_ALGO_STREEBOG_512) {
+	switch (hdr->hash_algo) {
+	case HASH_ALGO_STREEBOG_256:
+	case HASH_ALGO_STREEBOG_512:
 		/* EC-RDSA and Streebog should go together. */
 		pks.pkey_algo = "ecrdsa";
 		pks.encoding = "raw";
-	} else {
+		break;
+	case HASH_ALGO_SM3_256:
+		/* SM2 and SM3 should go together. */
+		pks.pkey_algo = "sm2";
+		pks.encoding = "raw";
+		break;
+	default:
 		pks.pkey_algo = "rsa";
 		pks.encoding = "pkcs1";
+		break;
 	}
 	pks.digest = (u8 *)data;
 	pks.digest_size = datalen;
-- 
2.17.1


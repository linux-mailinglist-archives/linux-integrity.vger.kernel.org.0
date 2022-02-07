Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6BCA4ABF2F
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Feb 2022 14:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352081AbiBGNAj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 7 Feb 2022 08:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388333AbiBGLnd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 7 Feb 2022 06:43:33 -0500
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1427C043181;
        Mon,  7 Feb 2022 03:43:31 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0V3r3syy_1644234208;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0V3r3syy_1644234208)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 07 Feb 2022 19:43:28 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     Eric Biggers <ebiggers@google.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "Gilad Ben-Yossef" <gilad@benyossef.com>,
        David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: [PATCH] KEYS: asymmetric: enforce SM2 signature use pkey algo
Date:   Mon,  7 Feb 2022 19:43:27 +0800
Message-Id: <20220207114327.7929-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220201003414.55380-1-ebiggers@kernel.org>
References: <20220201003414.55380-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The signature verification of SM2 needs to add the Za value and
recalculate sig->digest, which requires the detection of the pkey_algo
in public_key_verify_signature(). As Eric Biggers said, the pkey_algo
field in sig is attacker-controlled and should be use pkey->pkey_algo
instead of sig->pkey_algo, and secondly, if sig->pkey_algo is NULL, it
will also cause signature verification failure.

The software_key_determine_akcipher() already forces the algorithms
are matched, so the SM3 algorithm is enforced in the SM2 signature,
although this has been checked, we still avoid using any algorithm
information in the signature as input.

Reported-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 crypto/asymmetric_keys/public_key.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
index a603ee8afdb8..ea9a5501f87e 100644
--- a/crypto/asymmetric_keys/public_key.c
+++ b/crypto/asymmetric_keys/public_key.c
@@ -309,7 +309,8 @@ static int cert_sig_digest_update(const struct public_key_signature *sig,
 	if (ret)
 		return ret;
 
-	tfm = crypto_alloc_shash(sig->hash_algo, 0, 0);
+	/* SM2 signatures always use the SM3 hash algorithm */
+	tfm = crypto_alloc_shash("sm3", 0, 0);
 	if (IS_ERR(tfm))
 		return PTR_ERR(tfm);
 
@@ -414,8 +415,7 @@ int public_key_verify_signature(const struct public_key *pkey,
 	if (ret)
 		goto error_free_key;
 
-	if (sig->pkey_algo && strcmp(sig->pkey_algo, "sm2") == 0 &&
-	    sig->data_size) {
+	if (strcmp(pkey->pkey_algo, "sm2") == 0 && sig->data_size) {
 		ret = cert_sig_digest_update(sig, tfm);
 		if (ret)
 			goto error_free_key;
-- 
2.34.1


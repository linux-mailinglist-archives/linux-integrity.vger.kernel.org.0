Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A30057DC3B
	for <lists+linux-integrity@lfdr.de>; Fri, 22 Jul 2022 10:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234917AbiGVIWZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 22 Jul 2022 04:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234956AbiGVIWW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 22 Jul 2022 04:22:22 -0400
Received: from mail-m973.mail.163.com (mail-m973.mail.163.com [123.126.97.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A30749E2A8;
        Fri, 22 Jul 2022 01:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=jT8xe
        TD2gI4EzRHhvnNsYVU4bZ3vev/hiB/gq6Vqy48=; b=drJmURO5QCePd0ZjqcF3V
        BbMNClINUkt5AQLtJPIhlN+GbTphU0hBTVEXEeiklCQqQX4Kl0+fpqoTHmW+wvcL
        T+jWpHDsQuOxpTWfONUUZZzqkBjFuRNy25JKPPoyVRRSJXRAkI3P1J736AbTfXOR
        22SHlPJXmXiBUd/55CTXso=
Received: from localhost.localdomain (unknown [123.112.69.106])
        by smtp3 (Coremail) with SMTP id G9xpCgDnRmMHXtpiTpGIQg--.59076S4;
        Fri, 22 Jul 2022 16:21:44 +0800 (CST)
From:   Jianglei Nie <niejianglei2021@163.com>
To:     jejb@linux.ibm.com, jarkko@kernel.org, zohar@linux.ibm.com,
        dhowells@redhat.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jianglei Nie <niejianglei2021@163.com>
Subject: [PATCH v3] KEYS: trusted: Fix memory leak in tpm2_key_encode()
Date:   Fri, 22 Jul 2022 16:21:25 +0800
Message-Id: <20220722082125.2526529-1-niejianglei2021@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YqGE/v0Zgi+g4gY6@iki.fi>
References: <YqGE/v0Zgi+g4gY6@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: G9xpCgDnRmMHXtpiTpGIQg--.59076S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxZr4UGF4DAw43Zr17Zr4DXFb_yoW5Ww1fpF
        W3KF1jqrWavry7AryxAF4Sv3WSkw1rtFW7KwsFq397GasxJFsxtFy7Ar4Ygr17AFWSqw15
        ZFWqvFWUuFZFqrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR4SoAUUUUU=
X-Originating-IP: [123.112.69.106]
X-CM-SenderInfo: xqlhyxxdqjzvrlsqjii6rwjhhfrp/1tbiWxlGjGI0VjNM6gAAsd
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

tpm2_key_encode() allocates a memory chunk from scratch with kmalloc(),
but it is never freed, which leads to a memory leak. Free the memory
chunk with kfree() in the return path.

Fixes: f2219745250f ("security: keys: trusted: use ASN.1 TPM2 key format for the blobs")
Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
---
 security/keys/trusted-keys/trusted_tpm2.c | 33 ++++++++++++++++-------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 2b2c8eb258d5..eb25c784b5c3 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -32,8 +32,13 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
 			   struct trusted_key_options *options,
 			   u8 *src, u32 len)
 {
+	int ret;
 	const int SCRATCH_SIZE = PAGE_SIZE;
-	u8 *scratch = kmalloc(SCRATCH_SIZE, GFP_KERNEL);
+	u8 *scratch;
+
+	scratch = kmalloc(SCRATCH_SIZE, GFP_KERNEL);
+	if (!scratch)
+		return -ENOMEM;
 	u8 *work = scratch, *work1;
 	u8 *end_work = scratch + SCRATCH_SIZE;
 	u8 *priv, *pub;
@@ -47,9 +52,6 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
 	pub_len = get_unaligned_be16(src) + 2;
 	pub = src;
 
-	if (!scratch)
-		return -ENOMEM;
-
 	work = asn1_encode_oid(work, end_work, tpm2key_oid,
 			       asn1_oid_len(tpm2key_oid));
 
@@ -57,8 +59,10 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
 		unsigned char bool[3], *w = bool;
 		/* tag 0 is emptyAuth */
 		w = asn1_encode_boolean(w, w + sizeof(bool), true);
-		if (WARN(IS_ERR(w), "BUG: Boolean failed to encode"))
-			return PTR_ERR(w);
+		if (WARN(IS_ERR(w), "BUG: Boolean failed to encode")) {
+			ret = PTR_ERR(w);
+			goto err;
+		}
 		work = asn1_encode_tag(work, end_work, 0, bool, w - bool);
 	}
 
@@ -69,8 +73,10 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
 	 * trigger, so if it does there's something nefarious going on
 	 */
 	if (WARN(work - scratch + pub_len + priv_len + 14 > SCRATCH_SIZE,
-		 "BUG: scratch buffer is too small"))
-		return -EINVAL;
+		 "BUG: scratch buffer is too small")) {
+		ret = -EINVAL;
+		goto err;
+	}
 
 	work = asn1_encode_integer(work, end_work, options->keyhandle);
 	work = asn1_encode_octet_string(work, end_work, pub, pub_len);
@@ -79,10 +85,17 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
 	work1 = payload->blob;
 	work1 = asn1_encode_sequence(work1, work1 + sizeof(payload->blob),
 				     scratch, work - scratch);
-	if (WARN(IS_ERR(work1), "BUG: ASN.1 encoder failed"))
-		return PTR_ERR(work1);
+	if (WARN(IS_ERR(work1), "BUG: ASN.1 encoder failed")) {
+		ret = PTR_ERR(work1);
+		goto err;
+	}
 
+	kfree(scratch);
 	return work1 - payload->blob;
+
+err:
+	kfree(scratch);
+	return ret;
 }
 
 struct tpm2_key_context {
-- 
2.25.1


Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F179543133
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Jun 2022 15:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240100AbiFHNSe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Jun 2022 09:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239852AbiFHNSd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Jun 2022 09:18:33 -0400
Received: from mail-m972.mail.163.com (mail-m972.mail.163.com [123.126.97.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2C76213E9D;
        Wed,  8 Jun 2022 06:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Uc2eR
        OBipVEKbx7H4/9ChTYVlx7gRDpLoRebVKl96J4=; b=fPZORH0u10U+rE1+rBTzr
        Ku1TFiwVPZuuwE+i7jh1ZDQzq7J6UGjYrDmz73nCxOEc4FO+EmzRI1zFH7Cr0ZTP
        1bveFXdzbK7GP15/jclcOXIvdEDbcwBkqHhdXJdyFttWfY1KSt8q3lO6o3EToV44
        408vuDKvgBjKBgu+Z4qlUQ=
Received: from localhost.localdomain (unknown [123.112.69.106])
        by smtp2 (Coremail) with SMTP id GtxpCgCHlQFwoaBiouWXHg--.33435S4;
        Wed, 08 Jun 2022 21:17:50 +0800 (CST)
From:   Jianglei Nie <niejianglei2021@163.com>
To:     jejb@linux.ibm.com, jarkko@kernel.org, zohar@linux.ibm.com,
        dhowells@redhat.com, jmorris@namei.org, serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jianglei Nie <niejianglei2021@163.com>
Subject: [PATCH v2] KEYS: trusted: Fix memory leak in tpm2_key_encode()
Date:   Wed,  8 Jun 2022 21:17:32 +0800
Message-Id: <20220608131732.550234-1-niejianglei2021@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GtxpCgCHlQFwoaBiouWXHg--.33435S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7urWxGF17Wr1rCF1UKrWrGrg_yoW8KrWDpF
        ZxKF13XrWavry3Ary3JF4SvaySkw1rGF42gws2g397GasxJFsrKFy2yr4Ygr13AFWFqw15
        ZFWDZFWUuFWqqr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRID7fUUUUU=
X-Originating-IP: [123.112.69.106]
X-CM-SenderInfo: xqlhyxxdqjzvrlsqjii6rwjhhfrp/1tbiQxAajFc7Z8QdDwAAsY
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

tpm2_key_encode() allocates a memory chunk from scratch with kmalloc(),
but it is never freed, which leads to a memory leak. Free the memory
chunk with kfree() in the return path.

Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
---
 security/keys/trusted-keys/trusted_tpm2.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 0165da386289..8b7ab22950d1 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -32,6 +32,7 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
 			   struct trusted_key_options *options,
 			   u8 *src, u32 len)
 {
+	int err;
 	const int SCRATCH_SIZE = PAGE_SIZE;
 	u8 *scratch = kmalloc(SCRATCH_SIZE, GFP_KERNEL);
 	u8 *work = scratch, *work1;
@@ -57,8 +58,10 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
 		unsigned char bool[3], *w = bool;
 		/* tag 0 is emptyAuth */
 		w = asn1_encode_boolean(w, w + sizeof(bool), true);
-		if (WARN(IS_ERR(w), "BUG: Boolean failed to encode"))
-			return PTR_ERR(w);
+		if (WARN(IS_ERR(w), "BUG: Boolean failed to encode")) {
+			err = PTR_ERR(w);
+			goto out;
+		}
 		work = asn1_encode_tag(work, end_work, 0, bool, w - bool);
 	}
 
@@ -69,8 +72,10 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
 	 * trigger, so if it does there's something nefarious going on
 	 */
 	if (WARN(work - scratch + pub_len + priv_len + 14 > SCRATCH_SIZE,
-		 "BUG: scratch buffer is too small"))
-		return -EINVAL;
+		 "BUG: scratch buffer is too small")) {
+		err = -EINVAL;
+		goto out;
+	}
 
 	work = asn1_encode_integer(work, end_work, options->keyhandle);
 	work = asn1_encode_octet_string(work, end_work, pub, pub_len);
@@ -79,10 +84,16 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
 	work1 = payload->blob;
 	work1 = asn1_encode_sequence(work1, work1 + sizeof(payload->blob),
 				     scratch, work - scratch);
-	if (WARN(IS_ERR(work1), "BUG: ASN.1 encoder failed"))
-		return PTR_ERR(work1);
+	if (WARN(IS_ERR(work1), "BUG: ASN.1 encoder failed")) {
+		err = -EINVAL;
+		goto out;
+	}
+	kfree(scratch);
 
 	return work1 - payload->blob;
+
+out:
+	return err;
 }
 
 struct tpm2_key_context {
-- 
2.25.1


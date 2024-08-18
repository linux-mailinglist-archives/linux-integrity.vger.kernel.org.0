Return-Path: <linux-integrity+bounces-3347-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F22DE955DB6
	for <lists+linux-integrity@lfdr.de>; Sun, 18 Aug 2024 19:02:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7DE51F22143
	for <lists+linux-integrity@lfdr.de>; Sun, 18 Aug 2024 17:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FE412FB34;
	Sun, 18 Aug 2024 17:01:42 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC40D208CA;
	Sun, 18 Aug 2024 17:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724000502; cv=none; b=rlRj0b9P8i2fgO2UEW/yZYpDn4ws9wsnulFlT9cduy2qDnlt/FmIbftgtfpOdFy6W/AggEQ2HO0Oj7E0Sbn6uxgzwCk+LPDQ+EEphQqHAYBZPQgMpaKCF04C7frzvxgxAASYSvKvJTMYEIP5xGu2+h0kSrj6ZtQX1QGUvDAKs9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724000502; c=relaxed/simple;
	bh=3EovKK7RDUc6RLroEVErm+ftl/7A8yA3Uw7D68DjqsY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NvekdmL5On3tojkGF8brNoozO5gDay3T1kEr4ryFlgikbpAv0DNst/U49JzXpzxae1sc1FhvXV1k9ndc8TYIkWXa7nlxmLQH4r+8mNjZlmCcTznqRokrgF3YppAgzfVsbIK/32wyK8x5KioMos51iMCugcRB9qsgm6I+i23ArDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4Wn1jr3GQWz9v7NJ;
	Mon, 19 Aug 2024 00:42:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 56AEE140380;
	Mon, 19 Aug 2024 01:01:33 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwCHCoXmKMJmFj1xAQ--.19682S2;
	Sun, 18 Aug 2024 18:01:32 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: dhowells@redhat.com,
	dwmw2@infradead.org,
	herbert@gondor.apana.org.au,
	davem@davemloft.net
Cc: linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	zohar@linux.ibm.com,
	linux-integrity@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v2 10/14] KEYS: Calculate key digest and get signature of the key
Date: Sun, 18 Aug 2024 18:57:52 +0200
Message-Id: <20240818165756.629203-11-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240818165756.629203-1-roberto.sassu@huaweicloud.com>
References: <20240818165756.629203-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwCHCoXmKMJmFj1xAQ--.19682S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXrW7Zw1DGr1UWry7CFW7urg_yoWrZr1DpF
	WrK34ftrW5Grn2kFZ8Jw4xu3yF9348Cw1fK34Skw1a93sYqr1UCay09F1jgFn8GFykAryF
	yFWqyFWavr1DZrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvvb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x
	0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02
	F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4I
	kC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7Cj
	xVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2
	IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
	6r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2
	IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73Uj
	IFyTuYvjxUOBMKDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgATBGbBWPgB8QABsj

From: Roberto Sassu <roberto.sassu@huawei.com>

Calculate the digest of the signature, according to the RFC4880 section
5.2.4, get the last suitable signature with types 0x10 (Generic
certification of a User ID and Public-Key packet) or 0x13 (Positive
certification of a User ID and Public Key packet), and store it in the
asym_auth field of the key payload, so that it is available for validating
a restriction on a keyring.

Type 0x10 is included despite not giving the strongest trust guarantees,
since it is the one used by most common PGP implementations (including
gpg).

The rationale of taking the last signature is that, if there are multiple
signatures, that would be of a different issuer (not a self-signature),
that likely has more chances to be useful for the restriction verification.
If there is one (the self-signature), that will be used.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 crypto/asymmetric_keys/pgp_public_key.c | 81 +++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/crypto/asymmetric_keys/pgp_public_key.c b/crypto/asymmetric_keys/pgp_public_key.c
index e7f74d513a9e..91678cbdc196 100644
--- a/crypto/asymmetric_keys/pgp_public_key.c
+++ b/crypto/asymmetric_keys/pgp_public_key.c
@@ -14,6 +14,7 @@
 #include <keys/asymmetric-parser.h>
 #include <crypto/hash.h>
 #include <crypto/public_key.h>
+#include <crypto/pgp.h>
 
 #include "pgp_parser.h"
 
@@ -61,6 +62,8 @@ struct pgp_key_data_parse_context {
 	size_t raw_fingerprint_len;
 	const char *user_id;
 	size_t user_id_len;
+	const char *key_pkt;
+	size_t key_pkt_len;
 };
 
 /*
@@ -226,6 +229,12 @@ static int pgp_process_public_key(struct pgp_parse_context *context,
 		return -EBADMSG;
 	}
 
+	/* Pointer refers to data being processed. */
+	if (type == PGP_PKT_PUBLIC_KEY) {
+		ctx->key_pkt = data;
+		ctx->key_pkt_len = datalen;
+	}
+
 	pub = kzalloc(sizeof(*pub), GFP_KERNEL);
 	if (!pub)
 		return -ENOMEM;
@@ -316,6 +325,77 @@ pgp_key_generate_id(struct pgp_key_data_parse_context *ctx)
 	return NULL;
 }
 
+/*
+ * Calculate the digest of the signature according to the RFC4880, section
+ * 5.2.4 (packet type 0x13).
+ */
+static int pgp_key_add_sig_data(struct pgp_key_data_parse_context *ctx,
+				struct pgp_sig_verify *sig_ctx)
+{
+	loff_t offset = 0;
+	u8 *data;
+
+	if (!ctx->key_pkt_len || !ctx->user_id_len)
+		return 0;
+
+	/* 0x99 + key pkt len + key pkt + 0xb4 + user ID len + user ID */
+	data = kmalloc(1 + sizeof(u16) + ctx->key_pkt_len +
+		       1 + sizeof(u32) + ctx->user_id_len, GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data[offset++] = 0x99;
+	data[offset++] = ctx->key_pkt_len >> 8;
+	data[offset++] = ctx->key_pkt_len;
+
+	memcpy(data + offset, ctx->key_pkt, ctx->key_pkt_len);
+	offset += ctx->key_pkt_len;
+
+	if (pgp_sig_get_version(sig_ctx) == PGP_SIG_VERSION_4) {
+		data[offset++] = 0xb4;
+		data[offset++] = ctx->user_id_len >> 24;
+		data[offset++] = ctx->user_id_len >> 16;
+		data[offset++] = ctx->user_id_len >> 8;
+		data[offset++] = ctx->user_id_len;
+	}
+
+	memcpy(data + offset, ctx->user_id, ctx->user_id_len);
+	offset += ctx->user_id_len;
+
+	pgp_sig_add_data(sig_ctx, data, offset);
+	kfree(data);
+	return 0;
+}
+
+static struct public_key_signature *
+pgp_key_get_sig(struct key_preparsed_payload *prep,
+		struct pgp_key_data_parse_context *ctx)
+{
+	struct public_key_signature *sig = NULL;
+	struct pgp_sig_verify *sig_ctx;
+	bool keep_sig = false;
+	int ret;
+
+	sig_ctx = pgp_sig_parse(prep->data, prep->datalen);
+	if (IS_ERR(sig_ctx))
+		return NULL;
+
+	ret = pgp_key_add_sig_data(ctx, sig_ctx);
+	if (ret < 0)
+		goto out;
+
+	sig = pgp_sig_get_sig(sig_ctx, true);
+	if (IS_ERR(sig)) {
+		sig = NULL;
+		goto out;
+	}
+
+	keep_sig = true;
+out:
+	pgp_sig_verify_cancel(sig_ctx, keep_sig);
+	return sig;
+}
+
 /*
  * Attempt to parse the instantiation data blob for a key as a PGP packet
  * message holding a key.
@@ -380,6 +460,7 @@ static int pgp_key_parse(struct key_preparsed_payload *prep)
 	prep->payload.data[asym_subtype] = &public_key_subtype;
 	prep->payload.data[asym_key_ids] = pgp_key_generate_id(&ctx);
 	prep->payload.data[asym_crypto] = ctx.pub;
+	prep->payload.data[asym_auth] = pgp_key_get_sig(prep, &ctx);
 	prep->quotalen = 100;
 	return 0;
 
-- 
2.34.1



Return-Path: <linux-integrity+bounces-3530-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 302B397526F
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Sep 2024 14:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54D341C26141
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Sep 2024 12:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66ACC19E985;
	Wed, 11 Sep 2024 12:31:55 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDC6190675;
	Wed, 11 Sep 2024 12:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726057915; cv=none; b=X832yxv8x59BgC4mrL/FeS2V2j1BdiHoayZjggpjJVZLvJOgv/LiYKsaJwFx9t/c+shFWranNt/ojeZcxvtse2BZ6BbHJikmclFaKrZ1GYgHDKwo4hpEcc/hzixeAIQHKTKNcaQgmtXeW0ld8wn8XLjezExfBIZQl1pUNk17rwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726057915; c=relaxed/simple;
	bh=fKPBAd7EgzmecWQuOmZuawdzDkVqpzhqT1bVYZNDujw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=boxRD/qMzv+uqNUH4OwrsQ/0t/PlZsV8VQZ4vE5p1SEEAV9J2iG3Drq23anUWZk5FqQzi5rLww3IJnl4CEq8k5R7az70YcDZHNQxBM8JPTVgyoGJGdzKpzdXL4i3esskceiIsjqao/G/fgBS33DkrLW90NFJawLx/QCv+JAKFLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4X3fZv4jMnz9v7NF;
	Wed, 11 Sep 2024 20:12:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id A8426140B03;
	Wed, 11 Sep 2024 20:31:37 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwD3hy+ijeFmnHu1AA--.60036S2;
	Wed, 11 Sep 2024 13:31:37 +0100 (CET)
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
	torvalds@linux-foundation.org,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v3 10/14] KEYS: Calculate key digest and get signature of the key
Date: Wed, 11 Sep 2024 14:29:07 +0200
Message-Id: <20240911122911.1381864-11-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911122911.1381864-1-roberto.sassu@huaweicloud.com>
References: <20240911122911.1381864-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwD3hy+ijeFmnHu1AA--.60036S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXrW7Zw1DGr1UWry7CFW7urg_yoWrZr43pF
	WrKryftrW5Krn2ka98Jw4xu3yF9348Cw1fK34Skw1a93sYqr1UCay09F1jgF98GFykAryr
	AFWqyFWa9r1DZrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQADBGbg-HQH4wAAss

From: Roberto Sassu <roberto.sassu@huawei.com>

Calculate the digest of the signature, according to the RFC 9580 section
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
index 22f4a40c7eb7..2dc8b5d321e9 100644
--- a/crypto/asymmetric_keys/pgp_public_key.c
+++ b/crypto/asymmetric_keys/pgp_public_key.c
@@ -14,6 +14,7 @@
 #include <keys/asymmetric-parser.h>
 #include <crypto/hash.h>
 #include <crypto/public_key.h>
+#include <crypto/pgp.h>
 
 #include "pgp_parser.h"
 
@@ -56,6 +57,8 @@ struct pgp_key_data_parse_context {
 	size_t raw_fingerprint_len;
 	const char *user_id;
 	size_t user_id_len;
+	const char *key_pkt;
+	size_t key_pkt_len;
 };
 
 /*
@@ -216,6 +219,12 @@ static int pgp_process_public_key(struct pgp_parse_context *context,
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
@@ -306,6 +315,77 @@ pgp_key_generate_id(struct pgp_key_data_parse_context *ctx)
 	return NULL;
 }
 
+/*
+ * Calculate the digest of the signature according to the RFC 9580, section
+ * 5.2.4 (packet types 0x10 and 0x13).
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
@@ -370,6 +450,7 @@ static int pgp_key_parse(struct key_preparsed_payload *prep)
 	prep->payload.data[asym_subtype] = &public_key_subtype;
 	prep->payload.data[asym_key_ids] = pgp_key_generate_id(&ctx);
 	prep->payload.data[asym_crypto] = ctx.pub;
+	prep->payload.data[asym_auth] = pgp_key_get_sig(prep, &ctx);
 	prep->quotalen = 100;
 	return 0;
 
-- 
2.34.1



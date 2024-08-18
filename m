Return-Path: <linux-integrity+bounces-3344-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F899955DAA
	for <lists+linux-integrity@lfdr.de>; Sun, 18 Aug 2024 19:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AD6D1F21DFE
	for <lists+linux-integrity@lfdr.de>; Sun, 18 Aug 2024 17:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AAE14F9FB;
	Sun, 18 Aug 2024 17:00:21 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5C414F9F9;
	Sun, 18 Aug 2024 17:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724000421; cv=none; b=MDzILWMPoCptwaQGj8taKMt0ozU/+6kroddqLGKzWEM+7C7VH3OQOatn2X11s7VZRwxbHd12Gz7JzpoIis3+WPWM9R6uzVTqTzk+4MIOIAeHNaj5BtMEDUmWNZ37k8YBdva+QLZS3SoemG4BppJkys3h7yQmMduf0uwGrGoJebM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724000421; c=relaxed/simple;
	bh=Nj+yAp93mMTonsRpkK/C+G3J8ISXkzla6f95gorlhUY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nruuxqg/FE0jaB26R3qaTPYHLETARahwGKjyVhQOohh6I5BNe9JClLr5F0FOPIzqVDdHvvKpvaydTJfT1EOxsQjkOYCE6/5Cazi2n6P15hOE4FCze3V4PLt8qwXlF2NDBcS4Ax+/+tOmDq4ZQiSA9zZyvrekYFAbSE0sDSXspRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wn1hF1L1fz9v7Hm;
	Mon, 19 Aug 2024 00:41:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 56DE9140380;
	Mon, 19 Aug 2024 01:00:12 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAXm4VpKMJm+zZxAQ--.21009S9;
	Sun, 18 Aug 2024 18:00:11 +0100 (CET)
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
Subject: [PATCH v2 07/14] KEYS: Provide PGP key description autogeneration
Date: Sun, 18 Aug 2024 18:57:49 +0200
Message-Id: <20240818165756.629203-8-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:LxC2BwAXm4VpKMJm+zZxAQ--.21009S9
X-Coremail-Antispam: 1UD129KBjvJXoWxGFWfCF4fKF4rKFy7Cr1DGFg_yoW5Zry3pa
	15G3y5KFWrGr1fta9xGr4xG3sYyFWxJFWfK3ySvw1a9wsIqr109rWSyF1Yg3WayFn5Jryf
	KFWqva4Yyr1DArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4
	kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
	5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtV
	W8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY
	1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x
	07UZTmfUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgATBGbBWPgB6wABs5

From: David Howells <dhowells@redhat.com>

Provide a facility to autogenerate the name of PGP keys from the contents
of the payload.  If add_key() is given a blank description, a description
is constructed from the last user ID packet in the payload data plus the
last 8 hex digits of the key ID.  For instance:

	keyctl padd asymmetric "" @s </tmp/key.pub

might create a key with a constructed description that can be seen in
/proc/keys:

2f674b96 I--Q---     1 perm 39390000     0     0 crypto    \
			Sample kernel key 31f0ae93: PGP.RSA 31f0ae93 []

Signed-off-by: David Howells <dhowells@redhat.com>
Co-developed-by: Roberto Sassu <roberto.sassu@huawei.com>
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 crypto/asymmetric_keys/pgp_public_key.c | 47 ++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/crypto/asymmetric_keys/pgp_public_key.c b/crypto/asymmetric_keys/pgp_public_key.c
index cb399f5cdd3e..e7f74d513a9e 100644
--- a/crypto/asymmetric_keys/pgp_public_key.c
+++ b/crypto/asymmetric_keys/pgp_public_key.c
@@ -59,6 +59,8 @@ struct pgp_key_data_parse_context {
 	struct public_key *pub;
 	u8 raw_fingerprint[HASH_MAX_DIGESTSIZE];
 	size_t raw_fingerprint_len;
+	const char *user_id;
+	size_t user_id_len;
 };
 
 /*
@@ -210,6 +212,15 @@ static int pgp_process_public_key(struct pgp_parse_context *context,
 
 	kenter(",%u,%u,,%zu", type, headerlen, datalen);
 
+	if (type == PGP_PKT_USER_ID) {
+		if (!ctx->user_id_len) {
+			ctx->user_id = data;
+			ctx->user_id_len = datalen;
+		}
+		kleave(" = 0 [user ID]");
+		return 0;
+	}
+
 	if (ctx->raw_fingerprint_len) {
 		kleave(" = -ENOKEY [already]");
 		return -EBADMSG;
@@ -317,7 +328,8 @@ static int pgp_key_parse(struct key_preparsed_payload *prep)
 	kenter("");
 
 	memset(&ctx, 0, sizeof(ctx));
-	ctx.pgp.types_of_interest = (1 << PGP_PKT_PUBLIC_KEY);
+	ctx.pgp.types_of_interest = (1 << PGP_PKT_PUBLIC_KEY) |
+				    (1 << PGP_PKT_USER_ID);
 	ctx.pgp.process_packet = pgp_process_public_key;
 
 	ret = pgp_parse_packets(prep->data, prep->datalen, &ctx.pgp);
@@ -330,6 +342,39 @@ static int pgp_key_parse(struct key_preparsed_payload *prep)
 		goto error;
 	}
 
+	if (ctx.user_id && ctx.user_id_len > 0) {
+		/*
+		 * Propose a description for the key (user ID without the
+		 * comment).
+		 */
+		size_t ulen = ctx.user_id_len;
+		const char *p;
+
+		p = memchr(ctx.user_id, '(', ulen);
+		if (p) {
+			/* Remove the comment */
+			do {
+				p--;
+			} while (*p == ' ' && p > ctx.user_id);
+			if (*p != ' ')
+				p++;
+			ulen = p - ctx.user_id;
+		}
+
+		if (ulen > 255 - 9)
+			ulen = 255 - 9;
+		prep->description = kmalloc(ulen + 1 + 8 + 1, GFP_KERNEL);
+		ret = -ENOMEM;
+		if (!prep->description)
+			goto error;
+		memcpy(prep->description, ctx.user_id, ulen);
+		prep->description[ulen] = ' ';
+		bin2hex(prep->description + ulen + 1,
+			ctx.raw_fingerprint + ctx.raw_fingerprint_len - 4, 4);
+		prep->description[ulen + 9] = 0;
+		pr_debug("desc '%s'\n", prep->description);
+	}
+
 	/* We're pinning the module by being linked against it */
 	__module_get(public_key_subtype.owner);
 	prep->payload.data[asym_subtype] = &public_key_subtype;
-- 
2.34.1



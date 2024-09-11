Return-Path: <linux-integrity+bounces-3531-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0950D975274
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Sep 2024 14:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B6061C26193
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Sep 2024 12:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F65A19E995;
	Wed, 11 Sep 2024 12:31:55 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B802F188A14;
	Wed, 11 Sep 2024 12:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726057915; cv=none; b=RyY2XN4Aj4h0s/3+Pp/Dm0yZVatW5ctmlGvndSYOY+/K6SIJIfrDmdGtLwPwlufbVpBX/WZ2EGhyfJX/qrbXlGXZUUOf6U8AC+6yyzZs78artwujsz8AbWsxIr0ikCcwMLjo0CaSpQ1gQVihqF8uuzlhtAeLZrXlfow/EXrAQ9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726057915; c=relaxed/simple;
	bh=2KIlpazax1UQiWf3Y3CqCE/n7smW3FLZV6HkbuAAgcQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TE4HR7CBmO2i2I5KURn4LZxMwf59uY2juWr2dJvspKl1k9/ZzgWBibTGsx/OMQ/CqxgRTxS4d0gdXyswzy8742PAhsN+g5mZCDy6M1ihbM8gwrZT8jL+3Itm1ZxERL+N59T4wxT4xEmYRxWhagOCoEBwW27dtugrNozKCa2HIyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4X3fSH1TtHz9v7JT;
	Wed, 11 Sep 2024 20:06:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 762B8140B08;
	Wed, 11 Sep 2024 20:31:43 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwD3hy+ijeFmnHu1AA--.60036S3;
	Wed, 11 Sep 2024 13:31:43 +0100 (CET)
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
Subject: [PATCH v3 11/14] verification: introduce verify_pgp_signature()
Date: Wed, 11 Sep 2024 14:29:08 +0200
Message-Id: <20240911122911.1381864-12-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:LxC2BwD3hy+ijeFmnHu1AA--.60036S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJF1kGF4kCF15JFyUJF4fZrb_yoWrCrWDpF
	nYvF4FvFy3Arn7Aay3Ga13Z3WrGrn5Kw17X3sFk3ZxXF97X3ZFyw4rKF4YqrW5C34UZrWF
	9rZ2qFy3Cw1DJw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7
	AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
	ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x
	07jb9NsUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgADBGbg-PsH0QAAsS

From: Roberto Sassu <roberto.sassu@huawei.com>

Introduce verify_pgp_signature() to verify PGP signatures from detached
data. It can be used by kernel subsystems (e.g. IMA).

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 certs/system_keyring.c       | 71 ++++++++++++++++++++++++++++++++++++
 include/linux/verification.h | 23 ++++++++++++
 2 files changed, 94 insertions(+)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 9de610bf1f4b..f132773c6096 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -16,6 +16,7 @@
 #include <keys/asymmetric-type.h>
 #include <keys/system_keyring.h>
 #include <crypto/pkcs7.h>
+#include <crypto/pgp.h>
 
 static struct key *builtin_trusted_keys;
 #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
@@ -418,6 +419,76 @@ int verify_pkcs7_signature(const void *data, size_t len,
 }
 EXPORT_SYMBOL_GPL(verify_pkcs7_signature);
 
+#ifdef CONFIG_PGP_KEY_PARSER
+/**
+ * verify_pgp_signature - Verify a PGP-based signature on system data.
+ * @data: The data to be verified (must be provided).
+ * @len: Size of @data.
+ * @raw_pgp: The PGP message that is the signature.
+ * @pgp_len: The size of @raw_pgp.
+ * @trusted_keys: Trusted keys to use (NULL for builtin trusted keys only,
+ *					(void *)1UL for all trusted keys,
+					(void *)2UL for platform keys).
+ * @usage: The use to which the key is being put.
+ * @view_content: Callback to gain access to content.
+ * @ctx: Context for callback.
+ */
+int verify_pgp_signature(const void *data, size_t len,
+			 const void *raw_pgp, size_t pgp_len,
+			 struct key *trusted_keys,
+			 enum key_being_used_for usage,
+			 int (*view_content)(void *ctx,
+					     const void *data, size_t len,
+					     size_t asn1hdrlen),
+			 void *ctx)
+{
+	struct pgp_sig_verify *pgp_ctx;
+	int ret;
+
+	if (!data || !len)
+		return -EINVAL;
+
+	pgp_ctx = pgp_sig_parse(raw_pgp, pgp_len);
+	if (IS_ERR(pgp_ctx))
+		return PTR_ERR(pgp_ctx);
+
+	if (!trusted_keys) {
+		trusted_keys = builtin_trusted_keys;
+	} else if (trusted_keys == VERIFY_USE_SECONDARY_KEYRING) {
+#ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
+		trusted_keys = secondary_trusted_keys;
+#else
+		trusted_keys = builtin_trusted_keys;
+#endif
+	} else if (trusted_keys == VERIFY_USE_PLATFORM_KEYRING) {
+#ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
+		trusted_keys = platform_trusted_keys;
+#else
+		trusted_keys = NULL;
+#endif
+		if (!trusted_keys) {
+			ret = -ENOKEY;
+			pr_devel("PGP platform keyring is not available\n");
+			goto error;
+		}
+	}
+
+	/* The data should be detached - so we need to supply it. */
+	if (pgp_sig_add_data(pgp_ctx, data, len)) {
+		pr_err("Failed to supply data for PGP signature\n");
+		ret = -EBADMSG;
+		goto error;
+	}
+
+	ret = pgp_sig_verify(pgp_ctx, trusted_keys);
+error:
+	pgp_sig_verify_cancel(pgp_ctx, false);
+	pr_devel("<==%s() = %d\n", __func__, ret);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(verify_pgp_signature);
+
+#endif /* CONFIG_PGP_KEY_PARSER */
 #endif /* CONFIG_SYSTEM_DATA_VERIFICATION */
 
 #ifdef CONFIG_INTEGRITY_PLATFORM_KEYRING
diff --git a/include/linux/verification.h b/include/linux/verification.h
index cb2d47f28091..e1a3b9424b67 100644
--- a/include/linux/verification.h
+++ b/include/linux/verification.h
@@ -63,6 +63,29 @@ extern int verify_pkcs7_message_sig(const void *data, size_t len,
 							size_t asn1hdrlen),
 				    void *ctx);
 
+#ifdef CONFIG_PGP_KEY_PARSER
+extern int verify_pgp_signature(const void *data, size_t len,
+				const void *raw_pgp, size_t pgp_len,
+				struct key *trusted_keys,
+				enum key_being_used_for usage,
+				int (*view_content)(void *ctx,
+						const void *data, size_t len,
+						size_t asn1hdrlen),
+				void *ctx);
+#else
+static inline int verify_pgp_signature(const void *data, size_t len,
+				const void *raw_pgp, size_t pgp_len,
+				struct key *trusted_keys,
+				enum key_being_used_for usage,
+				int (*view_content)(void *ctx,
+						const void *data, size_t len,
+						size_t asn1hdrlen),
+				void *ctx)
+{
+	return -EOPNOTSUPP;
+}
+#endif /* CONFIG_PGP_KEY_PARSER */
+
 #ifdef CONFIG_SIGNED_PE_FILE_VERIFICATION
 extern int verify_pefile_signature(const void *pebuf, unsigned pelen,
 				   struct key *trusted_keys,
-- 
2.34.1



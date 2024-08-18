Return-Path: <linux-integrity+bounces-3348-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 732AA955DBA
	for <lists+linux-integrity@lfdr.de>; Sun, 18 Aug 2024 19:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 993091C21704
	for <lists+linux-integrity@lfdr.de>; Sun, 18 Aug 2024 17:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4401814E2ED;
	Sun, 18 Aug 2024 17:01:48 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5861B14C59A;
	Sun, 18 Aug 2024 17:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724000508; cv=none; b=ksP7e4hs496i2QZ5mSJTywCjc8sHyXqgbmSJ7nvCRpWebRUeyU6QjhWyzKxptvC0c/d2/94ztbckPvCVu+Go8N+RdsEHw0WPLOTiKzd0179CKXQg+Hrixgddw7S6ZIlZXXNZuw9frl47UKn06JuVKr0N08ozWop3uVUHvh5/hsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724000508; c=relaxed/simple;
	bh=eLi4aH52NYYpKtfeIIO2DtM7AULReorcbN+ORw9Nums=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fJqeWGi0w4dma6zeKSjr9nJhwMyq0hUlXZXz5Tc0Ku+cm2SvB3Aj4tic6JvODh9gruvKGWkELtte6hmVKVoJlI0zXsVshlqyZyPKm8a6y3GclbaiaJZ74kA7zn6jhRCjKsig4zvf1agu5t2SRfReC8q+/+vOOLJS6LGGKU+7c3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4Wn1bY5MGTz9v7JW;
	Mon, 19 Aug 2024 00:37:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id D079214035F;
	Mon, 19 Aug 2024 01:01:38 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwCHCoXmKMJmFj1xAQ--.19682S3;
	Sun, 18 Aug 2024 18:01:38 +0100 (CET)
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
Subject: [PATCH v2 11/14] verification: introduce verify_pgp_signature()
Date: Sun, 18 Aug 2024 18:57:53 +0200
Message-Id: <20240818165756.629203-12-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:LxC2BwCHCoXmKMJmFj1xAQ--.19682S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJF1kZw15XF1fXw1DWF1xZrb_yoWrCr1rpF
	nYvF4FvFy3Arn7Aay3Ga13Z3WrGrn5Kw17X3sFk3ZxJFn7X3ZFy395KF4YqrW5C34UXrWF
	9rZ2qFy3Gw1DJw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
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
	07UCsjUUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgATBGbBWPgB8QACsg

From: Roberto Sassu <roberto.sassu@huawei.com>

Introduce verify_pgp_signature() to verify PGP signatures from detached
data. It will be used by fsverity and by IMA.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 certs/system_keyring.c       | 70 ++++++++++++++++++++++++++++++++++++
 include/linux/verification.h | 23 ++++++++++++
 2 files changed, 93 insertions(+)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 9de610bf1f4b..db0fde36a71b 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -16,6 +16,7 @@
 #include <keys/asymmetric-type.h>
 #include <keys/system_keyring.h>
 #include <crypto/pkcs7.h>
+#include <crypto/pgp.h>
 
 static struct key *builtin_trusted_keys;
 #ifdef CONFIG_SECONDARY_TRUSTED_KEYRING
@@ -418,6 +419,75 @@ int verify_pkcs7_signature(const void *data, size_t len,
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
+ *					(void *)1UL for all trusted keys).
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



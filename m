Return-Path: <linux-integrity+bounces-3350-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FAE955DC2
	for <lists+linux-integrity@lfdr.de>; Sun, 18 Aug 2024 19:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42C991F22E0D
	for <lists+linux-integrity@lfdr.de>; Sun, 18 Aug 2024 17:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B4A154423;
	Sun, 18 Aug 2024 17:02:02 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00516153838;
	Sun, 18 Aug 2024 17:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724000522; cv=none; b=BIWYqNow2qs6dQDgxeDMr+5RXsrdD22eAXIn6v2Wzdw3oydLFMLjNt2Mi6o3fBOZ20Di0oUa4xhui5TBrjQV4eNuFbxuuHveLnEHUbJ1YrvmHz5mjHXlVDKgmbMZPO9iD9rtxpKP8cyroknh/dDB839XCGZX3nDU/ve+xYEAXgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724000522; c=relaxed/simple;
	bh=KIMne1S5wtdevGFHyIWyJ76O7uv7LBcXzQ57F3KySMk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oEA+HGgLpyu28MtGn+cX76lIxiZ+YKWajXvX7qf0zeEbuQVJDj3AO3krFu1GZXfOMHAo65MgUBr5GMbafYqMsYxiVitc4/MERP7UDYDwHOk82pDQi7xIRD7PBQqlW41Jmi3GrUgUDNOlIEksCgljbYMW69mfMCjFbdHAfySbvao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4Wn1kC23y8z9v7NF;
	Mon, 19 Aug 2024 00:42:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id C6DA4140443;
	Mon, 19 Aug 2024 01:01:49 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwCHCoXmKMJmFj1xAQ--.19682S5;
	Sun, 18 Aug 2024 18:01:49 +0100 (CET)
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
Subject: [PATCH v2 13/14] KEYS: Provide a function to load keys from a PGP keyring blob
Date: Sun, 18 Aug 2024 18:57:55 +0200
Message-Id: <20240818165756.629203-14-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:LxC2BwCHCoXmKMJmFj1xAQ--.19682S5
X-Coremail-Antispam: 1UD129KBjvJXoW3Jw15KF18WF1rCr1xCF1Dtrb_yoWxXFyfpF
	W0kryrtFWkGr9Ik3yrAw1Ig3sYyr1vyFW5GrySyw15Ar9rXa18KrZ29r4DKa47Ars7t34r
	trWqg34YyF1DtrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
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
	07UHnmiUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQATBGbBWHECBQAAsf

From: David Howells <dhowells@redhat.com>

Provide a function to load keys from a PGP keyring blob to the built-in
keyring:

	int preload_pgp_keys(const u8 *pgpdata, size_t pgpdatalen,
			     struct key *keyring);

Descriptions are generated from user ID notes and key fingerprints.  The
keys will actually be identified by the ID calculated from the PGP data
rather than by the description, so this shouldn't be a problem.

The keys are attached to the keyring supplied.

Looking as root in /proc/keys after the built-in keyring has been loaded:

383a00c1 I------     1 perm 1f030000     0     0 asymmetri \
				Red Hat, Inc. dbeca166: PGP.DSA dbeca166 []

Thanks to Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> for some
pointing out some errors.

Signed-off-by: David Howells <dhowells@redhat.com>
Co-developed-by: Roberto Sassu <roberto.sassu@huawei.com>
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 crypto/asymmetric_keys/Kconfig       |   8 ++
 crypto/asymmetric_keys/Makefile      |   1 +
 crypto/asymmetric_keys/pgp_preload.c | 111 +++++++++++++++++++++++++++
 include/crypto/pgp.h                 |   8 +-
 4 files changed, 127 insertions(+), 1 deletion(-)
 create mode 100644 crypto/asymmetric_keys/pgp_preload.c

diff --git a/crypto/asymmetric_keys/Kconfig b/crypto/asymmetric_keys/Kconfig
index d9c709e042f6..6379efded6f4 100644
--- a/crypto/asymmetric_keys/Kconfig
+++ b/crypto/asymmetric_keys/Kconfig
@@ -133,4 +133,12 @@ config PGP_TEST_KEY
 
 	  This is intended for testing the PGP parser.
 
+config PGP_PRELOAD
+	bool "PGP public key preloading facility"
+	depends on SYSTEM_TRUSTED_KEYRING
+	select PGP_KEY_PARSER
+	help
+	  This option provides a facility for the kernel to preload PGP-wrapped
+	  bundles of keys during boot to the built-in keyring.
+
 endif # ASYMMETRIC_KEY_TYPE
diff --git a/crypto/asymmetric_keys/Makefile b/crypto/asymmetric_keys/Makefile
index 507a78f9a0a1..2fa55a7830e6 100644
--- a/crypto/asymmetric_keys/Makefile
+++ b/crypto/asymmetric_keys/Makefile
@@ -84,6 +84,7 @@ $(obj)/mscode.asn1.o: $(obj)/mscode.asn1.c $(obj)/mscode.asn1.h
 # PGP handling
 #
 obj-$(CONFIG_PGP_LIBRARY) += pgp_library.o
+obj-$(CONFIG_PGP_PRELOAD) += pgp_preload.o
 
 obj-$(CONFIG_PGP_KEY_PARSER) += pgp_key_parser.o
 pgp_key_parser-y := \
diff --git a/crypto/asymmetric_keys/pgp_preload.c b/crypto/asymmetric_keys/pgp_preload.c
new file mode 100644
index 000000000000..e0776dc8f928
--- /dev/null
+++ b/crypto/asymmetric_keys/pgp_preload.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Asymmetric key request handling
+ *
+ * Copyright (C) 2011 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <linux/module.h>
+#include <linux/key.h>
+#include <linux/err.h>
+#include <crypto/pgp.h>
+#include <keys/asymmetric-type.h>
+
+#include "pgp_parser.h"
+
+struct preload_pgp_keys_context {
+	struct pgp_parse_context pgp;
+	key_ref_t keyring;
+	const u8 *key_start;
+	const u8 *key_end;
+	bool found_key;
+};
+
+/*
+ * Create a key.
+ */
+static void __init create_pgp_key(struct preload_pgp_keys_context *ctx)
+{
+	key_ref_t key;
+
+	key = key_create_or_update(ctx->keyring,
+				   "asymmetric",
+				   NULL,
+				   ctx->key_start,
+				   ctx->key_end - ctx->key_start,
+				   ((KEY_POS_ALL & ~KEY_POS_SETATTR) |
+				    KEY_USR_VIEW | KEY_USR_READ),
+				   KEY_ALLOC_NOT_IN_QUOTA |
+				   KEY_ALLOC_BUILT_IN |
+				   KEY_ALLOC_BYPASS_RESTRICTION);
+	if (IS_ERR(key)) {
+		pr_notice("Ignoring PGP key, error: %ld\n", PTR_ERR(key));
+		return;
+	}
+
+	pr_notice("Loaded PGP key '%s'\n",
+		  key_ref_to_ptr(key)->description);
+
+	key_ref_put(key);
+}
+
+/*
+ * Extract a public key or subkey from the PGP stream.
+ */
+static int __init found_pgp_key(struct pgp_parse_context *context,
+				enum pgp_packet_tag type, u8 headerlen,
+				const u8 *data, size_t datalen)
+{
+	struct preload_pgp_keys_context *ctx =
+		container_of(context, struct preload_pgp_keys_context, pgp);
+
+	if (ctx->found_key) {
+		ctx->key_end = data - headerlen;
+		create_pgp_key(ctx);
+	}
+
+	ctx->key_start = data - headerlen;
+	ctx->found_key = true;
+	return 0;
+}
+
+/**
+ * preload_pgp_keys - Load keys from a PGP keyring blob
+ * @pgpdata: The PGP keyring blob containing the keys.
+ * @pgpdatalen: The size of the @pgpdata blob.
+ * @keyring: The keyring to add the new keys to.
+ *
+ * Preload a pack of keys from a PGP keyring blob.
+ *
+ * The keys have their descriptions generated from the user ID and fingerprint
+ * in the PGP stream.  Since keys can be matched on their key IDs independently
+ * of the key description, the description is mostly irrelevant apart from the
+ * fact that keys of the same description displace one another from a keyring.
+ *
+ * The caller should override the current creds if they want the keys to be
+ * owned by someone other than the current process's owner.  Keys will not be
+ * accounted towards the owner's quota.
+ *
+ * This function may only be called whilst the kernel is booting.
+ */
+int __init preload_pgp_keys(const u8 *pgpdata, size_t pgpdatalen,
+			    struct key *keyring)
+{
+	struct preload_pgp_keys_context ctx;
+	int ret;
+
+	ctx.pgp.types_of_interest = (1 << PGP_PKT_PUBLIC_KEY);
+	ctx.pgp.process_packet = found_pgp_key;
+	ctx.keyring = make_key_ref(keyring, 1);
+	ctx.found_key = false;
+
+	ret = pgp_parse_packets(pgpdata, pgpdatalen, &ctx.pgp);
+	if (ret < 0)
+		return ret;
+
+	if (ctx.found_key) {
+		ctx.key_end = pgpdata + pgpdatalen;
+		create_pgp_key(&ctx);
+	}
+	return 0;
+}
diff --git a/include/crypto/pgp.h b/include/crypto/pgp.h
index 99dd1ab6c1b1..263b44603636 100644
--- a/include/crypto/pgp.h
+++ b/include/crypto/pgp.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
-/* PGP signature processing
+/* PGP key and signature processing
  *
  * Copyright (C) 2014 Red Hat, Inc. All Rights Reserved.
  * Written by David Howells (dhowells@redhat.com)
@@ -27,4 +27,10 @@ extern struct public_key_signature *pgp_sig_get_sig(struct pgp_sig_verify *ctx,
 						    bool is_key_sig);
 extern u8 pgp_sig_get_version(struct pgp_sig_verify *ctx);
 
+/*
+ * pgp_preload.c
+ */
+extern int __init preload_pgp_keys(const u8 *pgpdata, size_t pgpdatalen,
+				   struct key *keyring);
+
 #endif /* _CRYPTO_PGP_H */
-- 
2.34.1



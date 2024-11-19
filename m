Return-Path: <linux-integrity+bounces-4154-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6B59D2471
	for <lists+linux-integrity@lfdr.de>; Tue, 19 Nov 2024 12:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27B411F23AED
	for <lists+linux-integrity@lfdr.de>; Tue, 19 Nov 2024 11:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0B91C4A0A;
	Tue, 19 Nov 2024 11:02:38 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E48E1C729B;
	Tue, 19 Nov 2024 11:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732014158; cv=none; b=ASvaZxV+HQphJvTiUFM/TjVLAKnYKbDc13wavq+3G7bLZXUBKlgwnVf9JfYDGKx46+r3CBQrP/Dd0v7mIcBaOJ9xg1l8j8LwKgJl8gHY6VjN+7PSZcLljL1qYFnG+TyUlK7da+4cNs16oGSwe7Vi2yE2viMdDFgTMZn4um3tOYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732014158; c=relaxed/simple;
	bh=nUfb61F6Guo4odfuRsaEiXvEuy8IJGedd9HvWwj618E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NrHiG7jW1D5LyeZ7EwayhyThLPZ3BwT6Vt5YpOauFP1JoVT74PH8hR0giqbiFbCNvM5fzi5amgeKUJlnbSCE5wKvWx2yufbr8ADqIhxAMDYpM7bXMLAxSOtzR3PPrV8vOlGA6tHIDhL5su3h3HEL5wD/0Xwouuse/ecrsKqz0+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Xt1JN04GWz9v7J4;
	Tue, 19 Nov 2024 18:41:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id CC8FA140119;
	Tue, 19 Nov 2024 19:02:33 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwB3NTb9bzxnNXHnAQ--.10850S7;
	Tue, 19 Nov 2024 12:02:33 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: corbet@lwn.net,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	wufan@linux.microsoft.com,
	pbrobinson@gmail.com,
	zbyszek@in.waw.pl,
	hch@lst.de,
	mjg59@srcf.ucam.org,
	pmatilai@redhat.com,
	jannh@google.com,
	dhowells@redhat.com,
	jikos@kernel.org,
	mkoutny@suse.com,
	ppavlu@suse.com,
	petr.vorel@gmail.com,
	mzerqung@0pointer.de,
	kgold@linux.ibm.com,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH v4 5/9] ima: Retrieve digest cache and check if changed
Date: Tue, 19 Nov 2024 12:00:59 +0100
Message-ID: <20241119110103.2780453-6-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.47.0.118.gfd3785337b
In-Reply-To: <20241119110103.2780453-1-roberto.sassu@huaweicloud.com>
References: <20241119110103.2780453-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwB3NTb9bzxnNXHnAQ--.10850S7
X-Coremail-Antispam: 1UD129KBjvJXoWxKF18WFyDCrWrGr18uw4rXwb_yoW3Zr4Upa
	929a4Utr48ZFW7CwsrAF12kF4rK3yFgFWxWws8XwnYyFZxXr1qvw18AryUuryrGrWUAa1x
	ta1Ygw15A3WUtaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6r
	W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26F4UJVW0owCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_GcJvcSsGvfC2KfnxnUUI43ZEXa7I
	U04rW7UUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAMBGc797QElgABsF

From: Roberto Sassu <roberto.sassu@huawei.com>

Add a digest cache pointer to the ima_iint_cache structure and introduce
ima_digest_cache_get_check() to retrieve a fresh digest cache and compare
with the pointer stored in the previous calls (if digest cache was enabled
in the IMA policy).

If the pointers don't match, reset the integrity status since the digest
cache used for the previous verification might have changed.

Also, initialize and put the digest cache respectively in
ima_iint_init_always() and ima_iint_free().

Call ima_digest_cache_get_check() with the iint->mutex held, to protect the
assignment of the digest cache pointer in the inode integrity metadata.
Change mutex_lock() to mutex_lock_nested() to avoid a lockdep warning due
to a possible deadlock (recursive iint->mutex lock, during a kernel read).

Nesting is safe for files opened by the Integrity Digest Cache, because
the latter guarantees that it will never cause IMA to be invoked with the
same inode. Call digest_cache_opened_fd() to know when nesting is safe, and
pass the boolean to mutex_lock_nested().

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/Makefile           |  1 +
 security/integrity/ima/ima.h              |  1 +
 security/integrity/ima/ima_digest_cache.c | 49 +++++++++++++++++++++++
 security/integrity/ima/ima_digest_cache.h | 22 ++++++++++
 security/integrity/ima/ima_iint.c         |  4 ++
 security/integrity/ima/ima_main.c         | 13 +++++-
 6 files changed, 88 insertions(+), 2 deletions(-)
 create mode 100644 security/integrity/ima/ima_digest_cache.c
 create mode 100644 security/integrity/ima/ima_digest_cache.h

diff --git a/security/integrity/ima/Makefile b/security/integrity/ima/Makefile
index b376d38b4ee6..b4a284634a07 100644
--- a/security/integrity/ima/Makefile
+++ b/security/integrity/ima/Makefile
@@ -14,6 +14,7 @@ ima-$(CONFIG_HAVE_IMA_KEXEC) += ima_kexec.o
 ima-$(CONFIG_IMA_BLACKLIST_KEYRING) += ima_mok.o
 ima-$(CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS) += ima_asymmetric_keys.o
 ima-$(CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS) += ima_queue_keys.o
+ima-$(CONFIG_INTEGRITY_DIGEST_CACHE) += ima_digest_cache.o
 
 ifeq ($(CONFIG_EFI),y)
 ima-$(CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT) += ima_efi.o
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 64667f16a30f..f3e6dcd9defd 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -198,6 +198,7 @@ struct ima_iint_cache {
 	enum integrity_status ima_read_status:4;
 	enum integrity_status ima_creds_status:4;
 	struct ima_digest_data *ima_hash;
+	struct digest_cache *digest_cache;
 };
 
 extern struct lsm_blob_sizes ima_blob_sizes;
diff --git a/security/integrity/ima/ima_digest_cache.c b/security/integrity/ima/ima_digest_cache.c
new file mode 100644
index 000000000000..ad47772a05bd
--- /dev/null
+++ b/security/integrity/ima/ima_digest_cache.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Integrate with the Integrity Digest Cache.
+ */
+
+#include <linux/digest_cache.h>
+
+#include "ima_digest_cache.h"
+
+/**
+ * ima_digest_cache_get_check - Get digest cache and check if changed
+ * @file: File descriptor of the inode for which the digest cache will be used
+ * @iint: Inode integrity metadata
+ *
+ * Get a digest cache for the file descriptor parameter and compare with the
+ * digest cache stored in the inode integrity metadata.
+ *
+ * It must be called with the iint->mutex held.
+ *
+ * Return: True if the digest cache pointer changed, false otherwise.
+ */
+bool ima_digest_cache_get_check(struct file *file,
+				struct ima_iint_cache *iint)
+{
+	struct digest_cache *digest_cache;
+
+	digest_cache = digest_cache_get(file);
+
+	/* There was no digest cache before, not changed. */
+	if (!iint->digest_cache) {
+		iint->digest_cache = digest_cache;
+		return false;
+	}
+
+	/* New digest cache not available, or digest cache changed. */
+	if (!digest_cache || iint->digest_cache != digest_cache) {
+		digest_cache_put(iint->digest_cache);
+		iint->digest_cache = digest_cache;
+		return true;
+	}
+
+	/* Digest cache not changed. */
+	digest_cache_put(digest_cache);
+	return false;
+}
diff --git a/security/integrity/ima/ima_digest_cache.h b/security/integrity/ima/ima_digest_cache.h
new file mode 100644
index 000000000000..8126ae1e2f4f
--- /dev/null
+++ b/security/integrity/ima/ima_digest_cache.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2024 Huawei Technologies Duesseldorf GmbH
+ *
+ * Author: Roberto Sassu <roberto.sassu@huawei.com>
+ *
+ * Header file of ima_digest_cache.c.
+ */
+
+#include "ima.h"
+
+#ifdef CONFIG_INTEGRITY_DIGEST_CACHE
+bool ima_digest_cache_get_check(struct file *file,
+				struct ima_iint_cache *iint);
+#else
+static inline bool ima_digest_cache_get_check(struct file *file,
+					      struct ima_iint_cache *iint)
+{
+	return false;
+}
+
+#endif /* CONFIG_INTEGRITY_DIGEST_CACHE */
diff --git a/security/integrity/ima/ima_iint.c b/security/integrity/ima/ima_iint.c
index 00b249101f98..7ed7e857d738 100644
--- a/security/integrity/ima/ima_iint.c
+++ b/security/integrity/ima/ima_iint.c
@@ -68,12 +68,16 @@ static void ima_iint_init_always(struct ima_iint_cache *iint,
 	iint->ima_read_status = INTEGRITY_UNKNOWN;
 	iint->ima_creds_status = INTEGRITY_UNKNOWN;
 	iint->measured_pcrs = 0;
+	iint->digest_cache = NULL;
 	mutex_init(&iint->mutex);
 	ima_iint_lockdep_annotate(iint, inode);
 }
 
 static void ima_iint_free(struct ima_iint_cache *iint)
 {
+	if (iint->digest_cache)
+		digest_cache_put(iint->digest_cache);
+
 	kfree(iint->ima_hash);
 	mutex_destroy(&iint->mutex);
 	kmem_cache_free(ima_iint_cache, iint);
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index bcbf64bb03c2..aaff8cd8d5c6 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -29,6 +29,7 @@
 #include <linux/evm.h>
 
 #include "ima.h"
+#include "ima_digest_cache.h"
 
 #ifdef CONFIG_IMA_APPRAISE
 int ima_appraise = IMA_APPRAISE_ENFORCE;
@@ -224,6 +225,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	bool violation_check;
 	enum hash_algo hash_algo;
 	unsigned int allowed_algos = 0;
+	u64 policy_usage = 0ULL;
 
 	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
 		return 0;
@@ -234,7 +236,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	 */
 	action = ima_get_action(file_mnt_idmap(file), inode, cred, secid,
 				mask, func, &pcr, &template_desc, NULL,
-				&allowed_algos, NULL);
+				&allowed_algos, &policy_usage);
 	violation_check = ((func == FILE_CHECK || func == MMAP_CHECK ||
 			    func == MMAP_CHECK_REQPROT) &&
 			   (ima_policy_flag & IMA_MEASURE));
@@ -266,7 +268,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	if (!action)
 		goto out;
 
-	mutex_lock(&iint->mutex);
+	mutex_lock_nested(&iint->mutex, digest_cache_opened_fd(file));
 
 	if (test_and_clear_bit(IMA_CHANGE_ATTR, &iint->atomic_flags))
 		/* reset appraisal flags if ima_inode_post_setattr was called */
@@ -287,6 +289,13 @@ static int process_measurement(struct file *file, const struct cred *cred,
 		iint->measured_pcrs = 0;
 	}
 
+	/* Digest cache changed, reset integrity status. */
+	if (policy_usage &&
+	    ima_digest_cache_get_check(file, iint)) {
+		iint->flags &= ~IMA_DONE_MASK;
+		iint->measured_pcrs = 0;
+	}
+
 	/*
 	 * On stacked filesystems, detect and re-evaluate file data and
 	 * metadata changes.
-- 
2.47.0.118.gfd3785337b



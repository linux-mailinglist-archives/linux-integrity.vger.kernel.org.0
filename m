Return-Path: <linux-integrity+bounces-3465-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACEC96DE1E
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Sep 2024 17:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B03251C252B0
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Sep 2024 15:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F5419E7D1;
	Thu,  5 Sep 2024 15:27:01 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744A4629E4;
	Thu,  5 Sep 2024 15:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725550021; cv=none; b=TeayPT9lOZNK6YPR11x6o/iQHjGsAeFTiovDKU/JaXphuhMniB7/hyz7R4o+nmL5aQCH8L1Ve/BIitcq0U8gbzXoriBYFJRdbtP1Gtivc6UKESqb9dGzOJ0RdNtEY3g9glnuX1c9/CmXnWkxMSYYvwXwzo/bHsgZuGWdcyK48UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725550021; c=relaxed/simple;
	bh=+B3ADT8CGPGCFjMJ3Pxi7RGj7bkBPn6UOljJq8JL32A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c8pXfwBO4Fp7TJprjgd6jugmhJwxxhKvWw2HyPdPUYIeRXSYHDbLVbVG/+jNXwRo4752YsKKljiSe/x//C3qdHUMIdoqJMu9RhUfweP78KsYasrP94HR9YL6x/wD1POMnyIpceQswhHPYQgtlCO5rVW1aK/wAuBIrOFQsP1TKCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4X02lr72gFz9v7NN;
	Thu,  5 Sep 2024 23:07:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 29B3C140857;
	Thu,  5 Sep 2024 23:26:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDXGjJrzdlmK4RUAA--.19788S8;
	Thu, 05 Sep 2024 16:26:55 +0100 (CET)
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
Subject: [RFC][PATCH v3 06/10] ima: Retrieve digest cache and check if changed
Date: Thu,  5 Sep 2024 17:25:08 +0200
Message-Id: <20240905152512.3781098-7-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905152512.3781098-1-roberto.sassu@huaweicloud.com>
References: <20240905152512.3781098-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwDXGjJrzdlmK4RUAA--.19788S8
X-Coremail-Antispam: 1UD129KBjvJXoWxKF18tFyxCryfur47uFW5Awb_yoWxZw1rpa
	9F93WUKr48ZFW7Cws3AF12kF4rK3yFgFWxG398WwnYyFsxXr1qvw18A34UuryrGrWjya1x
	tan0gr15C3WUtaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x02
	67AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4
	kS14v26rWY6Fy7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
	5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZV
	WrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY
	1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
	AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26rxl6s0DYxBIdaVFxhVjvjDU0xZFpf9x
	07jhXo7UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQARBGbZE3MLYAAAsg

From: Roberto Sassu <roberto.sassu@huawei.com>

Add a digest cache pointer to the ima_iint_cache structure and introduce
ima_digest_cache_get_check() to retrieve a fresh digest cache and compare
with the pointer stored in the previous calls (if digest cache was enabled
in the IMA policy).

If the pointers don't match, reset the integrity status since the digest
cache used for the previous verification might have changed.

Also, initialize and put the digest cache respectively in
ima_iint_init_always() and ima_iint_free().

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/Makefile           |  1 +
 security/integrity/ima/ima.h              |  1 +
 security/integrity/ima/ima_digest_cache.c | 49 +++++++++++++++++++++++
 security/integrity/ima/ima_digest_cache.h | 22 ++++++++++
 security/integrity/ima/ima_iint.c         |  4 ++
 security/integrity/ima/ima_main.c         | 10 ++++-
 6 files changed, 86 insertions(+), 1 deletion(-)
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
index 736fe014afbc..b2ef37a11b65 100644
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
index 000000000000..bf720684b7b1
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
+ * @dentry: Dentry of the inode for which the digest cache will be used
+ * @iint: Inode integrity metadata
+ *
+ * Get a digest cache for the dentry parameter and compare with the digest
+ * cache stored in the inode integrity metadata.
+ *
+ * It must be called with the iint->mutex held.
+ *
+ * Return: True if the digest cache pointer changed, false otherwise.
+ */
+bool ima_digest_cache_get_check(struct dentry *dentry,
+				struct ima_iint_cache *iint)
+{
+	struct digest_cache *digest_cache;
+
+	digest_cache = digest_cache_get(dentry);
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
index 000000000000..75b6ac8732d3
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
+bool ima_digest_cache_get_check(struct dentry *dentry,
+				struct ima_iint_cache *iint);
+#else
+static inline bool ima_digest_cache_get_check(struct dentry *dentry,
+					      struct ima_iint_cache *iint)
+{
+	return false;
+}
+
+#endif /* CONFIG_INTEGRITY_DIGEST_CACHE */
diff --git a/security/integrity/ima/ima_iint.c b/security/integrity/ima/ima_iint.c
index e23412a2c56b..d6946cd4fa91 100644
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
index ebf233664194..ae106f1fe144 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -224,6 +224,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	bool violation_check;
 	enum hash_algo hash_algo;
 	unsigned int allowed_algos = 0;
+	u64 policy_usage = 0ULL;
 
 	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
 		return 0;
@@ -234,7 +235,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	 */
 	action = ima_get_action(file_mnt_idmap(file), inode, cred, secid,
 				mask, func, &pcr, &template_desc, NULL,
-				&allowed_algos, NULL);
+				&allowed_algos, &policy_usage);
 	violation_check = ((func == FILE_CHECK || func == MMAP_CHECK ||
 			    func == MMAP_CHECK_REQPROT) &&
 			   (ima_policy_flag & IMA_MEASURE));
@@ -287,6 +288,13 @@ static int process_measurement(struct file *file, const struct cred *cred,
 		iint->measured_pcrs = 0;
 	}
 
+	/* Digest cache changed, reset integrity status. */
+	if (policy_usage &&
+	    ima_digest_cache_get_check(file_dentry(file), iint)) {
+		iint->flags &= ~IMA_DONE_MASK;
+		iint->measured_pcrs = 0;
+	}
+
 	/*
 	 * On stacked filesystems, detect and re-evaluate file data and
 	 * metadata changes.
-- 
2.34.1



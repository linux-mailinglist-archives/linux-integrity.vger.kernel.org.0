Return-Path: <linux-integrity+bounces-3466-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7748C96DE23
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Sep 2024 17:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 022D31F272B1
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Sep 2024 15:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5837A17ADFF;
	Thu,  5 Sep 2024 15:27:21 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C83B9443;
	Thu,  5 Sep 2024 15:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725550041; cv=none; b=HN0kj95z/bPfj86Yhtmx3Wyz1RueV7CMjyO1ExKpA7nZuwk6OU+RKilxCMcIo+R6Vgf1YGWv1d8osMnJSv+5vOkfycLAVs1kZcZV+mkfq7rWXKEGTyS+WHu5mOq4jB37qLUqlT54nTZQ3XLAtMhjGhpa/mWnX7JuvpSacaIXVVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725550041; c=relaxed/simple;
	bh=mAqE+tXl6PN5Oi+qS9SZwO3Wihqw6k9uakeo/K9yYBI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qKwTS2uvjweZSp8mD/pj057euLNeldDJFTRK/RtPZivOvrGUysNiUkYstMd7WV3Ju4gqrUEzUFHl+RpLVLw0b2WBzA0SpQN1obg/PmzqOCSPsRK82iKfQdbjVe21yopZBGa/SlmyY1DGoTy39TpUsTqFKnVLHmf0GlXY/fcNW5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4X02dg4J7kz9v7JT;
	Thu,  5 Sep 2024 23:02:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id B44601408F9;
	Thu,  5 Sep 2024 23:27:07 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDXGjJrzdlmK4RUAA--.19788S9;
	Thu, 05 Sep 2024 16:27:07 +0100 (CET)
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
Subject: [RFC][PATCH v3 07/10] ima: Store verified usage in digest cache based on integrity metadata flags
Date: Thu,  5 Sep 2024 17:25:09 +0200
Message-Id: <20240905152512.3781098-8-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:LxC2BwDXGjJrzdlmK4RUAA--.19788S9
X-Coremail-Antispam: 1UD129KBjvJXoW3Aw1rZr4UCr1Utw1fur1xZrb_yoW7Wr43pa
	9FgFnrtrn5Zry7Crs3AF17CayFkrZYqa1UXw45Zwn0yFs8Zw1qy393CryUuFy5JFWvq3Wx
	tr42gw13Cw1UtaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgARBGbZE-oLJAAAsu

From: Roberto Sassu <roberto.sassu@huawei.com>

The Integrity Digest Cache allows integrity providers to record how the
digest list being used to populate the digest cache was verified.

Integrity providers can register a kernel_post_read_file LSM hook
implementation, and call digest_cache_verif_set() providing the result of
the digest list verification, together with the digest list file
descriptor.

IMA implements ima_digest_cache_store_verified_usage(), storing verified
usage of the digest cache based on whether or not the digest list the
digest cache is being populated from was measured/appraised.

If the digest list was measured (IMA_MEASURED set in iint->flags),
ima_digest_cache_store_verified_usage() sets the
IMA_DIGEST_CACHE_MEASURE_DATA in the verified usage. If the digest list was
appraised (IMA_APPRAISED_SUBMASK), ima_digest_cache_store_verified_usage()
sets the IMA_DIGEST_CACHE_APPRAISE_DATA in the verified usage.

Verified usage based on integrity metadata will be ANDed with the policy
usage from the IMA policy. Then, the final decision will ultimately depend
on whether or not the calculated digest of the accessed file was found in
the digest cache.

ANDing the verified usage with the policy usage prevents remote verifiers
from receiving an incomplete IMA measurement list, where measurements are
skipped, but there isn't the digest list the calculated file digest was
searched into. It also prevents successful appraisal without appraising the
digest list itself.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima_digest_cache.c | 35 +++++++++++++++++++++++
 security/integrity/ima/ima_digest_cache.h |  7 +++++
 security/integrity/ima/ima_main.c         |  3 ++
 3 files changed, 45 insertions(+)

diff --git a/security/integrity/ima/ima_digest_cache.c b/security/integrity/ima/ima_digest_cache.c
index bf720684b7b1..baa3faae77d2 100644
--- a/security/integrity/ima/ima_digest_cache.c
+++ b/security/integrity/ima/ima_digest_cache.c
@@ -47,3 +47,38 @@ bool ima_digest_cache_get_check(struct dentry *dentry,
 	digest_cache_put(digest_cache);
 	return false;
 }
+
+/**
+ * ima_digest_cache_store_verified_usage - Store verified usage in digest cache
+ * @file: Digest list file descriptor
+ * @iint: Inode integrity metadata
+ *
+ * Set digest cache verified usage in the digest cache associated to the
+ * digest list file descriptor. Verified usage is based on whether or not the
+ * digest list was measured/appraised, and is ANDed with the policy usage to
+ * make the final decision on whether a digest cache can be used for a specific
+ * IMA action.
+ */
+void ima_digest_cache_store_verified_usage(struct file *file,
+					   struct ima_iint_cache *iint)
+{
+	u64 verified_usage = 0;
+	int rc;
+
+	if (iint->flags & IMA_MEASURED)
+		verified_usage |= IMA_DIGEST_CACHE_MEASURE_DATA;
+	if (iint->flags & IMA_APPRAISED_SUBMASK)
+		verified_usage |= IMA_DIGEST_CACHE_APPRAISE_DATA;
+
+	/*
+	 * Set digest cache verified usage from integrity metadata flags for
+	 * later use.
+	 */
+	rc = digest_cache_verif_set(file, "ima", &verified_usage,
+				    sizeof(verified_usage));
+
+	/* Ignore if fd doesn't have digest cache set (prefetching). */
+	if (rc && rc != -ENOENT)
+		pr_debug("Cannot set verified usage for %s, ret: %d, ignoring\n",
+			 file_dentry(file)->d_name.name, rc);
+}
diff --git a/security/integrity/ima/ima_digest_cache.h b/security/integrity/ima/ima_digest_cache.h
index 75b6ac8732d3..1544dc798631 100644
--- a/security/integrity/ima/ima_digest_cache.h
+++ b/security/integrity/ima/ima_digest_cache.h
@@ -12,6 +12,8 @@
 #ifdef CONFIG_INTEGRITY_DIGEST_CACHE
 bool ima_digest_cache_get_check(struct dentry *dentry,
 				struct ima_iint_cache *iint);
+void ima_digest_cache_store_verified_usage(struct file *file,
+					   struct ima_iint_cache *iint);
 #else
 static inline bool ima_digest_cache_get_check(struct dentry *dentry,
 					      struct ima_iint_cache *iint)
@@ -19,4 +21,9 @@ static inline bool ima_digest_cache_get_check(struct dentry *dentry,
 	return false;
 }
 
+static inline void
+ima_digest_cache_store_verified_usage(struct file *file,
+				      struct ima_iint_cache *iint)
+{ }
+
 #endif /* CONFIG_INTEGRITY_DIGEST_CACHE */
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index ae106f1fe144..97ece2abb0b9 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -29,6 +29,7 @@
 #include <linux/evm.h>
 
 #include "ima.h"
+#include "ima_digest_cache.h"
 
 #ifdef CONFIG_IMA_APPRAISE
 int ima_appraise = IMA_APPRAISE_ENFORCE;
@@ -420,6 +421,8 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	if ((mask & MAY_WRITE) && test_bit(IMA_DIGSIG, &iint->atomic_flags) &&
 	     !(iint->flags & IMA_NEW_FILE))
 		rc = -EACCES;
+	if (!rc && func == DIGEST_LIST_CHECK)
+		ima_digest_cache_store_verified_usage(file, iint);
 	mutex_unlock(&iint->mutex);
 	kfree(xattr_value);
 	ima_free_modsig(modsig);
-- 
2.34.1



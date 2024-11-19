Return-Path: <linux-integrity+bounces-4155-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C73DA9D2475
	for <lists+linux-integrity@lfdr.de>; Tue, 19 Nov 2024 12:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E69751F23CCD
	for <lists+linux-integrity@lfdr.de>; Tue, 19 Nov 2024 11:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92ACB1C07D5;
	Tue, 19 Nov 2024 11:02:50 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D9714AD1A;
	Tue, 19 Nov 2024 11:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732014170; cv=none; b=BW/B1kWShayMmIQY9Ovw9rm6TltIux3Awx7CDfUs/yqTFjSaFpgXrU295mD+HeWXuWBrQ8IgPCpAqHiVASuJk87mkaPtPw/ljl1v7oK5YVUPltX+7Z6IZ1egiz5gJsXRCCxi7uwRSjMLaiWF8Gjpk5B6kVZ9W6JpQlZYELgGSMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732014170; c=relaxed/simple;
	bh=SWd2JGKyvAQyvSXgEWdVTrxzhKZepkNBg4UGmSBeP20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oEhwOwOeNLIxnX0ox9bqJxsaOEDx8tvWPZP7+MwntVTWJEKGC34spPC0xmRCJTR9kSJlkqX7vGw7CtJPgBwjDRBprknKeK09BbLGBDOVyzQM22SMpjKWpwKW8xo0dwtPZSWNufhkRy2WD98b5ldJcefKUsiZH1EaanhPAvj4JTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Xt1Jb6fMtz9v7N1;
	Tue, 19 Nov 2024 18:41:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id BA93F1407F5;
	Tue, 19 Nov 2024 19:02:45 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwB3NTb9bzxnNXHnAQ--.10850S8;
	Tue, 19 Nov 2024 12:02:45 +0100 (CET)
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
Subject: [RFC][PATCH v4 6/9] ima: Store verified usage in digest cache based on integrity metadata flags
Date: Tue, 19 Nov 2024 12:01:00 +0100
Message-ID: <20241119110103.2780453-7-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:LxC2BwB3NTb9bzxnNXHnAQ--.10850S8
X-Coremail-Antispam: 1UD129KBjvJXoWxKrWUZFW8Zr47Kr1DZF47Jwb_yoW7Xr17pa
	9IgF9rtr1kZry7CrsxAF17uayFkrZ5ta1UXw45Zrn0ya15Zr1qy393Cr1UuFy5JFWvq3Wx
	tw42gw13Cw1DtaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAMBGc79-IEpgAAsx

From: Roberto Sassu <roberto.sassu@huawei.com>

The Integrity Digest Cache allows integrity providers to record how the
digest list being used to populate the digest cache was verified.

Integrity providers can register a kernel_post_read_file LSM hook
implementation, and call digest_cache_verif_set() providing the result of
the digest list verification, together with the digest list file
descriptor.

IMA implements ima_digest_cache_store_verified_usage(), storing the
verified usage of the digest cache based on whether or not the digest list
the digest cache is being populated from was measured/appraised.

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
from receiving an incomplete IMA measurement list, where measurements of
files are skipped, but there isn't the measurement of the digest lists the
calculated file digests were searched into. It also prevents successful
appraisal without appraising the digest list itself.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima_digest_cache.c | 35 +++++++++++++++++++++++
 security/integrity/ima/ima_digest_cache.h |  7 +++++
 security/integrity/ima/ima_main.c         |  2 ++
 3 files changed, 44 insertions(+)

diff --git a/security/integrity/ima/ima_digest_cache.c b/security/integrity/ima/ima_digest_cache.c
index ad47772a05bd..2c7824ce05cd 100644
--- a/security/integrity/ima/ima_digest_cache.c
+++ b/security/integrity/ima/ima_digest_cache.c
@@ -47,3 +47,38 @@ bool ima_digest_cache_get_check(struct file *file,
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
index 8126ae1e2f4f..167690930078 100644
--- a/security/integrity/ima/ima_digest_cache.h
+++ b/security/integrity/ima/ima_digest_cache.h
@@ -12,6 +12,8 @@
 #ifdef CONFIG_INTEGRITY_DIGEST_CACHE
 bool ima_digest_cache_get_check(struct file *file,
 				struct ima_iint_cache *iint);
+void ima_digest_cache_store_verified_usage(struct file *file,
+					   struct ima_iint_cache *iint);
 #else
 static inline bool ima_digest_cache_get_check(struct file *file,
 					      struct ima_iint_cache *iint)
@@ -19,4 +21,9 @@ static inline bool ima_digest_cache_get_check(struct file *file,
 	return false;
 }
 
+static inline void
+ima_digest_cache_store_verified_usage(struct file *file,
+				      struct ima_iint_cache *iint)
+{ }
+
 #endif /* CONFIG_INTEGRITY_DIGEST_CACHE */
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index aaff8cd8d5c6..607749d520b0 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -421,6 +421,8 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	if ((mask & MAY_WRITE) && test_bit(IMA_DIGSIG, &iint->atomic_flags) &&
 	     !(iint->flags & IMA_NEW_FILE))
 		rc = -EACCES;
+	if (!rc && func == DIGEST_LIST_CHECK)
+		ima_digest_cache_store_verified_usage(file, iint);
 	mutex_unlock(&iint->mutex);
 	kfree(xattr_value);
 	ima_free_modsig(modsig);
-- 
2.47.0.118.gfd3785337b



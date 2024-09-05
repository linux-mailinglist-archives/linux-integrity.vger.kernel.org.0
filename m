Return-Path: <linux-integrity+bounces-3467-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0324B96DE27
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Sep 2024 17:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4A53281540
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Sep 2024 15:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285AD19F49D;
	Thu,  5 Sep 2024 15:27:24 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D2519D06D;
	Thu,  5 Sep 2024 15:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725550044; cv=none; b=gSzh2orysSIKsJMuymB3lI7vtKQOB4u0Lyo7XgTlHqBd1woX1I4n0uwpDSkAK1NANRVGev5uq89yFSTXt/bYnRs2euVrGFeVMSG++Q6h5Lo/3QkJQvrW0SLqdBNEPoN8wgeASEkUPftoKicaopjKinm/klvpEP9CukKUoX7WxGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725550044; c=relaxed/simple;
	bh=jsjVLtDE0VF7vmWfovdTSRpqiD8fwEZ0aT1EkBUjlRc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uRUBeK74GvSlodUiWH1ZHFVRcLgl7qbsyKK0sjgfz+5KvVxxIWujG67WTVEtfUYWVNRjT+iRrrMvFe6FNBCuvkPBm619lDVO2f6kkajafN/T16UbX9t3CSqkaUBnt/+oC8vFw//GXbhgYwUxv5f7EIpqfEqnpPXyhDtC2IStWmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4X02mH3t2jz9v7NK;
	Thu,  5 Sep 2024 23:07:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 56C031401F1;
	Thu,  5 Sep 2024 23:27:19 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDXGjJrzdlmK4RUAA--.19788S10;
	Thu, 05 Sep 2024 16:27:18 +0100 (CET)
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
Subject: [RFC][PATCH v3 08/10] ima: Load verified usage from digest cache found from query
Date: Thu,  5 Sep 2024 17:25:10 +0200
Message-Id: <20240905152512.3781098-9-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:LxC2BwDXGjJrzdlmK4RUAA--.19788S10
X-Coremail-Antispam: 1UD129KBjvJXoWxWr15JFyxJryUKFW8KFWDXFb_yoW5tr4fpa
	9FgFnxtr4rZF17Cw13AFy2k3yFkrWvqay7G3y5ZwnIyanxZr1jywsYkw1UuryrXr4qg3Wx
	tr42gw13CwnrtaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
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
	AKxVWxJVW8Jr1lIxAIcVC2z280aVCY1x0267AKxVW0oVCq3bIYCTnIWIevJa73UjIFyTuY
	vjxUVdgAUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgARBGbZE-oLJQAAsv

From: Roberto Sassu <roberto.sassu@huawei.com>

Introduce ima_digest_cache_load_verified_usage() to retrieve the verified
usage from the digest cache returned from the lookup of the digest
calculated by IMA on a file being accessed.

Verified usage cannot be loaded from the digest cache returned by
digest_cache_get() since the latter might return a directory digest cache,
which does not contain any verification data (only set to digest cache
populated from a file).

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima_digest_cache.c | 37 +++++++++++++++++++++++
 security/integrity/ima/ima_digest_cache.h |  9 ++++++
 2 files changed, 46 insertions(+)

diff --git a/security/integrity/ima/ima_digest_cache.c b/security/integrity/ima/ima_digest_cache.c
index baa3faae77d2..bb8a9a9aa933 100644
--- a/security/integrity/ima/ima_digest_cache.c
+++ b/security/integrity/ima/ima_digest_cache.c
@@ -82,3 +82,40 @@ void ima_digest_cache_store_verified_usage(struct file *file,
 		pr_debug("Cannot set verified usage for %s, ret: %d, ignoring\n",
 			 file_dentry(file)->d_name.name, rc);
 }
+
+/**
+ * ima_digest_cache_load_verified_usage - Load verified usage from digest cache
+ * @dentry: Dentry of the inode for which the digest cache will be used
+ * @iint: Inode integrity metadata
+ *
+ * Load digest cache verified usage from the digest cache returned by
+ * digest_cache_lookup(), containing the file digest calculated by IMA (if the
+ * digest is found).
+ *
+ * Return: Verified usage if digest is found in digest cache, zero otherwise.
+ */
+u64 ima_digest_cache_load_verified_usage(struct dentry *dentry,
+					 struct ima_iint_cache *iint)
+{
+	void *verified_usage_ptr;
+	uintptr_t found_cache_ptr;
+	struct digest_cache *found_cache;
+
+	if (!iint->digest_cache)
+		return 0ULL;
+
+	/* Do lookup to identify digest cache verification data is read from. */
+	found_cache_ptr = digest_cache_lookup(dentry, iint->digest_cache,
+					      iint->ima_hash->digest,
+					      iint->ima_hash->algo);
+	if (!found_cache_ptr)
+		return 0ULL;
+
+	found_cache = (struct digest_cache *)found_cache_ptr;
+
+	verified_usage_ptr = digest_cache_verif_get(found_cache, "ima");
+	if (!verified_usage_ptr)
+		return 0ULL;
+
+	return *(u64 *)verified_usage_ptr;
+}
diff --git a/security/integrity/ima/ima_digest_cache.h b/security/integrity/ima/ima_digest_cache.h
index 1544dc798631..41a37630b1f7 100644
--- a/security/integrity/ima/ima_digest_cache.h
+++ b/security/integrity/ima/ima_digest_cache.h
@@ -14,6 +14,8 @@ bool ima_digest_cache_get_check(struct dentry *dentry,
 				struct ima_iint_cache *iint);
 void ima_digest_cache_store_verified_usage(struct file *file,
 					   struct ima_iint_cache *iint);
+u64 ima_digest_cache_load_verified_usage(struct dentry *dentry,
+					 struct ima_iint_cache *iint);
 #else
 static inline bool ima_digest_cache_get_check(struct dentry *dentry,
 					      struct ima_iint_cache *iint)
@@ -26,4 +28,11 @@ ima_digest_cache_store_verified_usage(struct file *file,
 				      struct ima_iint_cache *iint)
 { }
 
+static inline u64
+ima_digest_cache_load_verified_usage(struct dentry *dentry,
+				     struct ima_iint_cache *iint)
+{
+	return 0ULL;
+}
+
 #endif /* CONFIG_INTEGRITY_DIGEST_CACHE */
-- 
2.34.1



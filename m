Return-Path: <linux-integrity+bounces-4156-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 495869D247C
	for <lists+linux-integrity@lfdr.de>; Tue, 19 Nov 2024 12:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD580B24324
	for <lists+linux-integrity@lfdr.de>; Tue, 19 Nov 2024 11:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1323A1C9B9A;
	Tue, 19 Nov 2024 11:03:08 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28C41C68A3;
	Tue, 19 Nov 2024 11:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732014187; cv=none; b=d3oQ0Rug10XWfRp1FG4wysTs5n4QShdw9sftLNSUUBSryrNWBGWgCx8s1WELjCkyp+8WxHl/+5Jq2Swa+3rqLEhNDfV5G2viAZPBwm9mECEM4WIE+x25Y0aXO8dm6anfQN1n556tRpkXbT8Sq6IuJqAGKvZYrVbKGV9tNEJlTKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732014187; c=relaxed/simple;
	bh=ju/IAw6dPeGn+d1vHJhFySBDcHhb9QLqKEczPv4HD9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AVvL93HdwKBmL9Zs844yI5M6o9bg7GW/vYk5xF2MA+ZChz2XMtKKLj3Ypp7p6w+sSp+A12Wz64JunO62+90MXz3iIQY1Fs15KPfnIyo5qUO1xSEKn2izUsQr5hNIjle8VDXFNu7wI5R0MJ+tm3ODEnRFOHQd6aWEv35Sg4hc69c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4Xt1Jz5krRz9v7NH;
	Tue, 19 Nov 2024 18:42:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id AAE0D140E9A;
	Tue, 19 Nov 2024 19:02:57 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwB3NTb9bzxnNXHnAQ--.10850S9;
	Tue, 19 Nov 2024 12:02:57 +0100 (CET)
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
Subject: [RFC][PATCH v4 7/9] ima: Load verified usage from digest cache found from query
Date: Tue, 19 Nov 2024 12:01:01 +0100
Message-ID: <20241119110103.2780453-8-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:LxC2BwB3NTb9bzxnNXHnAQ--.10850S9
X-Coremail-Antispam: 1UD129KBjvJXoWxWr15KFyrJr13AFyrur4rXwb_yoWrWw4rpa
	9agFnrtr4rZry7Cw43AFy29rWrKrykta17J398ZwnIya15Zr1jyws5Cw1UuryfJr4jqa1x
	tw4jgw15Cw1qkaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAMBGc797QElwABsE

From: Roberto Sassu <roberto.sassu@huawei.com>

Introduce ima_digest_cache_load_verified_usage() to retrieve the verified
usage from the digest cache pointer returned by digest_cache_lookup().

Verified usage cannot be loaded from the digest cache returned by
digest_cache_get() since the latter might return a directory digest cache,
which does not contain any verification data (only set to digest caches
populated from a file).

If digest_cache_lookup() returns the ERR_PTR(-EAGAIN) error pointer,
replace the digest cache pointer in the inode integrity metadata, by
calling digest_cache_get() again, and perform the lookup.

ERR_PTR(-EAGAIN) is returned if the digest cache currently stored in the
inode integrity metadata changed between digest_cache_get() and
digest_cache_lookup(). In this case, getting a fresh digest cache is
necessary to see which changes have been made on the digest cache.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima_digest_cache.c | 42 +++++++++++++++++++++++
 security/integrity/ima/ima_digest_cache.h |  9 +++++
 2 files changed, 51 insertions(+)

diff --git a/security/integrity/ima/ima_digest_cache.c b/security/integrity/ima/ima_digest_cache.c
index 2c7824ce05cd..b6bd6f9d5442 100644
--- a/security/integrity/ima/ima_digest_cache.c
+++ b/security/integrity/ima/ima_digest_cache.c
@@ -82,3 +82,45 @@ void ima_digest_cache_store_verified_usage(struct file *file,
 		pr_debug("Cannot set verified usage for %s, ret: %d, ignoring\n",
 			 file_dentry(file)->d_name.name, rc);
 }
+
+/**
+ * ima_digest_cache_load_verified_usage - Load verified usage from digest cache
+ * @file: File descriptor of the inode for which the digest cache will be used
+ * @iint: Inode integrity metadata
+ *
+ * Load digest cache verified usage from the digest cache returned by
+ * digest_cache_lookup(), containing the file digest calculated by IMA (if the
+ * digest is found).
+ *
+ * Return: Verified usage if digest is found in digest cache, zero otherwise.
+ */
+u64 ima_digest_cache_load_verified_usage(struct file *file,
+					 struct ima_iint_cache *iint)
+{
+	u64 verified_usage = 0ULL;
+	void *verified_usage_ptr;
+	struct digest_cache *found_cache;
+again:
+	if (!iint->digest_cache)
+		return 0ULL;
+
+	/* Do lookup to get digest cache containing calculated file digest. */
+	found_cache = digest_cache_lookup(file_dentry(file), iint->digest_cache,
+					  iint->ima_hash->digest,
+					  iint->ima_hash->algo);
+	if (!found_cache) {
+		return 0ULL;
+	} else if (found_cache == ERR_PTR(-EAGAIN)) {
+		digest_cache_put(iint->digest_cache);
+		iint->digest_cache = digest_cache_get(file);
+		goto again;
+	}
+
+	/* Get verification data from digest cache with calculated digest. */
+	verified_usage_ptr = digest_cache_verif_get(found_cache, "ima");
+	if (verified_usage_ptr)
+		verified_usage = *(u64 *)verified_usage_ptr;
+
+	digest_cache_put(found_cache);
+	return verified_usage;
+}
diff --git a/security/integrity/ima/ima_digest_cache.h b/security/integrity/ima/ima_digest_cache.h
index 167690930078..23cb53ed02e5 100644
--- a/security/integrity/ima/ima_digest_cache.h
+++ b/security/integrity/ima/ima_digest_cache.h
@@ -14,6 +14,8 @@ bool ima_digest_cache_get_check(struct file *file,
 				struct ima_iint_cache *iint);
 void ima_digest_cache_store_verified_usage(struct file *file,
 					   struct ima_iint_cache *iint);
+u64 ima_digest_cache_load_verified_usage(struct file *file,
+					 struct ima_iint_cache *iint);
 #else
 static inline bool ima_digest_cache_get_check(struct file *file,
 					      struct ima_iint_cache *iint)
@@ -26,4 +28,11 @@ ima_digest_cache_store_verified_usage(struct file *file,
 				      struct ima_iint_cache *iint)
 { }
 
+static inline u64
+ima_digest_cache_load_verified_usage(struct file *file,
+				     struct ima_iint_cache *iint)
+{
+	return 0ULL;
+}
+
 #endif /* CONFIG_INTEGRITY_DIGEST_CACHE */
-- 
2.47.0.118.gfd3785337b



Return-Path: <linux-integrity+bounces-4158-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 477FA9D2487
	for <lists+linux-integrity@lfdr.de>; Tue, 19 Nov 2024 12:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1EEA1F242F2
	for <lists+linux-integrity@lfdr.de>; Tue, 19 Nov 2024 11:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1C01C6F55;
	Tue, 19 Nov 2024 11:03:36 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C16E1C9EB5;
	Tue, 19 Nov 2024 11:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732014216; cv=none; b=TVdeyWL2zs9WQ4wHks+5CzD5iJ7qFlqmsz4rIsL325glOnd7vy+KgJBtH7KVQecSsKsStBDjMuzy6/aXLx+n0MA8GtexNyzKyJCZbqslzcOegxGT1taaaimFI1I0Xl9bNRWbucf/t+gW95Z3QMazk9ZsH6fWDLHtCsyx8tJPPs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732014216; c=relaxed/simple;
	bh=pvLhc8RjAUhHE0Ypcfb/nA2SMc5FHFY1VQfKtwXor2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lY2bnqGBKl9QOVUH+Ct1JIgr7+fbMIitQT7ahVUkpm2PH9D9VIpcnU7GOlvMk0B1Y7cRVk91WJpe37XMbZ4EWn8a5XBXXss7VhQjx03kuq5LDwOZxcfxfU0P7OoF56C1paYNMpUikOMaVZq+ctlbSxwD+a6HPVp8bG4zumiqBHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4Xt1KX0C3nz9v7NH;
	Tue, 19 Nov 2024 18:42:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id A194014086A;
	Tue, 19 Nov 2024 19:03:21 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwB3NTb9bzxnNXHnAQ--.10850S11;
	Tue, 19 Nov 2024 12:03:20 +0100 (CET)
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
Subject: [RFC][PATCH v4 9/9] ima: Use digest caches for appraisal
Date: Tue, 19 Nov 2024 12:01:03 +0100
Message-ID: <20241119110103.2780453-10-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:LxC2BwB3NTb9bzxnNXHnAQ--.10850S11
X-Coremail-Antispam: 1UD129KBjvJXoW3XFWkZrW5Ar47Zr45tr1UJrb_yoW7WFW8pa
	9xKF1UKry8WFWI9rZxAa9rCa1Sk3y0gFWUWws8W3429FnxXr109ryrtw12vF15Wr1UJrs7
	twsFgr1UAa1rt3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAMBGc79-IEqgAAs9

From: Roberto Sassu <roberto.sassu@huawei.com>

Similarly to measurement, enable the new appraisal style too using digest
caches.

It allows files to be verified by only checking the signature of the
package they belong to (as opposed to checking individual file signatures),
and by doing a digest lookup in the digest cache.

The first benefit is that packages are already signed (e.g. RPM package
headers) and also contain file digests, so it is not necessary to further
add signatures for each file.

The second benefit is performance, which improves due to verifying less
signatures (computationally expensive).

Appraisal with a digest cache is successful only if the allowed usage
(AND of policy usage and verified usage) has the
IMA_DIGEST_CACHE_APPRAISE_DATA bit set, and if EVM is disabled or the file
does not have any protected xattr

The digest cache appraisal method is tried first, for performance reasons.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima.h          |  6 ++++--
 security/integrity/ima/ima_appraise.c | 31 +++++++++++++++++++++------
 security/integrity/ima/ima_main.c     |  4 +++-
 3 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 61b019e7bace..aec61984b12c 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -440,7 +440,8 @@ int ima_check_blacklist(struct ima_iint_cache *iint,
 int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 			     struct file *file, const unsigned char *filename,
 			     struct evm_ima_xattr_data *xattr_value,
-			     int xattr_len, const struct modsig *modsig);
+			     int xattr_len, const struct modsig *modsig,
+			     u64 allowed_usage);
 int ima_must_appraise(struct mnt_idmap *idmap, struct inode *inode,
 		      int mask, enum ima_hooks func);
 void ima_update_xattr(struct ima_iint_cache *iint, struct file *file);
@@ -465,7 +466,8 @@ static inline int ima_appraise_measurement(enum ima_hooks func,
 					   const unsigned char *filename,
 					   struct evm_ima_xattr_data *xattr_value,
 					   int xattr_len,
-					   const struct modsig *modsig)
+					   const struct modsig *modsig,
+					   u64 allowed_usage)
 {
 	return INTEGRITY_UNKNOWN;
 }
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index d479cf58d859..d4745d90ae23 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -480,7 +480,8 @@ int ima_check_blacklist(struct ima_iint_cache *iint,
 int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 			     struct file *file, const unsigned char *filename,
 			     struct evm_ima_xattr_data *xattr_value,
-			     int xattr_len, const struct modsig *modsig)
+			     int xattr_len, const struct modsig *modsig,
+			     u64 allowed_usage)
 {
 	static const char op[] = "appraise_data";
 	const char *cause = "unknown";
@@ -489,13 +490,20 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 	enum integrity_status status = INTEGRITY_UNKNOWN;
 	int rc = xattr_len;
 	bool try_modsig = iint->flags & IMA_MODSIG_ALLOWED && modsig;
+	bool cache_pass = (allowed_usage & IMA_DIGEST_CACHE_APPRAISE_DATA);
 
-	/* If not appraising a modsig, we need an xattr. */
-	if (!(inode->i_opflags & IOP_XATTR) && !try_modsig)
+	/*
+	 * If not appraising a modsig/there is no digest cache match, we need
+	 * an xattr.
+	 */
+	if (!(inode->i_opflags & IOP_XATTR) && !try_modsig && !cache_pass)
 		return INTEGRITY_UNKNOWN;
 
-	/* If reading the xattr failed and there's no modsig, error out. */
-	if (rc <= 0 && !try_modsig) {
+	/*
+	 * If reading the xattr failed and there's no modsig/digest cache match,
+	 * error out.
+	 */
+	if (rc <= 0 && !try_modsig && !cache_pass) {
 		if (rc && rc != -ENODATA)
 			goto out;
 
@@ -526,8 +534,11 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 	case INTEGRITY_UNKNOWN:
 		break;
 	case INTEGRITY_NOXATTRS:	/* No EVM protected xattrs. */
-		/* It's fine not to have xattrs when using a modsig. */
-		if (try_modsig)
+		/*
+		 * It's fine not to have xattrs when using a modsig or there
+		 * is a digest cache match.
+		 */
+		if (try_modsig || cache_pass)
 			break;
 		fallthrough;
 	case INTEGRITY_NOLABEL:		/* No security.evm xattr. */
@@ -544,6 +555,12 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 		WARN_ONCE(true, "Unexpected integrity status %d\n", status);
 	}
 
+	if (cache_pass) {
+		status = INTEGRITY_PASS;
+		rc = 0;
+		goto out;
+	}
+
 	if (xattr_value)
 		rc = xattr_verify(func, iint, xattr_value, xattr_len, &status,
 				  &cause);
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 0d37cdc01622..049e379fed7f 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -398,7 +398,9 @@ static int process_measurement(struct file *file, const struct cred *cred,
 			inode_lock(inode);
 			rc = ima_appraise_measurement(func, iint, file,
 						      pathname, xattr_value,
-						      xattr_len, modsig);
+						      xattr_len, modsig,
+						      (policy_usage &
+						       verified_usage));
 			inode_unlock(inode);
 		}
 		if (!rc)
-- 
2.47.0.118.gfd3785337b



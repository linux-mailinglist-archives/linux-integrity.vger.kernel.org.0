Return-Path: <linux-integrity+bounces-3469-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5DE96DE34
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Sep 2024 17:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3AFB1C25D63
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Sep 2024 15:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE0219CD07;
	Thu,  5 Sep 2024 15:28:53 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1D52B9A8;
	Thu,  5 Sep 2024 15:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725550133; cv=none; b=DVSTKwzGc2jh/P3DaZj0WVlW0gSiaPOcKjJpMVZ28cCwAuR02mpzOEpeZ4Mq+DkSUgOBa8MXRxn9OkxhQ5yliyOVTEoEVbPYPtHdUGuLCuCTFJR3bNa1a+UDiENoYAFjzhtHPywdg02sC4ucHFHNhmM++dEsJP+37IigdTlCBbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725550133; c=relaxed/simple;
	bh=uUuQL1v3UN0ZZ+C8tX9Tg+KiKIRSZLZMGkRyO//juw4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tKbg3ZVJ7T+JPa4GqAy1MTYD8FEWghKs3nlUnqOSNsC8IodzDUDzA56p+k5u43dVkj3EJb/5zeEs0uSRBEzRaBHbl5kTI/OzCJ9dnFJpg2z+h6oIS83A+tyaC6VEqCuPZxmU3q9qGy9M5ALxP09uy/hVpiBEFHum94hWTuRtuuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4X02gP6vcBz9v7Jg;
	Thu,  5 Sep 2024 23:03:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 373481404F6;
	Thu,  5 Sep 2024 23:28:47 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwBXBschztlmKVFVAA--.16538S2;
	Thu, 05 Sep 2024 16:28:46 +0100 (CET)
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
Subject: [RFC][PATCH v3 10/10] ima: Use digest caches for appraisal
Date: Thu,  5 Sep 2024 17:25:12 +0200
Message-Id: <20240905152512.3781098-11-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:GxC2BwBXBschztlmKVFVAA--.16538S2
X-Coremail-Antispam: 1UD129KBjvJXoW3XFWkZrW5Ar47Zr45tr1UJrb_yoW7WF4xpa
	9IgF1UKry8WFWI9FZxCa9rCa1Sk3y0gFWUWws8X3429FnxXr109ryrtw12vF15Wr1Utrs7
	twsFgr1UAa1rt3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7
	CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x02
	62kKe7AKxVWrXVW3AwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s
	026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_
	GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20x
	vEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280
	aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_GcCE3sUvcSsGvfC2KfnxnUUI43
	ZEXa7IU0uMKtUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgARBGbZE-oLMwAAs5

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
index c915339dd0d4..8f74783e6174 100644
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
index 3b34bfa5c891..aa2f117ae0ba 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -399,7 +399,9 @@ static int process_measurement(struct file *file, const struct cred *cred,
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
2.34.1



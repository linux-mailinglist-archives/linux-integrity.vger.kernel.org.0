Return-Path: <linux-integrity+bounces-8129-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00718CD439D
	for <lists+linux-integrity@lfdr.de>; Sun, 21 Dec 2025 19:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AAD573000931
	for <lists+linux-integrity@lfdr.de>; Sun, 21 Dec 2025 18:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802DF2264D5;
	Sun, 21 Dec 2025 18:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="e566HlGA"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB3F30216D
	for <linux-integrity@vger.kernel.org>; Sun, 21 Dec 2025 18:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766340101; cv=none; b=oW7TQhUDXelxnNJaf+KyTMnB4cTMfwZYsoqRNsjVtsVFavW5itsm/XyXxejg+6cNtt83kSFioDXiJpjtoedCJgAvpDudqcv+DCweX47j3ktpSHwZq0JEFOI7erKJX1UVjdpb1EWGYPpF1aNKs/4IkWZUNJC13WJx4guak0osaaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766340101; c=relaxed/simple;
	bh=p23rTPaXB4iLA7mrqVNTAV0jfWyH932i0ckS/IM7+KU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M5AGPyCw6G5Nn46WEQYBidmKKi7Pn5htcPv/Sh0UuxxNPN2xRelQz8TUxST/H5aaJIGQZ4WbQ2TLCOzVYvC2hcohts5Ny9fkN1mzEh+dMJsjgO5gyY5nER4PxOZPDaETcVapootn3zlLcf2p5askM0a64VVXVzjQcuYtohwzDxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=e566HlGA; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-450c6f5ff81so1980915b6e.0
        for <linux-integrity@vger.kernel.org>; Sun, 21 Dec 2025 10:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1766340098; x=1766944898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TMI4gJV+EmQW/dsAUXEtdv+529j/oGL1MY5pHnG4y5I=;
        b=e566HlGAqrYzNvk52bmuPebS4kNrgZyG6O2EqdISjvJ9oIMZ6xtpz6c4OzJ6hUbyIv
         6qSYD3QzJbaNzkexOAViVgu5iX/E7z/cu4YavvEOsRCfai7sx426gqRWuPDFo3gD1CrP
         pON2RzJJ3EvCWFlIvgaGMHgj9eCoS2O42VQToyHe429oCnteKNV9X7HZCJSwajhLDNnR
         jYlW302UW8uavwF8EpqAbNEiFuatl9pblgOdpSXPOOTHAjhN+niYa/5B1fdWCeL0O6iq
         FS+dlG4DwE8eWUm8fP+LGDDbz5dP1HD8Sv7HF4LXzSmDUPJQAQUwALDlKZFYg34terdW
         0qBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766340098; x=1766944898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TMI4gJV+EmQW/dsAUXEtdv+529j/oGL1MY5pHnG4y5I=;
        b=WyyELIlUyCE/xz05DyiVx4Heck5wPAzhJMELCF5fZW3jK4iDnuAKhbSGagJ9ElxxWg
         TK6ItYZEhXp1vAIh8/hj5+fLJqw5Hcn/vLnflxWDJWtsGwzRwuKBpVY6s4ldgO6yTho8
         37Zi7M0WwgMOdTnxUSzSaZVb0uPtd/zu6VvcZnhXGVHyihyKlX3xZclj9X2XzV/cRWlK
         BHvaG3lSbiW3wDGXNqFgRVr1ECQzGIESHLYRHYurOm6/A70KqLO2rih9h6u3pE/o1OGs
         WlrmwqDWITrYgncaJaj/C/vko4fYN68O2ZxDu7ciNn95jKOh0iXZei9dijXKviYgITIe
         iHew==
X-Forwarded-Encrypted: i=1; AJvYcCV2y+rLTxUNd0X/43a7VfXr6pa7oZ89AaHqA48jtBk0W/FxvpZCUKYk2RallMrTKr61pcNED5HFMg4fDVxOT+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+YMxu6So37UnNKMPKfvGZ7Wru9SGVrEweMDoq/i1hOAyh83zb
	E9teKadJVVRKhqqfhyr3YP+AfRQNe2Bh7mqcm7SDU3VZmJ/BIzJe8xYmekzWwYizass=
X-Gm-Gg: AY/fxX7Cf30DaU2vEO53cd52ABxzvHNMsvf0fClvHkJa8VIDVGggYjbIFUO1Ne7H6wq
	dk5pCiufomk0ymMz9Je6alETA42zQBYM3Zk7++9soufOCW937u117xmrIDLMYxSiaqwcLEqMbvT
	OWeroVhdxsPVBjnRTYdX9gXPHpj2sEIvZJXOiogYB6ekLZKSe4QRfF2Bj6tOO6NPvTgYGHfNKUV
	JO04lEINLodLykjRPXZ/5b1u9rEfm4nMU4h45NFqx2G0hcneBJDAH8oV/Majpc12ZC5wbo84SQd
	bn8JeARkJiU9BupQTBqD9eMcQ8H0rJxkjtbzkCJzyoavlZ0SVeLNmVbsECNzMn1w/zbMUubdvc9
	Vn27V7LmgRj3e7gNTJ033HwDcq3VCV/DHdqlU6dvLQUZ+AyKiqVXY+mcsvgiYsAdEFV89gNCI
X-Google-Smtp-Source: AGHT+IFtfgC7EtUhHlm9PN3fh8nc1zUg/yZTdIPC+ThEyW1/WWre3+6c5ZhabM4CkagZUusUsC8L3w==
X-Received: by 2002:a05:6808:1382:b0:450:f45e:f4ae with SMTP id 5614622812f47-457a28924ddmr5726915b6e.9.1766340097941;
        Sun, 21 Dec 2025 10:01:37 -0800 (PST)
Received: from 861G6M3.. ([2a09:bac1:76a0:258::281:ed])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3fdadbf8d97sm4868888fac.1.2025.12.21.10.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 10:01:36 -0800 (PST)
From: Chris J Arges <carges@cloudflare.com>
To: zohar@linux.ibm.com,
	roberto.sassu@huawei.com
Cc: kernel-team@cloudflare.com,
	Chris J Arges <carges@cloudflare.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Kees Cook <kees@kernel.org>,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] ima: Fix stack-out-of-bounds in is_bprm_creds_for_exec()
Date: Sun, 21 Dec 2025 12:01:23 -0600
Message-ID: <20251221180128.1026760-1-carges@cloudflare.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251219195456.912190-1-carges@cloudflare.com>
References: <20251219195456.912190-1-carges@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KASAN reported a stack-out-of-bounds access in ima_appraise_measurement
from is_bprm_creds_for_exec:

BUG: KASAN: stack-out-of-bounds in ima_appraise_measurement+0x12dc/0x16a0
 Read of size 1 at addr ffffc9000160f940 by task sudo/550
The buggy address belongs to stack of task sudo/550
and is located at offset 24 in frame:
  ima_appraise_measurement+0x0/0x16a0
This frame has 2 objects:
  [48, 56) 'file'
  [80, 148) 'hash'

This is caused by using container_of on the *file pointer. This offset
calculation is what triggers the stack-out-of-bounds error.

In order to fix this, pass in a bprm_is_check boolean which can be set
depending on how process_measurement is called. If the caller has a
linux_binprm pointer and the function is BPRM_CHECK we can determine
is_check and set it then. Otherwise set it to false.

Fixes: 95b3cdafd7cb7 ("ima: instantiate the bprm_creds_for_exec() hook")

Signed-off-by: Chris J Arges <carges@cloudflare.com>
---
 security/integrity/ima/ima.h          |  4 ++--
 security/integrity/ima/ima_appraise.c | 15 ++-------------
 security/integrity/ima/ima_main.c     | 18 +++++++++---------
 3 files changed, 13 insertions(+), 24 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index e3d71d8d56e3..2c9e50c02634 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -441,7 +441,7 @@ int ima_check_blacklist(struct ima_iint_cache *iint,
 int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 			     struct file *file, const unsigned char *filename,
 			     struct evm_ima_xattr_data *xattr_value,
-			     int xattr_len, const struct modsig *modsig);
+			     int xattr_len, const struct modsig *modsig, bool bprm_is_check);
 int ima_must_appraise(struct mnt_idmap *idmap, struct inode *inode,
 		      int mask, enum ima_hooks func);
 void ima_update_xattr(struct ima_iint_cache *iint, struct file *file);
@@ -466,7 +466,7 @@ static inline int ima_appraise_measurement(enum ima_hooks func,
 					   const unsigned char *filename,
 					   struct evm_ima_xattr_data *xattr_value,
 					   int xattr_len,
-					   const struct modsig *modsig)
+					   const struct modsig *modsig, bool bprm_is_check)
 {
 	return INTEGRITY_UNKNOWN;
 }
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 5149ff4fd50d..ea2079417318 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -470,17 +470,6 @@ int ima_check_blacklist(struct ima_iint_cache *iint,
 	return rc;
 }
 
-static bool is_bprm_creds_for_exec(enum ima_hooks func, struct file *file)
-{
-	struct linux_binprm *bprm;
-
-	if (func == BPRM_CHECK) {
-		bprm = container_of(&file, struct linux_binprm, file);
-		return bprm->is_check;
-	}
-	return false;
-}
-
 /*
  * ima_appraise_measurement - appraise file measurement
  *
@@ -492,7 +481,7 @@ static bool is_bprm_creds_for_exec(enum ima_hooks func, struct file *file)
 int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 			     struct file *file, const unsigned char *filename,
 			     struct evm_ima_xattr_data *xattr_value,
-			     int xattr_len, const struct modsig *modsig)
+			     int xattr_len, const struct modsig *modsig, bool bprm_is_check)
 {
 	static const char op[] = "appraise_data";
 	int audit_msgno = AUDIT_INTEGRITY_DATA;
@@ -514,7 +503,7 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 	 * of the script interpreter(userspace). Differentiate kernel and
 	 * userspace enforced integrity audit messages.
 	 */
-	if (is_bprm_creds_for_exec(func, file))
+	if (bprm_is_check)
 		audit_msgno = AUDIT_INTEGRITY_USERSPACE;
 
 	/* If reading the xattr failed and there's no modsig, error out. */
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 5770cf691912..36ce07063dc7 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -236,7 +236,7 @@ static void ima_file_free(struct file *file)
 static int process_measurement(struct file *file, const struct cred *cred,
 			       struct lsm_prop *prop, char *buf, loff_t size,
 			       int mask, enum ima_hooks func,
-			       enum kernel_read_file_id read_id)
+			       enum kernel_read_file_id read_id, bool bprm_is_check)
 {
 	struct inode *real_inode, *inode = file_inode(file);
 	struct ima_iint_cache *iint = NULL;
@@ -426,7 +426,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 			inode_lock(inode);
 			rc = ima_appraise_measurement(func, iint, file,
 						      pathname, xattr_value,
-						      xattr_len, modsig);
+						      xattr_len, modsig, bprm_is_check);
 			inode_unlock(inode);
 		}
 		if (!rc)
@@ -493,14 +493,14 @@ static int ima_file_mmap(struct file *file, unsigned long reqprot,
 
 	if (reqprot & PROT_EXEC) {
 		ret = process_measurement(file, current_cred(), &prop, NULL,
-					  0, MAY_EXEC, MMAP_CHECK_REQPROT, 0);
+					  0, MAY_EXEC, MMAP_CHECK_REQPROT, 0, false);
 		if (ret)
 			return ret;
 	}
 
 	if (prot & PROT_EXEC)
 		return process_measurement(file, current_cred(), &prop, NULL,
-					   0, MAY_EXEC, MMAP_CHECK, 0);
+					   0, MAY_EXEC, MMAP_CHECK, 0, false);
 
 	return 0;
 }
@@ -584,7 +584,7 @@ static int ima_bprm_check(struct linux_binprm *bprm)
 
 	security_current_getlsmprop_subj(&prop);
 	return process_measurement(bprm->file, current_cred(),
-				   &prop, NULL, 0, MAY_EXEC, BPRM_CHECK, 0);
+				   &prop, NULL, 0, MAY_EXEC, BPRM_CHECK, 0, bprm->is_check);
 }
 
 /**
@@ -614,7 +614,7 @@ static int ima_creds_check(struct linux_binprm *bprm, const struct file *file)
 
 	security_current_getlsmprop_subj(&prop);
 	return process_measurement((struct file *)file, bprm->cred, &prop, NULL,
-				   0, MAY_EXEC, CREDS_CHECK, 0);
+				   0, MAY_EXEC, CREDS_CHECK, 0, false);
 }
 
 /**
@@ -662,7 +662,7 @@ static int ima_file_check(struct file *file, int mask)
 	security_current_getlsmprop_subj(&prop);
 	return process_measurement(file, current_cred(), &prop, NULL, 0,
 				   mask & (MAY_READ | MAY_WRITE | MAY_EXEC |
-					   MAY_APPEND), FILE_CHECK, 0);
+					   MAY_APPEND), FILE_CHECK, 0, false);
 }
 
 static int __ima_inode_hash(struct inode *inode, struct file *file, char *buf,
@@ -881,7 +881,7 @@ static int ima_read_file(struct file *file, enum kernel_read_file_id read_id,
 	func = read_idmap[read_id] ?: FILE_CHECK;
 	security_current_getlsmprop_subj(&prop);
 	return process_measurement(file, current_cred(), &prop, NULL, 0,
-				   MAY_READ, func, 0);
+				   MAY_READ, func, 0, false);
 }
 
 const int read_idmap[READING_MAX_ID] = {
@@ -925,7 +925,7 @@ static int ima_post_read_file(struct file *file, char *buf, loff_t size,
 	func = read_idmap[read_id] ?: FILE_CHECK;
 	security_current_getlsmprop_subj(&prop);
 	return process_measurement(file, current_cred(), &prop, buf, size,
-				   MAY_READ, func, read_id);
+				   MAY_READ, func, read_id, false);
 }
 
 /**
-- 
2.43.0



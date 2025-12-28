Return-Path: <linux-integrity+bounces-8140-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 648C2CE487B
	for <lists+linux-integrity@lfdr.de>; Sun, 28 Dec 2025 04:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3EDB730019C6
	for <lists+linux-integrity@lfdr.de>; Sun, 28 Dec 2025 03:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9AA81724;
	Sun, 28 Dec 2025 03:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="QNesZ4SG"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4090124B28
	for <linux-integrity@vger.kernel.org>; Sun, 28 Dec 2025 03:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766891977; cv=none; b=Fxzl4iclg6k1mr1DGl/FZxPP9ZlGwaTUkwgLeY0ERaoVN29rGSpoSU8QJr7hkik5cGtcQDuaFmsLP6kkGgi2TqkofFUYJSMwnRUYJDFXdOsIThC+lROp9tisotXo4SJlvnnZsX5IwXodzkl2+ZkPE1tDQwCJ9E6ckrI6XbHGp4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766891977; c=relaxed/simple;
	bh=eG8oUFAI4PetIG9wFbyzjuQjQ953cNpI3qyl1mZiJgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nOFbpWGHPIjNgbeFUfQkM5R1pUXETWYaf3+EPxFFDg8Hi3PeVJ4wmORiYeoupL1mYss1mGFhP9AzIn/LoV8C+mpOtPulW5TW2jQqgFKmN6yko3yttySGJPEjDFPGEB8LYATOZrV+HldbRhPydV/fMa5zgbjZkOe+tfRQeGD+H+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=QNesZ4SG; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-888310b91c5so76114666d6.1
        for <linux-integrity@vger.kernel.org>; Sat, 27 Dec 2025 19:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1766891975; x=1767496775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wz8HMmajZ9W4jVJulNGBtrLS2GpN8d2v1Td+fLbOd2A=;
        b=QNesZ4SGqjLCescb4LGbuerABczHli+mj0TYW0rFGCy5EUwCOuO1NAWflLXbyyJKBl
         08vY13bnfi7rzEFhBGas9FADAHHDxy7JzG4bfq8gtymZHGy067rEga8GVBGy+LM0WLBW
         0H0bAyF6VOEG0qcIftE0y9i1Qqzm1BD9FuisF663E09n0NnOvqn9EOSObhNOG1J+Fjn/
         vVSzUInvSYH6Zg8Irx0i3Q3UYnC+yPbYt3EjoO9lV0hXdjh3ShPvG3YRxn6ltUMFfdiT
         pbsSv7abwI22k1tWmsDWRuxcIYekcUm0b62C6kwU/c8Nb8bampyRJb2VMzcsXE1Duiz+
         fMGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766891975; x=1767496775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wz8HMmajZ9W4jVJulNGBtrLS2GpN8d2v1Td+fLbOd2A=;
        b=m6bSHQjdJ7i8f/YWV+c4zXMpPU0K9ifUdYsG7qqxg3Kq3DG8hDJ65Stqzwfh36Qnqq
         GMZafh1hfuqFaqRuSA7qdXSpLWAmtRYYraAQOH5uYNgllOdVnEiyQzIDly1yXwAojKZW
         HEB9JP2ABCyO5iCKFxTXV5lbqZpQMjYVPLbytwKgoEOpiK6uIi7zq2UwN6pTwRIVNKTO
         S2vPnTEH3+qMo+64C2toaL98mMa+MDQfqqvSH6ryWyIVilVEevGX0xI5blMPS5J8yAYf
         M+FP4eK2VFTWwz+jCVrWrRoddobzY8ab05ifegZ9VSrOR0rQmuzLdyMP2J9ioZyDWy8q
         h5oA==
X-Forwarded-Encrypted: i=1; AJvYcCWxmiTN535r+pf15oVgeKh4HCKibfyxt0QIvVIgXepB55oFkX6Gam9eZWj53sSvDDbD+SmX2/+YuFKeDiR5WT4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/e9WLm20qoU+Iq0uKOxW5dmX9Gc3nZnOev3E2iHWVqzv9Dq/x
	WmJPmR0yLtBfUkSK08TuFpMkUBuA2MCEn7q5xxZppn00EpKhNX8WyDrfQO//ow5a49Q=
X-Gm-Gg: AY/fxX5MM+0ZDOWA0MINViTuRnNjJGyec4a/o6k2A2OAr2Qlpm83WK+4cICQ6hR2fFB
	2wAxEN9wSCIQCApU6W/sua0dgnHlcIpn7/dQ3hLm60wI51Qz0/Du3AIDhcep8rttYsPyQHO1Opi
	8WU6TnpHzoZpq7qYWLpw8RPPBQ3mZf7WxUh3vsbXPdOy6G7qZieLo88rM4d9hT3HFOKrcLjDoR+
	4SJY5nz32kGBVXf4yT76AfmR8mTDoCHuM+/hyQdliJv2kgGG2ZjTvlzbPuhg66+3j6VdZaIA4KK
	7rFhoJ3wm1EwYIXtHS6ZtJv2HCL9uqpe/OAJl19YyEI2PRDo5v72696H8y0vSqXVVArNvPIUUQ4
	oHP135W5xIHZFUzQpV7PApwMFN8n3RrRvXewUXVVOvzLJcwASHobsTOlKTAZ5aVGXONU1xZj57h
	UySwkLH8V94g==
X-Google-Smtp-Source: AGHT+IFUZcvu/IX20E9sdhoqfHxwFxSu+aK649g3tolccQ2x7sR+ykIEOMiRboAEbGc3M6AHIHL+Og==
X-Received: by 2002:a05:6214:23c5:b0:88a:4c50:3be0 with SMTP id 6a1803df08f44-88c5001fe40mr466683966d6.6.1766891974886;
        Sat, 27 Dec 2025 19:19:34 -0800 (PST)
Received: from 861G6M3.attlocal.net ([2a09:bac1:76a0:780::5e:1f])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d997aef2esm200481436d6.32.2025.12.27.19.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 19:19:34 -0800 (PST)
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
Subject: [PATCH v3] ima: Fix stack-out-of-bounds in is_bprm_creds_for_exec()
Date: Sat, 27 Dec 2025 21:18:54 -0600
Message-ID: <20251228031914.47618-1-carges@cloudflare.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <3aeed1ff9388f09555bf5c6ade03cbe9ce93ff14.camel@linux.ibm.com>
References: <3aeed1ff9388f09555bf5c6ade03cbe9ce93ff14.camel@linux.ibm.com>
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
 security/integrity/ima/ima.h          |  6 ++++--
 security/integrity/ima/ima_appraise.c | 16 +++-------------
 security/integrity/ima/ima_main.c     | 22 +++++++++++++---------
 3 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index e3d71d8d56e3..89ebe98ffc5e 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -441,7 +441,8 @@ int ima_check_blacklist(struct ima_iint_cache *iint,
 int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 			     struct file *file, const unsigned char *filename,
 			     struct evm_ima_xattr_data *xattr_value,
-			     int xattr_len, const struct modsig *modsig);
+			     int xattr_len, const struct modsig *modsig,
+			     bool bprm_is_check);
 int ima_must_appraise(struct mnt_idmap *idmap, struct inode *inode,
 		      int mask, enum ima_hooks func);
 void ima_update_xattr(struct ima_iint_cache *iint, struct file *file);
@@ -466,7 +467,8 @@ static inline int ima_appraise_measurement(enum ima_hooks func,
 					   const unsigned char *filename,
 					   struct evm_ima_xattr_data *xattr_value,
 					   int xattr_len,
-					   const struct modsig *modsig)
+					   const struct modsig *modsig,
+					   bool bprm_is_check)
 {
 	return INTEGRITY_UNKNOWN;
 }
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 5149ff4fd50d..16c20c578ea8 100644
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
@@ -492,7 +481,8 @@ static bool is_bprm_creds_for_exec(enum ima_hooks func, struct file *file)
 int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 			     struct file *file, const unsigned char *filename,
 			     struct evm_ima_xattr_data *xattr_value,
-			     int xattr_len, const struct modsig *modsig)
+			     int xattr_len, const struct modsig *modsig,
+			     bool bprm_is_check)
 {
 	static const char op[] = "appraise_data";
 	int audit_msgno = AUDIT_INTEGRITY_DATA;
@@ -514,7 +504,7 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 	 * of the script interpreter(userspace). Differentiate kernel and
 	 * userspace enforced integrity audit messages.
 	 */
-	if (is_bprm_creds_for_exec(func, file))
+	if (bprm_is_check)
 		audit_msgno = AUDIT_INTEGRITY_USERSPACE;
 
 	/* If reading the xattr failed and there's no modsig, error out. */
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 5770cf691912..1d6229b156fb 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -236,7 +236,8 @@ static void ima_file_free(struct file *file)
 static int process_measurement(struct file *file, const struct cred *cred,
 			       struct lsm_prop *prop, char *buf, loff_t size,
 			       int mask, enum ima_hooks func,
-			       enum kernel_read_file_id read_id)
+			       enum kernel_read_file_id read_id,
+			       bool bprm_is_check)
 {
 	struct inode *real_inode, *inode = file_inode(file);
 	struct ima_iint_cache *iint = NULL;
@@ -426,7 +427,8 @@ static int process_measurement(struct file *file, const struct cred *cred,
 			inode_lock(inode);
 			rc = ima_appraise_measurement(func, iint, file,
 						      pathname, xattr_value,
-						      xattr_len, modsig);
+						      xattr_len, modsig,
+						      bprm_is_check);
 			inode_unlock(inode);
 		}
 		if (!rc)
@@ -493,14 +495,15 @@ static int ima_file_mmap(struct file *file, unsigned long reqprot,
 
 	if (reqprot & PROT_EXEC) {
 		ret = process_measurement(file, current_cred(), &prop, NULL,
-					  0, MAY_EXEC, MMAP_CHECK_REQPROT, 0);
+					  0, MAY_EXEC, MMAP_CHECK_REQPROT, 0,
+					  false);
 		if (ret)
 			return ret;
 	}
 
 	if (prot & PROT_EXEC)
 		return process_measurement(file, current_cred(), &prop, NULL,
-					   0, MAY_EXEC, MMAP_CHECK, 0);
+					   0, MAY_EXEC, MMAP_CHECK, 0, false);
 
 	return 0;
 }
@@ -584,7 +587,8 @@ static int ima_bprm_check(struct linux_binprm *bprm)
 
 	security_current_getlsmprop_subj(&prop);
 	return process_measurement(bprm->file, current_cred(),
-				   &prop, NULL, 0, MAY_EXEC, BPRM_CHECK, 0);
+				   &prop, NULL, 0, MAY_EXEC, BPRM_CHECK, 0,
+				   bprm->is_check);
 }
 
 /**
@@ -614,7 +618,7 @@ static int ima_creds_check(struct linux_binprm *bprm, const struct file *file)
 
 	security_current_getlsmprop_subj(&prop);
 	return process_measurement((struct file *)file, bprm->cred, &prop, NULL,
-				   0, MAY_EXEC, CREDS_CHECK, 0);
+				   0, MAY_EXEC, CREDS_CHECK, 0, false);
 }
 
 /**
@@ -662,7 +666,7 @@ static int ima_file_check(struct file *file, int mask)
 	security_current_getlsmprop_subj(&prop);
 	return process_measurement(file, current_cred(), &prop, NULL, 0,
 				   mask & (MAY_READ | MAY_WRITE | MAY_EXEC |
-					   MAY_APPEND), FILE_CHECK, 0);
+					   MAY_APPEND), FILE_CHECK, 0, false);
 }
 
 static int __ima_inode_hash(struct inode *inode, struct file *file, char *buf,
@@ -881,7 +885,7 @@ static int ima_read_file(struct file *file, enum kernel_read_file_id read_id,
 	func = read_idmap[read_id] ?: FILE_CHECK;
 	security_current_getlsmprop_subj(&prop);
 	return process_measurement(file, current_cred(), &prop, NULL, 0,
-				   MAY_READ, func, 0);
+				   MAY_READ, func, 0, false);
 }
 
 const int read_idmap[READING_MAX_ID] = {
@@ -925,7 +929,7 @@ static int ima_post_read_file(struct file *file, char *buf, loff_t size,
 	func = read_idmap[read_id] ?: FILE_CHECK;
 	security_current_getlsmprop_subj(&prop);
 	return process_measurement(file, current_cred(), &prop, buf, size,
-				   MAY_READ, func, read_id);
+				   MAY_READ, func, read_id, false);
 }
 
 /**
-- 
2.43.0



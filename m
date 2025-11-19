Return-Path: <linux-integrity+bounces-7631-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D604C6CA7A
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Nov 2025 04:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DD87A4E6BBB
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Nov 2025 03:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C629227F015;
	Wed, 19 Nov 2025 03:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PG2fjgY1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="C0IxfXJS"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010701917CD
	for <linux-integrity@vger.kernel.org>; Wed, 19 Nov 2025 03:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763524048; cv=none; b=duR+zLfr/uDpvdGrDP06a+t0FotQSqMv6AX8RmRjmt+nuSFpaGqBxSA2zECsIyphca+6145LD8Oyqdp0jUMV/RoTGH7vOW7acBCd6nLULctIo0nb/gPu60TEwNJs5+bOkslTdvhMLAiIigN4aehOaV1LQZUuphNnoIC+jrpt94M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763524048; c=relaxed/simple;
	bh=sAgaW41yIgMaoEvvflo/CQbk3JRAIxoAS7WWcaUJLQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ktv06dSxzcgkjOhNZ6ItisuopKODMNg6nSG73EjOuA70L+s1HnC+8fb7LKceoCg37Eh9p9uEupLKNE/pna5NkuDyLYQRt97lVYOno42YiJQGr9l4yxHxg/Tmox2Nqm3QqCE5IWhYqJAzLHBJZfDrhjppdhS625RkvP+d64BuhSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PG2fjgY1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=C0IxfXJS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763524045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JCJ20fAfU4UAl4nhBDPE2F0lHJsnmGeSDQ/Z9o7J34w=;
	b=PG2fjgY1l6cyIn1IGdjkzTdLRGmc46MG0wkHw3Tzah+m3LeGHlrJfeB7MTKbPq7fIrAB+9
	kBuU1iOaeizgXXpvBNaqGrGtgRF/uN4QankgR1d4FK+PJv2ErA8VnmO/ZQGIQP7FHb8xkU
	69/WJOh2eiI4A09ReaahLTtGY7AtuNE=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-1wZf07azPw68WKRYSKOj1Q-1; Tue, 18 Nov 2025 22:47:24 -0500
X-MC-Unique: 1wZf07azPw68WKRYSKOj1Q-1
X-Mimecast-MFC-AGG-ID: 1wZf07azPw68WKRYSKOj1Q_1763524043
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-297fbfb4e53so111438165ad.1
        for <linux-integrity@vger.kernel.org>; Tue, 18 Nov 2025 19:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763524043; x=1764128843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JCJ20fAfU4UAl4nhBDPE2F0lHJsnmGeSDQ/Z9o7J34w=;
        b=C0IxfXJSbcneOUm1O48iWzA69y5bHtr0JWl72ZmrldhYb9/WBS2c3KsTQifLp0MFzQ
         48cyW1SkVnUbEMUHO0flckbuCEGKR31QkrHnOu14mWoQg/usSBGjTPW+amYkdjX1aAZa
         NZYf6GjAYkoxse2EhSUii4JiHiHR7ocVPYyJ1nAxUCnS2gHjT+gVaAInrGMwVW2FpHFH
         /umy465thLzFFiz21bojvKEVu4EIAUHw6VsPSsX3SpwJNzfDmDd39YzucW997ZsIQFAI
         R8m/hIKZdXpMjjQCVn5xh61mfZQiQSem0or/TlsiEI5kdsLII09O9D0wJQrfHPDW/Ugd
         9t8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763524043; x=1764128843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JCJ20fAfU4UAl4nhBDPE2F0lHJsnmGeSDQ/Z9o7J34w=;
        b=YyQiruPEbfEQ4z2Y5rZXmmkMHYN/tVZ5fC9QO2UlDLvOsG8vvh5L6NhJ71aDjy/6CA
         OQBnMANHJNAhrH9EjC+NdkHBlB0cE0fvJCbgqePlVBQHXWLWBFbSNp4GnmE/NbmmTlKC
         ere1+NiV4eHo1ucOM5gpRGpgza/sagE/NMr/CmS4CtBtkIynk/kq25pHEhIR8TddhtRJ
         DXGmKZTB7NSIKaZE3T0FgUFlZ+BxgDuLHdf8/fVGChan+e4C+rxH2VR//JQUgxzJln+r
         MAOO+DepVj12h/pQBwtWCSPXDuua1BeX/YlGYIpcTdmdVbC/k2Ifu5NxRaAKfcHzzPuy
         gpBw==
X-Gm-Message-State: AOJu0Ywzd7sEdQDv9Lw8BDQBZjCQP1v8QPYurZgacElhiciql6Jujj+T
	9F/1mOcOL96tP2v0fBAsvJo2TRQ/FNYhXEcYzMkX3sdYY7jHJAGeJpiF1bXGJ3e+968ElGx7ofb
	IdyemEZVx2I71a+EECsZetRjoVq11O/F2fgdcrKJxqHel/2LjdoHOLDtMoY70T3Y+heq+NvYEt2
	rCFWEG9EWzNR019xnCmxeiu6LZDNThEwoxCKiPT7V4pk3sBLMvfoU=
X-Gm-Gg: ASbGncs2NqkohvNQ/cRNN2ctPEGZ6F4VIATFtgsyoFxd05rLCuYRd+LoGXtix/f/bH6
	LhPorDR9jn6KaF8rCcvPRvKYeOjSt8o1MUvFb2nARtbM80PSKQ7C/5AxL/Gu4TQQ3Xa7kjvSr3r
	5OVV+KRLEwkv+8AwX/b24D30gtCbXKrt9CrNnuBbTIIBfUCdDHvS3J2qJO9FkSMLFU6S73WtHAk
	pOndqHpMI5U+MMWENqKl0mJZj91BAfZHQfsB39FdMR7c60gcnY/jWFvH0JLmCQvwceLYJ6pB3qA
	8oCLUxF1qOAJsNMq9DzEBel/GnF9CkUNFyZBbU7NF/sp62RKaVfR3EzfofSyNmaiYiYvbaierMz
	V
X-Received: by 2002:a17:902:d48e:b0:295:570d:116e with SMTP id d9443c01a7336-2986a74a03amr203814945ad.41.1763524042832;
        Tue, 18 Nov 2025 19:47:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKYqgZfFXPmK/y5ioIfktkqnDZ4BIIot5KWSoNG8E059/HCjYd/LVVgtAco2dIKSYFg6P4mA==
X-Received: by 2002:a17:902:d48e:b0:295:570d:116e with SMTP id d9443c01a7336-2986a74a03amr203814415ad.41.1763524042118;
        Tue, 18 Nov 2025 19:47:22 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2b06b6sm189666015ad.55.2025.11.18.19.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 19:47:21 -0800 (PST)
From: Coiby Xu <coxu@redhat.com>
To: linux-integrity@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>
Cc: Karel Srot <ksrot@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Fan Wu <wufan@kernel.org>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-modules@vger.kernel.org (open list:MODULE SUPPORT),
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	selinux@vger.kernel.org (open list:SELINUX SECURITY MODULE)
Subject: [PATCH v3] ima: Access decompressed kernel module to verify appended signature
Date: Wed, 19 Nov 2025 11:47:16 +0800
Message-ID: <20251119034718.618008-1-coxu@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251031074016.1975356-1-coxu@redhat.com>
References: <20251031074016.1975356-1-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, when in-kernel module decompression (CONFIG_MODULE_DECOMPRESS)
is enabled, IMA has no way to verify the appended module signature as it
can't decompress the module.

Define a new kernel_read_file_id enumerate READING_MODULE_COMPRESSED so
IMA can know only to collect original module data hash on
READING_MODULE_COMPRESSED and defer appraising/measuring it until on
READING_MODULE when the module has been decompressed.

Before enabling in-kernel module decompression, a kernel module in
initramfs can still be loaded with ima_policy=secure_boot. So adjust the
kernel module rule in secure_boot policy to allow either an IMA
signature OR an appended signature i.e. to use
"appraise func=MODULE_CHECK appraise_type=imasig|modsig".

Reported-by: Karel Srot <ksrot@redhat.com>
Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Suggested-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Coiby Xu <coxu@redhat.com>
---
 include/linux/kernel_read_file.h    |  1 +
 kernel/module/main.c                | 17 ++++++++++++++---
 security/integrity/ima/ima_main.c   | 24 ++++++++++++++++--------
 security/integrity/ima/ima_policy.c |  3 ++-
 security/ipe/hooks.c                |  1 +
 security/selinux/hooks.c            |  5 +++--
 6 files changed, 37 insertions(+), 14 deletions(-)

diff --git a/include/linux/kernel_read_file.h b/include/linux/kernel_read_file.h
index 90451e2e12bd..d613a7b4dd35 100644
--- a/include/linux/kernel_read_file.h
+++ b/include/linux/kernel_read_file.h
@@ -14,6 +14,7 @@
 	id(KEXEC_INITRAMFS, kexec-initramfs)	\
 	id(POLICY, security-policy)		\
 	id(X509_CERTIFICATE, x509-certificate)	\
+	id(MODULE_COMPRESSED, kernel-module-compressed) \
 	id(MAX_ID, )
 
 #define __fid_enumify(ENUM, dummy) READING_ ## ENUM,
diff --git a/kernel/module/main.c b/kernel/module/main.c
index c66b26184936..7b3ec2fa6e7c 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3675,24 +3675,35 @@ static int idempotent_wait_for_completion(struct idempotent *u)
 
 static int init_module_from_file(struct file *f, const char __user * uargs, int flags)
 {
+	bool compressed = !!(flags & MODULE_INIT_COMPRESSED_FILE);
 	struct load_info info = { };
 	void *buf = NULL;
 	int len;
+	int err;
 
-	len = kernel_read_file(f, 0, &buf, INT_MAX, NULL, READING_MODULE);
+	len = kernel_read_file(f, 0, &buf, INT_MAX, NULL,
+			       compressed ? READING_MODULE_COMPRESSED :
+					    READING_MODULE);
 	if (len < 0) {
 		mod_stat_inc(&failed_kreads);
 		return len;
 	}
 
-	if (flags & MODULE_INIT_COMPRESSED_FILE) {
-		int err = module_decompress(&info, buf, len);
+	if (compressed) {
+		err = module_decompress(&info, buf, len);
 		vfree(buf); /* compressed data is no longer needed */
 		if (err) {
 			mod_stat_inc(&failed_decompress);
 			mod_stat_add_long(len, &invalid_decompress_bytes);
 			return err;
 		}
+		err = security_kernel_post_read_file(f, (char *)info.hdr, info.len,
+						     READING_MODULE);
+		if (err) {
+			mod_stat_inc(&failed_kreads);
+			free_copy(&info, flags);
+			return err;
+		}
 	} else {
 		info.hdr = buf;
 		info.len = len;
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index cdd225f65a62..49f8b2b1a9af 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -235,7 +235,8 @@ static void ima_file_free(struct file *file)
 
 static int process_measurement(struct file *file, const struct cred *cred,
 			       struct lsm_prop *prop, char *buf, loff_t size,
-			       int mask, enum ima_hooks func)
+			       int mask, enum ima_hooks func,
+			       enum kernel_read_file_id read_id)
 {
 	struct inode *real_inode, *inode = file_inode(file);
 	struct ima_iint_cache *iint = NULL;
@@ -406,6 +407,12 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	if (rc != 0 && rc != -EBADF && rc != -EINVAL)
 		goto out_locked;
 
+	/* Defer measuring/appraising kernel modules to READING_MODULE */
+	if (read_id == READING_MODULE_COMPRESSED) {
+		must_appraise = 0;
+		goto out_locked;
+	}
+
 	if (!pathbuf)	/* ima_rdwr_violation possibly pre-fetched */
 		pathname = ima_d_path(&file->f_path, &pathbuf, filename);
 
@@ -486,14 +493,14 @@ static int ima_file_mmap(struct file *file, unsigned long reqprot,
 
 	if (reqprot & PROT_EXEC) {
 		ret = process_measurement(file, current_cred(), &prop, NULL,
-					  0, MAY_EXEC, MMAP_CHECK_REQPROT);
+					  0, MAY_EXEC, MMAP_CHECK_REQPROT, 0);
 		if (ret)
 			return ret;
 	}
 
 	if (prot & PROT_EXEC)
 		return process_measurement(file, current_cred(), &prop, NULL,
-					   0, MAY_EXEC, MMAP_CHECK);
+					   0, MAY_EXEC, MMAP_CHECK, 0);
 
 	return 0;
 }
@@ -578,13 +585,13 @@ static int ima_bprm_check(struct linux_binprm *bprm)
 
 	security_current_getlsmprop_subj(&prop);
 	ret = process_measurement(bprm->file, current_cred(),
-				  &prop, NULL, 0, MAY_EXEC, BPRM_CHECK);
+				  &prop, NULL, 0, MAY_EXEC, BPRM_CHECK, 0);
 	if (ret)
 		return ret;
 
 	security_cred_getlsmprop(bprm->cred, &prop);
 	return process_measurement(bprm->file, bprm->cred, &prop, NULL, 0,
-				   MAY_EXEC, CREDS_CHECK);
+				   MAY_EXEC, CREDS_CHECK, 0);
 }
 
 /**
@@ -632,7 +639,7 @@ static int ima_file_check(struct file *file, int mask)
 	security_current_getlsmprop_subj(&prop);
 	return process_measurement(file, current_cred(), &prop, NULL, 0,
 				   mask & (MAY_READ | MAY_WRITE | MAY_EXEC |
-					   MAY_APPEND), FILE_CHECK);
+					   MAY_APPEND), FILE_CHECK, 0);
 }
 
 static int __ima_inode_hash(struct inode *inode, struct file *file, char *buf,
@@ -851,12 +858,13 @@ static int ima_read_file(struct file *file, enum kernel_read_file_id read_id,
 	func = read_idmap[read_id] ?: FILE_CHECK;
 	security_current_getlsmprop_subj(&prop);
 	return process_measurement(file, current_cred(), &prop, NULL, 0,
-				   MAY_READ, func);
+				   MAY_READ, func, 0);
 }
 
 const int read_idmap[READING_MAX_ID] = {
 	[READING_FIRMWARE] = FIRMWARE_CHECK,
 	[READING_MODULE] = MODULE_CHECK,
+	[READING_MODULE_COMPRESSED] = MODULE_CHECK,
 	[READING_KEXEC_IMAGE] = KEXEC_KERNEL_CHECK,
 	[READING_KEXEC_INITRAMFS] = KEXEC_INITRAMFS_CHECK,
 	[READING_POLICY] = POLICY_CHECK
@@ -894,7 +902,7 @@ static int ima_post_read_file(struct file *file, char *buf, loff_t size,
 	func = read_idmap[read_id] ?: FILE_CHECK;
 	security_current_getlsmprop_subj(&prop);
 	return process_measurement(file, current_cred(), &prop, buf, size,
-				   MAY_READ, func);
+				   MAY_READ, func, read_id);
 }
 
 /**
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 128fab897930..ae520e6bb1cf 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -241,7 +241,8 @@ static struct ima_rule_entry build_appraise_rules[] __ro_after_init = {
 
 static struct ima_rule_entry secure_boot_rules[] __ro_after_init = {
 	{.action = APPRAISE, .func = MODULE_CHECK,
-	 .flags = IMA_FUNC | IMA_DIGSIG_REQUIRED},
+	 .flags = IMA_FUNC | IMA_DIGSIG_REQUIRED | IMA_MODSIG_ALLOWED |
+		  IMA_CHECK_BLACKLIST},
 	{.action = APPRAISE, .func = FIRMWARE_CHECK,
 	 .flags = IMA_FUNC | IMA_DIGSIG_REQUIRED},
 	{.action = APPRAISE, .func = KEXEC_KERNEL_CHECK,
diff --git a/security/ipe/hooks.c b/security/ipe/hooks.c
index d0323b81cd8f..1053a4acf589 100644
--- a/security/ipe/hooks.c
+++ b/security/ipe/hooks.c
@@ -118,6 +118,7 @@ int ipe_kernel_read_file(struct file *file, enum kernel_read_file_id id,
 		op = IPE_OP_FIRMWARE;
 		break;
 	case READING_MODULE:
+	case READING_MODULE_COMPRESSED:
 		op = IPE_OP_KERNEL_MODULE;
 		break;
 	case READING_KEXEC_INITRAMFS:
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index dfc22da42f30..c1ff69d5d76e 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4275,7 +4275,7 @@ static int selinux_kernel_read_file(struct file *file,
 {
 	int rc = 0;
 
-	BUILD_BUG_ON_MSG(READING_MAX_ID > 7,
+	BUILD_BUG_ON_MSG(READING_MAX_ID > 8,
 			 "New kernel_read_file_id introduced; update SELinux!");
 
 	switch (id) {
@@ -4283,6 +4283,7 @@ static int selinux_kernel_read_file(struct file *file,
 		rc = selinux_kernel_load_from_file(file, SYSTEM__FIRMWARE_LOAD);
 		break;
 	case READING_MODULE:
+	case READING_MODULE_COMPRESSED:
 		rc = selinux_kernel_load_from_file(file, SYSTEM__MODULE_LOAD);
 		break;
 	case READING_KEXEC_IMAGE:
@@ -4311,7 +4312,7 @@ static int selinux_kernel_load_data(enum kernel_load_data_id id, bool contents)
 {
 	int rc = 0;
 
-	BUILD_BUG_ON_MSG(LOADING_MAX_ID > 7,
+	BUILD_BUG_ON_MSG(LOADING_MAX_ID > 8,
 			 "New kernel_load_data_id introduced; update SELinux!");
 
 	switch (id) {

base-commit: 6a23ae0a96a600d1d12557add110e0bb6e32730c
-- 
2.51.1



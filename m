Return-Path: <linux-integrity+bounces-6276-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3911ABF717
	for <lists+linux-integrity@lfdr.de>; Wed, 21 May 2025 16:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83967171D69
	for <lists+linux-integrity@lfdr.de>; Wed, 21 May 2025 14:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD7F18FC80;
	Wed, 21 May 2025 14:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nightmared.fr header.i=@nightmared.fr header.b="L97C07CA"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.nightmared.fr (mail.nightmared.fr [51.158.148.24])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADFB18B492;
	Wed, 21 May 2025 14:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.158.148.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747836366; cv=none; b=EHoTzBcoyGdaQjMq8/tgf4iQz6EA/20q5qMH8MvDMY8g/dXkxFbvtiT9UxauILEF8H9g5iKFCYNnRn3pLqtv3tuCFDwJm+MLeOWx5bILwRdxpxCGFtXhGcapQc7a993My75v5S9V3jGw8NLnH/3t9P/U66ewBxZdyLkCHSo704Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747836366; c=relaxed/simple;
	bh=OK0lBPVdCl68YwgolnFe41OrVjHUPKYmOOMkmHKJppk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a28UY+qUNbr91Ks6kOm7ft57Fs5Ez0L+QqBLMyV+vF/Dh62JAHb0wn1UptUfglPsj6q3j/Ulh+fez9G6ex9tDCp9IXq4BK97icHJR4LkeQTlaRpMncEtQ14e6dHniTvUzmnSQ4hKFIAL953CKTCXM94ij6knpgaHbxEoAUE+mqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nightmared.fr; spf=pass smtp.mailfrom=nightmared.fr; dkim=pass (2048-bit key) header.d=nightmared.fr header.i=@nightmared.fr header.b=L97C07CA; arc=none smtp.client-ip=51.158.148.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nightmared.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nightmared.fr
Received: from localhost.localdomain (atoulon-651-1-170-218.w83-113.abo.wanadoo.fr [83.113.65.218])
	by mail.nightmared.fr (Postfix) with ESMTPSA id E473E1087A3F;
	Wed, 21 May 2025 14:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nightmared.fr;
	s=docker; t=1747836107;
	bh=OK0lBPVdCl68YwgolnFe41OrVjHUPKYmOOMkmHKJppk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L97C07CAts3c4Kl3Y36gHWTokcsWhjNUc/7YutkMmfw4rV8k8Pm0Mb/TxjIYS1Zw6
	 +oYN5dfuE9N602sU14KMiSPEBlu+5mCF+HOaxWv/TANL9EX2Pssl6XFJf4DSTvB/To
	 WOEbN8Y0+nfAJkJcLmJfXXKpg/GcPWwhki61WaeCu5Pf10ie4Cv+nPOLVl4dAhClNy
	 tdTc5DPaXHSMzLg7NLh2bT68fO+MPZGYfE7vXKakfBr85SVpDISyxsD5wS9hQTGaG0
	 2JoRujURtUfbUyRIyIWrNCamdYzMB0Hto8I+2/qRdb+YGWpZnUgfO4Hv+N07Z1WtWA
	 MAr5YzMQJZJOw==
From: Simon THOBY <git@nightmared.fr>
To: linux-security-module@vger.kernel.org
Cc: Simon THOBY <git@nightmared.fr>,
	linux-integrity@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [RFC PATCH 1/9] LSM: Introduce a new hook: security_kernel_module_load
Date: Wed, 21 May 2025 16:01:05 +0200
Message-ID: <20250521140121.591482-2-git@nightmared.fr>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250521140121.591482-1-git@nightmared.fr>
References: <20250521140121.591482-1-git@nightmared.fr>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new hook to allow LSMs to decide whether to block the load
of a kernel module.

Two hooks already exist:
- kernel_module_request is called when the kernel itself (not userspace)
 request the load of a module, e.g. because a device was detected.
 - security_kernel_load_data(LOADING_MODULE) is called when userspace calls
 init_module/finit_module, but lack information about the module because
 its  headers have not been loaded into kernel space, let alone parsed.
 This may not be sufficient for some LSMs.

This new hook is similar to security_kernel_load_data(LOADING_MODULE),
but called after the module signature and header are verified, and only
takes the module name for now.

Signed-off-by: Simon THOBY <git@nightmared.fr>
---
 include/linux/lsm_hook_defs.h |  1 +
 include/linux/module.h        |  1 +
 include/linux/security.h      |  6 ++++++
 kernel/module/main.c          |  4 ++++
 security/security.c           | 14 ++++++++++++++
 5 files changed, 26 insertions(+)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index bf3bbac4e02a..51c5212d8bb6 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -223,6 +223,7 @@ LSM_HOOK(void, LSM_RET_VOID, cred_getlsmprop, const struct cred *c,
 LSM_HOOK(int, 0, kernel_act_as, struct cred *new, u32 secid)
 LSM_HOOK(int, 0, kernel_create_files_as, struct cred *new, struct inode *inode)
 LSM_HOOK(int, 0, kernel_module_request, char *kmod_name)
+LSM_HOOK(int, 0, kernel_module_load, const char *kmod_name)
 LSM_HOOK(int, 0, kernel_load_data, enum kernel_load_data_id id, bool contents)
 LSM_HOOK(int, 0, kernel_post_load_data, char *buf, loff_t size,
 	 enum kernel_load_data_id id, char *description)
diff --git a/include/linux/module.h b/include/linux/module.h
index 8050f77c3b64..b6b8d6f7f599 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -39,6 +39,7 @@ struct modversion_info {
 	char name[MODULE_NAME_LEN];
 };
 
+struct load_info;
 struct module;
 struct exception_table_entry;
 
diff --git a/include/linux/security.h b/include/linux/security.h
index cc9b54d95d22..e175b2cc8caf 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -498,6 +498,7 @@ void security_cred_getlsmprop(const struct cred *c, struct lsm_prop *prop);
 int security_kernel_act_as(struct cred *new, u32 secid);
 int security_kernel_create_files_as(struct cred *new, struct inode *inode);
 int security_kernel_module_request(char *kmod_name);
+int security_kernel_module_load(const char *kmod_name);
 int security_kernel_load_data(enum kernel_load_data_id id, bool contents);
 int security_kernel_post_load_data(char *buf, loff_t size,
 				   enum kernel_load_data_id id,
@@ -1255,6 +1256,11 @@ static inline int security_kernel_module_request(char *kmod_name)
 	return 0;
 }
 
+static inline int security_kernel_module_load(const char *kmod_name)
+{
+	return 0;
+}
+
 static inline int security_kernel_load_data(enum kernel_load_data_id id, bool contents)
 {
 	return 0;
diff --git a/kernel/module/main.c b/kernel/module/main.c
index a2859dc3eea6..12a1a5f4d823 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3228,6 +3228,10 @@ static int early_mod_check(struct load_info *info, int flags)
 		return -EPERM;
 	}
 
+	err = security_kernel_module_load(info->name);
+	if (err)
+		return err;
+
 	err = rewrite_section_headers(info, flags);
 	if (err)
 		return err;
diff --git a/security/security.c b/security/security.c
index fb57e8fddd91..b9430499c332 100644
--- a/security/security.c
+++ b/security/security.c
@@ -3336,6 +3336,20 @@ int security_kernel_module_request(char *kmod_name)
 	return call_int_hook(kernel_module_request, kmod_name);
 }
 
+/**
+ * security_kernel_module_load() - Check if loading a module is allowed
+ * @kmod_name: name of the kernel module being loaded
+ *
+ * This method is called when the userspace called init_module/finit_module
+ * with a valid module
+ *
+ * Return: Returns 0 if successful.
+ */
+int security_kernel_module_load(const char *kmod_name)
+{
+	return call_int_hook(kernel_module_load, kmod_name);
+}
+
 /**
  * security_kernel_read_file() - Read a file specified by userspace
  * @file: file
-- 
2.49.0



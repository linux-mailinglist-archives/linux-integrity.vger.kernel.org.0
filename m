Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C166722D0BC
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Jul 2020 23:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgGXVhG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 24 Jul 2020 17:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727086AbgGXVg5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 24 Jul 2020 17:36:57 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD8FC08C5E0
        for <linux-integrity@vger.kernel.org>; Fri, 24 Jul 2020 14:36:55 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a9so6114391pjd.3
        for <linux-integrity@vger.kernel.org>; Fri, 24 Jul 2020 14:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VgVzk3Bx0tFecnG4gjh1+Ha9QnaGtBiSO/07cJ5aIic=;
        b=Es520S5KI++eI2Ob2uYnSrW7eFdEOaFY7DyzMcSDD2pGMhflJM93fBLF1IUc8bJkwo
         ds4qN3joULYVngwk3VmwGDjVjPqVKnm7BrG8TzsjpfKjx6NuwiPf7OGh+YkceDChrQoa
         oF1j0XKyn0xCme2l+0KlWiWTq6OObPToJO44U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VgVzk3Bx0tFecnG4gjh1+Ha9QnaGtBiSO/07cJ5aIic=;
        b=b5yKJmwojg0mnU4V531t6bRa1H2d9aKwoqYTKYyuoQQFopVgPn+qGvvo0N/4GgcCXG
         RDm7ye+s3N9k8X1R6LzWteY7DAptRuI7DUx6d6QGFUqeLfslZ/XpxWpaLMVTstG4ukzz
         juu1OVVnG9vT3BbppDcOxnx5ftL+Bkhz255jGBKQFW/BPVqkAZ1fNykU8fYqbsGmdM4J
         5uQz5kA3AvvyDAoSvvojTs7GGAoxZIn79CkFlIRtf5s/ySNr+0C1T6B7/ZXCdodPAFtW
         HGEJn7gUMDL7CUy+Ve8kcvhD+DHB9rc/I60ei1TVumyOlLUcgdzFObNP6JmaoP7/Otuh
         zKmQ==
X-Gm-Message-State: AOAM533ZSz1ESz+kW1PUCxDtpiAeXuonTrYBJdN9khGKdyG2UCbcofBD
        OAA3KCGMrLo5BMLIS7OnzLtlGg==
X-Google-Smtp-Source: ABdhPJwcABE+cCcTqqlPH1rYm4t0bSIEEC3E7RKUD0WmDiaAqXaPi8chAKAElyDB4/Xd4PyL2zgjXw==
X-Received: by 2002:a17:90a:ad8e:: with SMTP id s14mr5666585pjq.36.1595626615040;
        Fri, 24 Jul 2020 14:36:55 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y65sm7420401pfb.75.2020.07.24.14.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 14:36:53 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jessica Yu <jeyu@kernel.org>, SeongJae Park <sjpark@amazon.de>,
        KP Singh <kpsingh@chromium.org>, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 14/19] LSM: Add "contents" flag to kernel_read_file hook
Date:   Fri, 24 Jul 2020 14:36:35 -0700
Message-Id: <20200724213640.389191-15-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200724213640.389191-1-keescook@chromium.org>
References: <20200724213640.389191-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

As with the kernel_load_data LSM hook, add a "contents" flag to the
kernel_read_file LSM hook that indicates whether the LSM can expect
a matching call to the kernel_post_read_file LSM hook with the full
contents of the file. With the coming addition of partial file read
support for kernel_read_file*() API, the LSM will no longer be able
to always see the entire contents of a file during the read calls.

For cases where the LSM must read examine the complete file contents,
it will need to do so on its own every time the kernel_read_file
hook is called with contents=false (or reject such cases). Adjust all
existing LSMs to retain existing behavior.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/kernel_read_file.c             |  2 +-
 include/linux/ima.h               |  6 ++++--
 include/linux/lsm_hook_defs.h     |  2 +-
 include/linux/lsm_hooks.h         |  3 +++
 include/linux/security.h          |  6 ++++--
 security/integrity/ima/ima_main.c | 10 +++++++++-
 security/loadpin/loadpin.c        | 14 ++++++++++++--
 security/security.c               |  7 ++++---
 security/selinux/hooks.c          |  5 +++--
 9 files changed, 41 insertions(+), 14 deletions(-)

diff --git a/fs/kernel_read_file.c b/fs/kernel_read_file.c
index 2e29c38eb4df..d73bc3fa710a 100644
--- a/fs/kernel_read_file.c
+++ b/fs/kernel_read_file.c
@@ -39,7 +39,7 @@ int kernel_read_file(struct file *file, void **buf,
 	if (ret)
 		return ret;
 
-	ret = security_kernel_read_file(file, id);
+	ret = security_kernel_read_file(file, id, true);
 	if (ret)
 		goto out;
 
diff --git a/include/linux/ima.h b/include/linux/ima.h
index 502e36ad7804..259023039dc9 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -23,7 +23,8 @@ extern int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot);
 extern int ima_load_data(enum kernel_load_data_id id, bool contents);
 extern int ima_post_load_data(char *buf, loff_t size,
 			      enum kernel_load_data_id id);
-extern int ima_read_file(struct file *file, enum kernel_read_file_id id);
+extern int ima_read_file(struct file *file, enum kernel_read_file_id id,
+			 bool contents);
 extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
 			      enum kernel_read_file_id id);
 extern void ima_post_path_mknod(struct dentry *dentry);
@@ -91,7 +92,8 @@ static inline int ima_post_load_data(char *buf, loff_t size,
 	return 0;
 }
 
-static inline int ima_read_file(struct file *file, enum kernel_read_file_id id)
+static inline int ima_read_file(struct file *file, enum kernel_read_file_id id,
+				bool contents)
 {
 	return 0;
 }
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index aaa2916bbae7..c2ded57c5d9b 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -188,7 +188,7 @@ LSM_HOOK(int, 0, kernel_load_data, enum kernel_load_data_id id, bool contents)
 LSM_HOOK(int, 0, kernel_post_load_data, char *buf, loff_t size,
 	 enum kernel_read_file_id id)
 LSM_HOOK(int, 0, kernel_read_file, struct file *file,
-	 enum kernel_read_file_id id)
+	 enum kernel_read_file_id id, bool contents)
 LSM_HOOK(int, 0, kernel_post_read_file, struct file *file, char *buf,
 	 loff_t size, enum kernel_read_file_id id)
 LSM_HOOK(int, 0, task_fix_setuid, struct cred *new, const struct cred *old,
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 812d626195fc..b66433b5aa15 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -650,6 +650,7 @@
  *	@file contains the file structure pointing to the file being read
  *	by the kernel.
  *	@id kernel read file identifier
+ *	@contents if a subsequent @kernel_post_read_file will be called.
  *	Return 0 if permission is granted.
  * @kernel_post_read_file:
  *	Read a file specified by userspace.
@@ -658,6 +659,8 @@
  *	@buf pointer to buffer containing the file contents.
  *	@size length of the file contents.
  *	@id kernel read file identifier
+ *	This must be paired with a prior @kernel_read_file call that had
+ *	@contents set to true.
  *	Return 0 if permission is granted.
  * @task_fix_setuid:
  *	Update the module's state after setting one or more of the user
diff --git a/include/linux/security.h b/include/linux/security.h
index e748974c707b..a5d66b89cd6c 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -390,7 +390,8 @@ int security_kernel_module_request(char *kmod_name);
 int security_kernel_load_data(enum kernel_load_data_id id, bool contents);
 int security_kernel_post_load_data(char *buf, loff_t size,
 				   enum kernel_load_data_id id);
-int security_kernel_read_file(struct file *file, enum kernel_read_file_id id);
+int security_kernel_read_file(struct file *file, enum kernel_read_file_id id,
+			      bool contents);
 int security_kernel_post_read_file(struct file *file, char *buf, loff_t size,
 				   enum kernel_read_file_id id);
 int security_task_fix_setuid(struct cred *new, const struct cred *old,
@@ -1028,7 +1029,8 @@ static inline int security_kernel_post_load_data(char *buf, loff_t size,
 }
 
 static inline int security_kernel_read_file(struct file *file,
-					    enum kernel_read_file_id id)
+					    enum kernel_read_file_id id,
+					    bool contents)
 {
 	return 0;
 }
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 1a7bc4c7437d..dc4f90660aa6 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -602,6 +602,7 @@ void ima_post_path_mknod(struct dentry *dentry)
  * ima_read_file - pre-measure/appraise hook decision based on policy
  * @file: pointer to the file to be measured/appraised/audit
  * @read_id: caller identifier
+ * @contents: whether a subsequent call will be made to ima_post_read_file()
  *
  * Permit reading a file based on policy. The policy rules are written
  * in terms of the policy identifier.  Appraising the integrity of
@@ -609,8 +610,15 @@ void ima_post_path_mknod(struct dentry *dentry)
  *
  * For permission return 0, otherwise return -EACCES.
  */
-int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
+int ima_read_file(struct file *file, enum kernel_read_file_id read_id,
+		  bool contents)
 {
+	/* Reject all partial reads during appraisal. */
+	if (!contents) {
+		if (ima_appraise & IMA_APPRAISE_ENFORCE)
+			return -EACCES;
+	}
+
 	/*
 	 * Do devices using pre-allocated memory run the risk of the
 	 * firmware being accessible to the device prior to the completion
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index db320a43f42e..a1778ebef137 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -117,11 +117,21 @@ static void loadpin_sb_free_security(struct super_block *mnt_sb)
 	}
 }
 
-static int loadpin_read_file(struct file *file, enum kernel_read_file_id id)
+static int loadpin_read_file(struct file *file, enum kernel_read_file_id id,
+			     bool contents)
 {
 	struct super_block *load_root;
 	const char *origin = kernel_read_file_id_str(id);
 
+	/*
+	 * If we will not know that we'll be seeing the full contents
+	 * then we cannot trust a load will be complete and unchanged
+	 * off disk. Treat all contents=false hooks as if there were
+	 * no associated file struct.
+	 */
+	if (!contents)
+		file = NULL;
+
 	/* If the file id is excluded, ignore the pinning. */
 	if ((unsigned int)id < ARRAY_SIZE(ignore_read_file_id) &&
 	    ignore_read_file_id[id]) {
@@ -178,7 +188,7 @@ static int loadpin_read_file(struct file *file, enum kernel_read_file_id id)
 
 static int loadpin_load_data(enum kernel_load_data_id id, bool contents)
 {
-	return loadpin_read_file(NULL, (enum kernel_read_file_id) id);
+	return loadpin_read_file(NULL, (enum kernel_read_file_id) id, contents);
 }
 
 static struct security_hook_list loadpin_hooks[] __lsm_ro_after_init = {
diff --git a/security/security.c b/security/security.c
index 090674f1197a..800af5403176 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1657,14 +1657,15 @@ int security_kernel_module_request(char *kmod_name)
 	return integrity_kernel_module_request(kmod_name);
 }
 
-int security_kernel_read_file(struct file *file, enum kernel_read_file_id id)
+int security_kernel_read_file(struct file *file, enum kernel_read_file_id id,
+			      bool contents)
 {
 	int ret;
 
-	ret = call_int_hook(kernel_read_file, 0, file, id);
+	ret = call_int_hook(kernel_read_file, 0, file, id, contents);
 	if (ret)
 		return ret;
-	return ima_read_file(file, id);
+	return ima_read_file(file, id, contents);
 }
 EXPORT_SYMBOL_GPL(security_kernel_read_file);
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 1a5c68196faf..6d183bbc12a6 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -4004,13 +4004,14 @@ static int selinux_kernel_module_from_file(struct file *file)
 }
 
 static int selinux_kernel_read_file(struct file *file,
-				    enum kernel_read_file_id id)
+				    enum kernel_read_file_id id,
+				    bool contents)
 {
 	int rc = 0;
 
 	switch (id) {
 	case READING_MODULE:
-		rc = selinux_kernel_module_from_file(file);
+		rc = selinux_kernel_module_from_file(contents ? file : NULL);
 		break;
 	default:
 		break;
-- 
2.25.1


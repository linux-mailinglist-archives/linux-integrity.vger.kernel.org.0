Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF0D5FE562
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Oct 2022 00:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiJMWhF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Oct 2022 18:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiJMWhC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Oct 2022 18:37:02 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28489144E16
        for <linux-integrity@vger.kernel.org>; Thu, 13 Oct 2022 15:37:00 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id h12so3318006pjk.0
        for <linux-integrity@vger.kernel.org>; Thu, 13 Oct 2022 15:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4QtMvi+okgythLC0BZ5AgbF6b/T036dwH9EuwQzqT3w=;
        b=oPHpU2FNCIKE86DHkbE5v7YdCVfFxuOh2IeHYY2DreHarIwYexNLRoxwOscPXlk54Z
         2XsBONOx9Ca9mdC2873canzK4z+yM15aoISs7hNWPzcT1YPJUreGCcYGFpRBB6gle9kl
         5vsX6q8Bvc8b4zxMGfPt3LYcWr74dN592yUGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4QtMvi+okgythLC0BZ5AgbF6b/T036dwH9EuwQzqT3w=;
        b=e623BhqDAeVxtsI3Z49+C21aiYrkPaTXPqbgODmV6yrM5EaGzBqT4S16TCAALEb9SN
         XUNyTPzvpS0CxvWeoJ/fc5xaxKQY45zRRAhOdCUczSWxUfNOacBxMOhrWwfo/RBSZzqL
         j2q2Usxs8bpgD1/IafF2Wzg9j2EJfdYphUzx0mEL5zkJ3mzgh2f73GOLWOCqink0NYYM
         D1GDtixbWUUFgpVmW1/onDo0w1Myh/igj5zTk/YQyYdcCcELknslj9myTxwxAJXomLlC
         NaEtcQWFnLiFno4dxd7QIXUND1RaF65NO0lwZtH2sbTXN81w2ADH/8mSkv82+bCAwxGY
         o1pA==
X-Gm-Message-State: ACrzQf1FSfkfMvxIYv5n9WUsnMKy/MpBfzPLAJ1vXsrqwZ2aqRVZfZCt
        gbmNmUSHqSjXQALLcavoFM2oWE9Vl8N1jg==
X-Google-Smtp-Source: AMsMyM7DkLAz0Cr9hMytTafIU8DIO/pBbqK97OoNMRskAoB4QQPwJmbuNvvmOIVcxdwboNWl3p7lxw==
X-Received: by 2002:a17:90b:1e0b:b0:20d:7ddf:9b08 with SMTP id pg11-20020a17090b1e0b00b0020d7ddf9b08mr2169714pjb.187.1665700618898;
        Thu, 13 Oct 2022 15:36:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q135-20020a632a8d000000b004277f43b736sm188041pgq.92.2022.10.13.15.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 15:36:56 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Petr Vorel <pvorel@suse.cz>, Borislav Petkov <bp@suse.de>,
        Takashi Iwai <tiwai@suse.de>,
        Jonathan McDowell <noodles@fb.com>,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, KP Singh <kpsingh@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH 2/9] security: Move trivial IMA hooks into LSM
Date:   Thu, 13 Oct 2022 15:36:47 -0700
Message-Id: <20221013223654.659758-2-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221013222702.never.990-kees@kernel.org>
References: <20221013222702.never.990-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=11716; h=from:subject; bh=JPYrXEme63zNrHu8RasMAYqzn5dsYfwQ9sKlRFYwCmg=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjSJMEBD/MwZ0ABEhYQJlMhma7ILk1MIOCXpU03Rs0 Pj96qRKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY0iTBAAKCRCJcvTf3G3AJgJlEA Cl24Ozc1VocmsUXHG32wY4+VYx+AcAuzOiJniFxKvvLj9WZt1tVP6AZjctFfMVwWIYt2Nlp0w5NaLq KR6DqQStima1UGNyAr4KydA8JnaQnpwN77IwaHZ1ICYrUrKzOrdOXu5F+QhyxgHODuswpWPtwVK+ew x8JxGGC1WNatLweiisDHYYWDztKqyLRM5zAdyVG29XHOoXyKvEcLVuYuRaJFLZhCgoL6rWTqQHibTE L3ZJ15erp8I3sBCswkF/cutq1D/h4FkF0ipjXmE4sq5Q4sDFAMLzsVeLoS+77uNySIufqHNEzEJvsv MtkRe9YfjdQ1ebLBOmRTwJ4DK9ygu5UYyEFE3DVjl6s9WCF7xoeeyw1xGeAmWZCGEISesOX3EK1qc6 QG2Qvh0zysfKi4bQh+X/w7YHus44k+O8wibXQXMCOeMA7MayrCMPXDiSLOU13TyewKQKYAR1MaNfMo T2CssSFp7cVYpPa2V1ko6UScmuAnLVwuzGlDI97OoskTZeNpZUCU0SDObm1+NrjbO/OVm4Oz6q3Rry hToO3DDPLYNqpYUahPlARDjFN5Yd85npwGh+K3T3xS75m7UM1ZXJnG1yltz+N2SBik1ARXebC7yHhh PymeAcPzWH1I8+VKQ4In6NgU0I2xesFr6C2GXdeu8txN30aQHn3wLGlT3Y0A==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This moves the trivial hard-coded stacking of IMA LSM hooks into the
existing LSM infrastructure.

Cc: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: "Mickaël Salaün" <mic@digikod.net>
Cc: Petr Vorel <pvorel@suse.cz>
Cc: Borislav Petkov <bp@suse.de>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Jonathan McDowell <noodles@fb.com>
Cc: linux-security-module@vger.kernel.org
Cc: linux-integrity@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/ima.h               | 50 -----------------------------
 security/integrity/ima/ima_main.c | 40 +++++++++++++++++-------
 security/security.c               | 52 ++++++-------------------------
 3 files changed, 37 insertions(+), 105 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 81708ca0ebc7..3c641cc65270 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -16,20 +16,10 @@ struct linux_binprm;
 
 #ifdef CONFIG_IMA
 extern enum hash_algo ima_get_current_hash_algo(void);
-extern int ima_bprm_check(struct linux_binprm *bprm);
 extern int ima_file_check(struct file *file, int mask);
 extern void ima_post_create_tmpfile(struct user_namespace *mnt_userns,
 				    struct inode *inode);
 extern void ima_file_free(struct file *file);
-extern int ima_file_mmap(struct file *file, unsigned long prot);
-extern int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot);
-extern int ima_load_data(enum kernel_load_data_id id, bool contents);
-extern int ima_post_load_data(char *buf, loff_t size,
-			      enum kernel_load_data_id id, char *description);
-extern int ima_read_file(struct file *file, enum kernel_read_file_id id,
-			 bool contents);
-extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
-			      enum kernel_read_file_id id);
 extern void ima_post_path_mknod(struct user_namespace *mnt_userns,
 				struct dentry *dentry);
 extern int ima_file_hash(struct file *file, char *buf, size_t buf_size);
@@ -56,11 +46,6 @@ static inline enum hash_algo ima_get_current_hash_algo(void)
 	return HASH_ALGO__LAST;
 }
 
-static inline int ima_bprm_check(struct linux_binprm *bprm)
-{
-	return 0;
-}
-
 static inline int ima_file_check(struct file *file, int mask)
 {
 	return 0;
@@ -76,41 +61,6 @@ static inline void ima_file_free(struct file *file)
 	return;
 }
 
-static inline int ima_file_mmap(struct file *file, unsigned long prot)
-{
-	return 0;
-}
-
-static inline int ima_file_mprotect(struct vm_area_struct *vma,
-				    unsigned long prot)
-{
-	return 0;
-}
-
-static inline int ima_load_data(enum kernel_load_data_id id, bool contents)
-{
-	return 0;
-}
-
-static inline int ima_post_load_data(char *buf, loff_t size,
-				     enum kernel_load_data_id id,
-				     char *description)
-{
-	return 0;
-}
-
-static inline int ima_read_file(struct file *file, enum kernel_read_file_id id,
-				bool contents)
-{
-	return 0;
-}
-
-static inline int ima_post_read_file(struct file *file, void *buf, loff_t size,
-				     enum kernel_read_file_id id)
-{
-	return 0;
-}
-
 static inline void ima_post_path_mknod(struct user_namespace *mnt_userns,
 				       struct dentry *dentry)
 {
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index e617863af5ff..2cff001b02e4 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -395,6 +395,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 /**
  * ima_file_mmap - based on policy, collect/store measurement.
  * @file: pointer to the file to be measured (May be NULL)
+ * @reqprot: contains the protection that will be applied by the kernel.
  * @prot: contains the protection that will be applied by the kernel.
  *
  * Measure files being mmapped executable based on the ima_must_measure()
@@ -403,11 +404,12 @@ static int process_measurement(struct file *file, const struct cred *cred,
  * On success return 0.  On integrity appraisal error, assuming the file
  * is in policy and IMA-appraisal is in enforcing mode, return -EACCES.
  */
-int ima_file_mmap(struct file *file, unsigned long prot)
+static int ima_file_mmap(struct file *file, unsigned long reqprot,
+			 unsigned long prot, unsigned long flags)
 {
 	u32 secid;
 
-	if (file && (prot & PROT_EXEC)) {
+	if (file && (reqprot & PROT_EXEC)) {
 		security_current_getsecid_subj(&secid);
 		return process_measurement(file, current_cred(), secid, NULL,
 					   0, MAY_EXEC, MMAP_CHECK);
@@ -419,6 +421,7 @@ int ima_file_mmap(struct file *file, unsigned long prot)
 /**
  * ima_file_mprotect - based on policy, limit mprotect change
  * @vma: vm_area_struct protection is set to
+ * @reqprot: contains the protection that were requested.
  * @prot: contains the protection that will be applied by the kernel.
  *
  * Files can be mmap'ed read/write and later changed to execute to circumvent
@@ -429,7 +432,8 @@ int ima_file_mmap(struct file *file, unsigned long prot)
  *
  * On mprotect change success, return 0.  On failure, return -EACESS.
  */
-int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
+static int ima_file_mprotect(struct vm_area_struct *vma,
+			     unsigned long reqprot, unsigned long prot)
 {
 	struct ima_template_desc *template = NULL;
 	struct file *file;
@@ -483,7 +487,7 @@ int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
  * On success return 0.  On integrity appraisal error, assuming the file
  * is in policy and IMA-appraisal is in enforcing mode, return -EACCES.
  */
-int ima_bprm_check(struct linux_binprm *bprm)
+static int ima_bprm_check(struct linux_binprm *bprm)
 {
 	int ret;
 	u32 secid;
@@ -706,8 +710,8 @@ void ima_post_path_mknod(struct user_namespace *mnt_userns,
  *
  * For permission return 0, otherwise return -EACCES.
  */
-int ima_read_file(struct file *file, enum kernel_read_file_id read_id,
-		  bool contents)
+static int ima_read_file(struct file *file, enum kernel_read_file_id read_id,
+			 bool contents)
 {
 	enum ima_hooks func;
 	u32 secid;
@@ -756,8 +760,8 @@ const int read_idmap[READING_MAX_ID] = {
  * On success return 0.  On integrity appraisal error, assuming the file
  * is in policy and IMA-appraisal is in enforcing mode, return -EACCES.
  */
-int ima_post_read_file(struct file *file, void *buf, loff_t size,
-		       enum kernel_read_file_id read_id)
+static int ima_post_read_file(struct file *file, char *buf, loff_t size,
+			      enum kernel_read_file_id read_id)
 {
 	enum ima_hooks func;
 	u32 secid;
@@ -790,7 +794,7 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
  *
  * For permission return 0, otherwise return -EACCES.
  */
-int ima_load_data(enum kernel_load_data_id id, bool contents)
+static int ima_load_data(enum kernel_load_data_id id, bool contents)
 {
 	bool ima_enforce, sig_enforce;
 
@@ -844,9 +848,9 @@ int ima_load_data(enum kernel_load_data_id id, bool contents)
  * On success return 0.  On integrity appraisal error, assuming the file
  * is in policy and IMA-appraisal is in enforcing mode, return -EACCES.
  */
-int ima_post_load_data(char *buf, loff_t size,
-		       enum kernel_load_data_id load_id,
-		       char *description)
+static int ima_post_load_data(char *buf, loff_t size,
+			      enum kernel_load_data_id load_id,
+			      char *description)
 {
 	if (load_id == LOADING_FIRMWARE) {
 		if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
@@ -1077,6 +1081,18 @@ static int __init init_ima(void)
 
 late_initcall(init_ima);	/* Start IMA after the TPM is available */
 
+static struct security_hook_list ima_hooks[] __lsm_ro_after_init = {
+	LSM_HOOK_INIT(bprm_check_security, ima_bprm_check),
+	LSM_HOOK_INIT(mmap_file, ima_file_mmap),
+	LSM_HOOK_INIT(file_mprotect, ima_file_mprotect),
+	LSM_HOOK_INIT(kernel_read_file, ima_read_file),
+	LSM_HOOK_INIT(kernel_post_read_file, ima_post_read_file),
+	LSM_HOOK_INIT(kernel_load_data, ima_load_data),
+	LSM_HOOK_INIT(kernel_post_load_data, ima_post_load_data),
+};
+
 void __init integrity_lsm_ima_init(void)
 {
+	pr_info("Integrity LSM enabling IMA\n");
+	integrity_add_lsm_hooks(ima_hooks, ARRAY_SIZE(ima_hooks));
 }
diff --git a/security/security.c b/security/security.c
index 14d30fec8a00..8f7c1b5fa5fa 100644
--- a/security/security.c
+++ b/security/security.c
@@ -862,12 +862,7 @@ int security_bprm_creds_from_file(struct linux_binprm *bprm, struct file *file)
 
 int security_bprm_check(struct linux_binprm *bprm)
 {
-	int ret;
-
-	ret = call_int_hook(bprm_check_security, 0, bprm);
-	if (ret)
-		return ret;
-	return ima_bprm_check(bprm);
+	return call_int_hook(bprm_check_security, 0, bprm);
 }
 
 void security_bprm_committing_creds(struct linux_binprm *bprm)
@@ -1589,12 +1584,8 @@ static inline unsigned long mmap_prot(struct file *file, unsigned long prot)
 int security_mmap_file(struct file *file, unsigned long prot,
 			unsigned long flags)
 {
-	int ret;
-	ret = call_int_hook(mmap_file, 0, file, prot,
-					mmap_prot(file, prot), flags);
-	if (ret)
-		return ret;
-	return ima_file_mmap(file, prot);
+	return call_int_hook(mmap_file, 0, file, prot,
+			     mmap_prot(file, prot), flags);
 }
 
 int security_mmap_addr(unsigned long addr)
@@ -1605,12 +1596,7 @@ int security_mmap_addr(unsigned long addr)
 int security_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
 			    unsigned long prot)
 {
-	int ret;
-
-	ret = call_int_hook(file_mprotect, 0, vma, reqprot, prot);
-	if (ret)
-		return ret;
-	return ima_file_mprotect(vma, prot);
+	return call_int_hook(file_mprotect, 0, vma, reqprot, prot);
 }
 
 int security_file_lock(struct file *file, unsigned int cmd)
@@ -1746,35 +1732,20 @@ int security_kernel_module_request(char *kmod_name)
 int security_kernel_read_file(struct file *file, enum kernel_read_file_id id,
 			      bool contents)
 {
-	int ret;
-
-	ret = call_int_hook(kernel_read_file, 0, file, id, contents);
-	if (ret)
-		return ret;
-	return ima_read_file(file, id, contents);
+	return call_int_hook(kernel_read_file, 0, file, id, contents);
 }
 EXPORT_SYMBOL_GPL(security_kernel_read_file);
 
 int security_kernel_post_read_file(struct file *file, char *buf, loff_t size,
 				   enum kernel_read_file_id id)
 {
-	int ret;
-
-	ret = call_int_hook(kernel_post_read_file, 0, file, buf, size, id);
-	if (ret)
-		return ret;
-	return ima_post_read_file(file, buf, size, id);
+	return call_int_hook(kernel_post_read_file, 0, file, buf, size, id);
 }
 EXPORT_SYMBOL_GPL(security_kernel_post_read_file);
 
 int security_kernel_load_data(enum kernel_load_data_id id, bool contents)
 {
-	int ret;
-
-	ret = call_int_hook(kernel_load_data, 0, id, contents);
-	if (ret)
-		return ret;
-	return ima_load_data(id, contents);
+	return call_int_hook(kernel_load_data, 0, id, contents);
 }
 EXPORT_SYMBOL_GPL(security_kernel_load_data);
 
@@ -1782,13 +1753,8 @@ int security_kernel_post_load_data(char *buf, loff_t size,
 				   enum kernel_load_data_id id,
 				   char *description)
 {
-	int ret;
-
-	ret = call_int_hook(kernel_post_load_data, 0, buf, size, id,
-			    description);
-	if (ret)
-		return ret;
-	return ima_post_load_data(buf, size, id, description);
+	return call_int_hook(kernel_post_load_data, 0, buf, size, id,
+			     description);
 }
 EXPORT_SYMBOL_GPL(security_kernel_post_load_data);
 
-- 
2.34.1


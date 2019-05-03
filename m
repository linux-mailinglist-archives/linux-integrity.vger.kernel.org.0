Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C97E91357D
	for <lists+linux-integrity@lfdr.de>; Sat,  4 May 2019 00:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfECWZg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 3 May 2019 18:25:36 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44226 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbfECWZf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 May 2019 18:25:35 -0400
Received: by mail-pf1-f193.google.com with SMTP id y13so3549099pfm.11;
        Fri, 03 May 2019 15:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IDxzpd/1S+G1CGbrrMAZE/cFBJgmFdFrBdHZz/vYhQI=;
        b=sdjrYTm+dgmdjujB/5PqC8aF79vzR66pBSOWV+lk7u61d0b10MxHuUNJ9Z5wnfGPyz
         67TI4jUNaFD2YWjHR+9/GGGocbDrEiQJbLFJOeEXb4ldkL3c2ybKxVREe9DKO+9883Ya
         9Pfh7cs8ZnReGu2dmoP9P2KLc8yA5tSylhi0/mYulKwP/BrcrnKGKL5Y1vzZ6wzJdedB
         QGNya0X9xxr3nrE5ZxI0mnLPfdmwsDtyssXG6HmcwMUpEh2OLnZ+9xhoLSNQdei05pkU
         BPQ9gDcfm8lUsxkicP2+z94mmzVRpwKpBKFPe3otKKBzz6BKK1fOrKISMZb5lw2EmUab
         2rJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IDxzpd/1S+G1CGbrrMAZE/cFBJgmFdFrBdHZz/vYhQI=;
        b=Iw0zkYqS+NFL3jUO878yEJlBTv5fbWgVmy0VQASnLaUHtCBPcn1AaEDAZfGJ1uWe5v
         kOhfT9SFoM8WDJXYdOblBW/Pl/5FSiEZmLWWLh2S7f4CHQQ/cTNVuomCzapiSak3q/nN
         E18gz3NBH+46L2NNiESWprRL2emgjGUofnvq5h+3OCYN6YX3tZxgZwbvlX9RRoyOcVSF
         PDnk6sQkQFF3o5+LtTP7g+q02ieWyxh0wC9g6f57x7dFhSKbXUcc6YFoTgoO+RSMdyqd
         fP6p3tDB+U9MDTXivJA5YZY2D4jSenn5eSvK9AmUgfxANB9H2G1m5TC0GLLL/+cNghS0
         X2Wg==
X-Gm-Message-State: APjAAAWpIlCZ2zVAiXpFCYLyRdgF2C0I+y6+hLUtugklZWc1kLO9MS28
        Xbh9QuLsFptLPdlsSF2y4q4OyjW66Dw=
X-Google-Smtp-Source: APXvYqyySb3xbHGJMlPDR5N45Ya9GmccZkU6b7QdNuu7IgnkgB/voTWfDTA0r+u/k5lXPHaFH+GAQQ==
X-Received: by 2002:a63:6fc1:: with SMTP id k184mr13969477pgc.239.1556922334434;
        Fri, 03 May 2019 15:25:34 -0700 (PDT)
Received: from prsriva-linux.corp.microsoft.com ([2001:4898:80e8:b:3170:1a6b:a13a:7ff])
        by smtp.gmail.com with ESMTPSA id j22sm4314337pfi.139.2019.05.03.15.25.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 15:25:33 -0700 (PDT)
From:   Prakhar Srivastava <prsriva02@gmail.com>
X-Google-Original-From: Prakhar Srivastava
To:     linux-integrity@vger.kernel.org,
        linux-secuirty-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zohar@linux.ibm.com, ebiederm@xmission.com, vgoyal@redhat.com,
        nayna@linux.ibm.com, nramas@microsoft.com, prsriva@microsoft.com,
        Prakhar Srivastava <prsriva02@gmail.com>
Subject: [PATCH 5/5 v4] removed the LSM hook made available, and renamed the ima_policy to be KEXEC_CMDLINE
Date:   Fri,  3 May 2019 15:25:23 -0700
Message-Id: <20190503222523.6294-6-prsriva02@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190503222523.6294-1-prsriva02@gmail.com>
References: <20190503222523.6294-1-prsriva02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Prakhar Srivastava <prsriva02@gmail.com>

Per suggestions from the community, removed the LSM hook.
and renamed the buffer_check func and policy to kexec_cmdline
[suggested by: Mimi Zohar]
Signed-off-by: Prakhar Srivastava <prsriva02@gmail.com>
---
 Documentation/ABI/testing/ima_policy |  2 +-
 include/linux/ima.h                  |  6 +--
 include/linux/lsm_hooks.h            |  3 --
 include/linux/security.h             |  1 -
 kernel/kexec_core.c                  | 59 +---------------------------
 kernel/kexec_file.c                  | 14 +------
 security/integrity/ima/ima.h         |  2 +-
 security/integrity/ima/ima_api.c     |  2 +-
 security/integrity/ima/ima_main.c    | 11 +++---
 security/integrity/ima/ima_policy.c  |  4 +-
 security/security.c                  |  6 ---
 11 files changed, 15 insertions(+), 95 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index 12cfe3ff2dea..62e7cd687e9c 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -29,7 +29,7 @@ Description:
 		base: 	func:= [BPRM_CHECK][MMAP_CHECK][CREDS_CHECK][FILE_CHECK][MODULE_CHECK]
 				[FIRMWARE_CHECK]
 				[KEXEC_KERNEL_CHECK] [KEXEC_INITRAMFS_CHECK]
-				[BUFFER_CHECK]
+				[KEXEC_CMDLINE]
 			mask:= [[^]MAY_READ] [[^]MAY_WRITE] [[^]MAY_APPEND]
 			       [[^]MAY_EXEC]
 			fsmagic:= hex value
diff --git a/include/linux/ima.h b/include/linux/ima.h
index f0abade74707..2c7a22231008 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -26,8 +26,7 @@ extern int ima_read_file(struct file *file, enum kernel_read_file_id id);
 extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
 			      enum kernel_read_file_id id);
 extern void ima_post_path_mknod(struct dentry *dentry);
-extern void ima_buffer_check(const void *buff, int size,
-				const char *eventname);
+extern void ima_kexec_cmdline(const void *buff, int size);
 
 #ifdef CONFIG_IMA_KEXEC
 extern void ima_add_kexec_buffer(struct kimage *image);
@@ -94,8 +93,7 @@ static inline void ima_post_path_mknod(struct dentry *dentry)
 	return;
 }
 
-static inline void ima_buffer_check(const void *buff, int size,
-		const char *eventname)
+static inline void ima_kexec_cmdline(const void *buff, int size)
 {}
 #endif /* CONFIG_IMA */
 
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index f18562c1eb24..a240a3fc5fc4 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1672,8 +1672,6 @@ union security_list_options {
 	int (*inode_setsecctx)(struct dentry *dentry, void *ctx, u32 ctxlen);
 	int (*inode_getsecctx)(struct inode *inode, void **ctx, u32 *ctxlen);
 
-	int (*buffer_check)(const void *buff, int size, const char *eventname);
-
 #ifdef CONFIG_SECURITY_NETWORK
 	int (*unix_stream_connect)(struct sock *sock, struct sock *other,
 					struct sock *newsk);
@@ -1947,7 +1945,6 @@ struct security_hook_heads {
 	struct hlist_head inode_notifysecctx;
 	struct hlist_head inode_setsecctx;
 	struct hlist_head inode_getsecctx;
-	struct hlist_head buffer_check;
 #ifdef CONFIG_SECURITY_NETWORK
 	struct hlist_head unix_stream_connect;
 	struct hlist_head unix_may_send;
diff --git a/include/linux/security.h b/include/linux/security.h
index 8dece6da0dda..8a129664ba4e 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -388,7 +388,6 @@ void security_inode_invalidate_secctx(struct inode *inode);
 int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
 int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
-void security_buffer_measure(const void *buff, int size, char *eventname);
 #else /* CONFIG_SECURITY */
 
 static inline int call_lsm_notifier(enum lsm_event event, void *data)
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 4667f03d406e..8c0a83980d72 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1212,61 +1212,4 @@ void __weak arch_kexec_protect_crashkres(void)
 {}
 
 void __weak arch_kexec_unprotect_crashkres(void)
-{}
-
-/**
- * kexec_cmdline_prepend_img_name - prepare the buffer with cmdline
- * that needs to be measured
- * @outbuf - out buffer that contains the formated string
- * @kernel_fd - the file identifier for the kerenel image
- * @cmdline_ptr - ptr to the cmdline buffer
- * @cmdline_len - len of the buffer.
- *
- * This generates a buffer in the format Kerenelfilename::cmdline
- *
- * On success return 0.
- * On failure return -EINVAL.
- */
-int kexec_cmdline_prepend_img_name(char **outbuf, int kernel_fd,
-				const char *cmdline_ptr,
-				unsigned long cmdline_len)
-{
-	int ret = -EINVAL;
-	struct fd f = {};
-	int size = 0;
-	char *buf = NULL;
-	char delimiter[] = "::";
-
-	if (!outbuf || !cmdline_ptr)
-		goto out;
-
-	f = fdget(kernel_fd);
-	if (!f.file)
-		goto out;
-
-	size = (f.file->f_path.dentry->d_name.len + cmdline_len - 1+
-			ARRAY_SIZE(delimiter)) - 1;
-
-	buf = kzalloc(size, GFP_KERNEL);
-	if (!buf)
-		goto out;
-
-	memcpy(buf, f.file->f_path.dentry->d_name.name,
-		f.file->f_path.dentry->d_name.len);
-	memcpy(buf + f.file->f_path.dentry->d_name.len,
-		delimiter, ARRAY_SIZE(delimiter) - 1);
-	memcpy(buf + f.file->f_path.dentry->d_name.len +
-		ARRAY_SIZE(delimiter) - 1,
-		cmdline_ptr, cmdline_len - 1);
-
-	*outbuf = buf;
-	ret = size;
-
-	pr_debug("kexec cmdline buff: %s\n", buf);
-
-out:
-	if (f.file)
-		fdput(f);
-
-	return ret;
-}
+{}
\ No newline at end of file
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index d287e139085c..2eb977984537 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -191,8 +191,6 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 	int ret = 0;
 	void *ldata;
 	loff_t size;
-	char *buff_to_measure = NULL;
-	int buff_to_measure_size = 0;
 
 	ret = kernel_read_file_from_fd(kernel_fd, &image->kernel_buf,
 				       &size, INT_MAX, READING_KEXEC_IMAGE);
@@ -244,15 +242,8 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 			goto out;
 		}
 
-		/* IMA measures the cmdline args passed to the next kernel*/
-		buff_to_measure_size =
-			kexec_cmdline_prepend_img_name(&buff_to_measure,
-			kernel_fd, image->cmdline_buf, image->cmdline_buf_len);
-
-		ima_buffer_check(buff_to_measure, buff_to_measure_size,
-					"kexec_cmdline");
-
-
+		/* IMA measures the cmdline args passed to the next kernel */
+		ima_kexec_cmdline(image->cmdline_buf, image->cmdline_buf_len - 1);
 	}
 
 	/* Call arch image load handlers */
@@ -267,7 +258,6 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 out:
 
 	/* In case of error, free up all allocated memory in this function */
-	kfree(buff_to_measure);
 	if (ret)
 		kimage_file_post_load_cleanup(image);
 	return ret;
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index de70df132575..226a26d8de09 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -184,7 +184,7 @@ static inline unsigned long ima_hash_key(u8 *digest)
 	hook(KEXEC_KERNEL_CHECK)	\
 	hook(KEXEC_INITRAMFS_CHECK)	\
 	hook(POLICY_CHECK)		\
-	hook(BUFFER_CHECK)		\
+	hook(KEXEC_CMDLINE)		\
 	hook(MAX_CHECK)
 #define __ima_hook_enumify(ENUM)	ENUM,
 
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index cb3f67b366f1..800d965232e5 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -169,7 +169,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
  *		subj=, obj=, type=, func=, mask=, fsmagic=
  *	subj,obj, and type: are LSM specific.
  *	func: FILE_CHECK | BPRM_CHECK | CREDS_CHECK | MMAP_CHECK | MODULE_CHECK
- *	| BUFFER_CHECK
+ *	| KEXEC_CMDLINE
  *	mask: contains the permission mask
  *	fsmagic: hex value
  *
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 7362952ab273..fc9cef54e37c 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -618,7 +618,7 @@ static int process_buffer_measurement(const void *buff, int size,
 	if (!buff || size ==  0 || !eventname)
 		goto err_out;
 
-	action = ima_get_action(NULL, cred, secid, 0, BUFFER_CHECK, &pcr);
+	action = ima_get_action(NULL, cred, secid, 0, KEXEC_CMDLINE, &pcr);
 	if (!(action & IMA_AUDIT) && !(action & IMA_MEASURE))
 		goto err_out;
 
@@ -672,21 +672,20 @@ static int process_buffer_measurement(const void *buff, int size,
 }
 
 /**
- * ima_buffer_check - based on policy, collect & store buffer measurement
+ * ima_kexec_cmdline - based on policy, collect & store buffer measurement
  * @buf: pointer to buffer
  * @size: size of buffer
- * @eventname: event name identifier
  *
  * Buffers can only be measured, not appraised.  The buffer identifier
  * is used as the measurement list entry name (eg. boot_cmdline).
  */
-void ima_buffer_check(const void *buf, int size, const char *eventname)
+void ima_kexec_cmdline(const void *buf, int size)
 {
 	u32 secid;
 
-	if (buf && size != 0 && eventname) {
+	if (buf && size != 0) {
 		security_task_getsecid(current, &secid);
-		process_buffer_measurement(buf, size, eventname,
+		process_buffer_measurement(buf, size, "Kexec-cmdline",
 				current_cred(), secid);
 	}
 }
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index b12551ed191c..7ae59afbf28f 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -875,8 +875,8 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 				entry->func = KEXEC_INITRAMFS_CHECK;
 			else if (strcmp(args[0].from, "POLICY_CHECK") == 0)
 				entry->func = POLICY_CHECK;
-			else if (strcmp(args[0].from, "BUFFER_CHECK") == 0)
-				entry->func = BUFFER_CHECK;
+			else if (strcmp(args[0].from, "KEXEC_CMDLINE") == 0)
+				entry->func = KEXEC_CMDLINE;
 			else
 				result = -EINVAL;
 			if (!result)
diff --git a/security/security.c b/security/security.c
index 2b575a40470e..23cbb1a295a3 100644
--- a/security/security.c
+++ b/security/security.c
@@ -754,12 +754,6 @@ int security_bprm_check(struct linux_binprm *bprm)
 	return ima_bprm_check(bprm);
 }
 
-void security_buffer_measure(const void *buff, int size, char *eventname)
-{
-	call_void_hook(buffer_check, buff, size, eventname);
-	return ima_buffer_check(buff, size, eventname);
-}
-
 void security_bprm_committing_creds(struct linux_binprm *bprm)
 {
 	call_void_hook(bprm_committing_creds, bprm);
-- 
2.20.1


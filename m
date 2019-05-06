Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B88F14A5B
	for <lists+linux-integrity@lfdr.de>; Mon,  6 May 2019 14:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbfEFMzy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 May 2019 08:55:54 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46636 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfEFMzy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 May 2019 08:55:54 -0400
Received: by mail-lj1-f193.google.com with SMTP id h21so10929277ljk.13
        for <linux-integrity@vger.kernel.org>; Mon, 06 May 2019 05:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WVZae/h56ltSrFnuYUYaGltFRu5r0GXClyBhj0Vyf2A=;
        b=a9Hxzazkeb73gYS2t4C4Bxo4AzKhmq4b+pvjt+VWVDpy8fEdikynH+kcRGNk+Z7mwC
         N24xHEXRmO4JWkSPJplqW1RiWb6ZDTfXmxr6oKzWNH3kXbWLyOtnQg5bfG8x69bl6sE5
         Ke/3CubVvXEbG4MMZNesEFsnv9jSNiJGNFZlAJSNkMk4orbSuz8SR7uaTj5YNn/fjB6L
         ve0/w0AvkwC3yS9U1Sn02+frguvF9KtONrMqFOcxWEdpMTkKDJmrBl4QnAZmAyp2KTDJ
         lc/eiL57dBk7qVMeCLIJ0xhDBhAi846vl5mLyu8u8Ym7blw1UmkWEPOCHGPgVBISiHTn
         HIEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WVZae/h56ltSrFnuYUYaGltFRu5r0GXClyBhj0Vyf2A=;
        b=QLS9oVnAFpraJ2CxBl6gvXECmDBS31HWr72lHH/tuy/3/07NonvmkUcs/LZU66jbHE
         +h/v/okisQtdiC1dvgYa+7m1bcov/Z1YhijPmjXmz6n/QYi344TcEMX56LS2QV4MNszN
         Pmx+2cvEcfe0G/jS+7mjSOOUR0suPZ5qbuqhAfskJnnnVNlDBEes9Sb2ZZv4ECGd3OOP
         ZpgDzV4xyX84klthy+X9y6YcJCB33S8ff/CDlcuD9DIi5BlLaB88Qg0mmteCnBCk5cgN
         Vp+jVas1lWvhGcvLznsbEIEMbETbOBPsAGoU6LubhuyZz/QbBUJE7iVe9U2CcAFuPyAT
         0Qcg==
X-Gm-Message-State: APjAAAXRJIRykWRkYF+FPw1RXeLQ1pNNAEPZQMToiecTMEu8i9XQGtuC
        l+UcPhUa98Cku+guLQIGJ1CE99CT
X-Google-Smtp-Source: APXvYqwu331s/KIwDbUJfq4HX4KPBRYgc4ZKGNVw3UQHQxthEFGDDw293rbK7UlkEO/11jGtkw7VqA==
X-Received: by 2002:a2e:9e9a:: with SMTP id f26mr11868527ljk.170.1557147351097;
        Mon, 06 May 2019 05:55:51 -0700 (PDT)
Received: from localhost.localdomain (mobile-user-2e84ba-4.dhcp.inet.fi. [46.132.186.4])
        by smtp.gmail.com with ESMTPSA id y3sm2335238lfh.12.2019.05.06.05.55.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 05:55:50 -0700 (PDT)
From:   Janne Karhunen <janne.karhunen@gmail.com>
To:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        konsta.karsisto@gmail.com
Cc:     Janne Karhunen <Janne.Karhunen@gmail.com>,
        Janne Karhunen <janne.karhunen@gmail.com>
Subject: [PATCH] integrity: keep the integrity state of open files up to date
Date:   Mon,  6 May 2019 15:53:41 +0300
Message-Id: <20190506125341.5872-1-janne.karhunen@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Janne Karhunen <Janne.Karhunen@gmail.com>

When a file is open for writing, kernel crash or power outage
is guaranteed to corrupt the inode integrity state leading to
file appraisal failure on the subsequent boot. Add some basic
infrastructure to keep the integrity measurements up to date as
the files are written to.

Core file operations (open, close, sync, msync, truncate)
update the measurement immediately. In order to maintain
sufficient write performance for writes, add a latency tunable
delayed work workqueue for computing the re-measurements.

Signed-off-by: Janne Karhunen <janne.karhunen@gmail.com>
Signed-off-by: Konsta Karsisto <konsta.karsisto@gmail.com>
---
 fs/namei.c                            |   7 +-
 fs/open.c                             |   4 +
 fs/read_write.c                       |  13 ++-
 fs/sync.c                             |   4 +
 include/linux/ima.h                   |   2 +
 mm/msync.c                            |   9 +++
 security/integrity/ima/Kconfig        |  20 +++++
 security/integrity/ima/ima_appraise.c |   6 +-
 security/integrity/ima/ima_main.c     | 111 +++++++++++++++++++++++++-
 security/integrity/integrity.h        |   6 ++
 10 files changed, 177 insertions(+), 5 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index dede0147b3f6..1fd952621e3c 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3418,8 +3418,13 @@ static int do_last(struct nameidata *nd,
 		goto out;
 opened:
 	error = ima_file_check(file, op->acc_mode);
-	if (!error && will_truncate)
+	if (!error && will_truncate) {
 		error = handle_truncate(file);
+#ifdef CONFIG_IMA
+		if (!error)
+			ima_file_update(file);
+#endif
+	}
 out:
 	if (unlikely(error > 0)) {
 		WARN_ON(1);
diff --git a/fs/open.c b/fs/open.c
index a00350018a47..2af83780e737 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -62,6 +62,10 @@ int do_truncate(struct dentry *dentry, loff_t length, unsigned int time_attrs,
 	/* Note any delegations or leases have already been broken: */
 	ret = notify_change(dentry, &newattrs, NULL);
 	inode_unlock(dentry->d_inode);
+
+#ifdef CONFIG_IMA
+	ima_file_update(filp);
+#endif
 	return ret;
 }
 
diff --git a/fs/read_write.c b/fs/read_write.c
index 61b43ad7608e..a6b16f666797 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -20,6 +20,7 @@
 #include <linux/compat.h>
 #include <linux/mount.h>
 #include <linux/fs.h>
+#include <linux/ima.h>
 #include "internal.h"
 
 #include <linux/uaccess.h>
@@ -481,12 +482,20 @@ static ssize_t new_sync_write(struct file *filp, const char __user *buf, size_t
 static ssize_t __vfs_write(struct file *file, const char __user *p,
 			   size_t count, loff_t *pos)
 {
+	ssize_t sz;
+
 	if (file->f_op->write)
-		return file->f_op->write(file, p, count, pos);
+		sz = file->f_op->write(file, p, count, pos);
 	else if (file->f_op->write_iter)
-		return new_sync_write(file, p, count, pos);
+		sz = new_sync_write(file, p, count, pos);
 	else
 		return -EINVAL;
+
+#ifdef CONFIG_IMA
+	if (sz >= 1)
+		ima_delayed_update(file);
+#endif
+	return sz;
 }
 
 ssize_t __kernel_write(struct file *file, const void *buf, size_t count, loff_t *pos)
diff --git a/fs/sync.c b/fs/sync.c
index b54e0541ad89..f02ae9e8e9da 100644
--- a/fs/sync.c
+++ b/fs/sync.c
@@ -16,6 +16,7 @@
 #include <linux/pagemap.h>
 #include <linux/quotaops.h>
 #include <linux/backing-dev.h>
+#include <linux/ima.h>
 #include "internal.h"
 
 #define VALID_FLAGS (SYNC_FILE_RANGE_WAIT_BEFORE|SYNC_FILE_RANGE_WRITE| \
@@ -194,6 +195,9 @@ int vfs_fsync_range(struct file *file, loff_t start, loff_t end, int datasync)
 		return -EINVAL;
 	if (!datasync && (inode->i_state & I_DIRTY_TIME))
 		mark_inode_dirty_sync(inode);
+#ifdef CONFIG_IMA
+	ima_file_update(file);
+#endif
 	return file->f_op->fsync(file, start, end, datasync);
 }
 EXPORT_SYMBOL(vfs_fsync_range);
diff --git a/include/linux/ima.h b/include/linux/ima.h
index dc12fbcf484c..796147dbde37 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -20,6 +20,8 @@ extern int ima_bprm_check(struct linux_binprm *bprm);
 extern int ima_file_check(struct file *file, int mask);
 extern void ima_post_create_tmpfile(struct inode *inode);
 extern void ima_file_free(struct file *file);
+extern void ima_file_update(struct file *file);
+extern void ima_delayed_update(struct file *file);
 extern int ima_file_mmap(struct file *file, unsigned long prot);
 extern int ima_load_data(enum kernel_load_data_id id);
 extern int ima_read_file(struct file *file, enum kernel_read_file_id id);
diff --git a/mm/msync.c b/mm/msync.c
index ef30a429623a..9b76260258ea 100644
--- a/mm/msync.c
+++ b/mm/msync.c
@@ -14,6 +14,7 @@
 #include <linux/file.h>
 #include <linux/syscalls.h>
 #include <linux/sched.h>
+#include <linux/ima.h>
 
 /*
  * MS_SYNC syncs the entire file - including mappings.
@@ -88,12 +89,20 @@ SYSCALL_DEFINE3(msync, unsigned long, start, size_t, len, int, flags)
 			get_file(file);
 			up_read(&mm->mmap_sem);
 			error = vfs_fsync_range(file, fstart, fend, 1);
+#ifdef CONFIG_IMA
+			if (!error)
+				ima_file_update(file);
+#endif
 			fput(file);
 			if (error || start >= end)
 				goto out;
 			down_read(&mm->mmap_sem);
 			vma = find_vma(mm, start);
 		} else {
+#ifdef CONFIG_IMA
+			if (file)
+				ima_delayed_update(file);
+#endif
 			if (start >= end) {
 				error = 0;
 				goto out_unlock;
diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index a18f8c6d13b5..a2588d72cbc1 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -295,3 +295,23 @@ config IMA_APPRAISE_SIGNED_INIT
 	default n
 	help
 	   This option requires user-space init to be signed.
+
+config IMA_HASH_LATENCY
+	int
+	depends on IMA_APPRAISE
+	range 0 60000
+        default 50
+	help
+	   This value defines the re-measurement interval when files are
+	   being written. Value is in milliseconds.
+
+config IMA_HASH_LATENCY_CEILING
+	int
+	depends on IMA_APPRAISE
+	range 100 60000
+	default 30000
+	help
+	   In order to maintain high write performance for large files,
+	   IMA increases the re-measurement rate as the file size grows.
+	   This value defines the ceiling for the re-measurement delay
+	   in milliseconds.
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 5fb7127bbe68..9558ae0cc462 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -234,10 +234,14 @@ int ima_appraise_measurement(enum ima_hooks func,
 		status = INTEGRITY_NOLABEL;
 		if (file->f_mode & FMODE_CREATED)
 			iint->flags |= IMA_NEW_FILE;
+
 		if ((iint->flags & IMA_NEW_FILE) &&
 		    (!(iint->flags & IMA_DIGSIG_REQUIRED) ||
-		     (inode->i_size == 0)))
+		     (inode->i_size == 0))) {
+			ima_fix_xattr(dentry, iint);
+			xattr_len = ima_read_xattr(dentry, &xattr_value);
 			status = INTEGRITY_PASS;
+		}
 		goto out;
 	}
 
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 357edd140c09..98c7232753dc 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -16,7 +16,7 @@
  *
  * File: ima_main.c
  *	implements the IMA hooks: ima_bprm_check, ima_file_mmap,
- *	and ima_file_check.
+ *	ima_delayed_update, ima_file_update and ima_file_check.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -30,6 +30,8 @@
 #include <linux/xattr.h>
 #include <linux/ima.h>
 #include <linux/iversion.h>
+#include <linux/workqueue.h>
+#include <linux/sizes.h>
 #include <linux/fs.h>
 
 #include "ima.h"
@@ -40,8 +42,15 @@ int ima_appraise = IMA_APPRAISE_ENFORCE;
 int ima_appraise;
 #endif
 
+#if CONFIG_IMA_HASH_LATENCY == 0
+#define IMA_LATENCY_INCREMENT 100
+#else
+#define IMA_LATENCY_INCREMENT CONFIG_IMA_HASH_LATENCY
+#endif
+
 int ima_hash_algo = HASH_ALGO_SHA1;
 static int hash_setup_done;
+static struct workqueue_struct *ima_update_wq;
 
 static int __init hash_setup(char *str)
 {
@@ -127,10 +136,19 @@ static void ima_check_last_writer(struct integrity_iint_cache *iint,
 {
 	fmode_t mode = file->f_mode;
 	bool update;
+	bool creq;
 
 	if (!(mode & FMODE_WRITE))
 		return;
 
+	if (iint->ima_work.file) {
+		creq = cancel_delayed_work(&iint->ima_work.work);
+		if (creq == true) {
+			fput(iint->ima_work.file);
+			iint->ima_work.file = NULL;
+		}
+	}
+
 	mutex_lock(&iint->mutex);
 	if (atomic_read(&inode->i_writecount) == 1) {
 		update = test_and_clear_bit(IMA_UPDATE_XATTR,
@@ -322,6 +340,17 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	return 0;
 }
 
+static void ima_delayed_update_handler(struct work_struct *work)
+{
+	struct ima_work_entry *entry;
+
+	entry = container_of(work, typeof(*entry), work.work);
+
+	ima_file_update(entry->file);
+	fput(entry->file);
+	entry->file = NULL;
+}
+
 /**
  * ima_file_mmap - based on policy, collect/store measurement.
  * @file: pointer to the file to be measured (May be NULL)
@@ -375,6 +404,78 @@ int ima_bprm_check(struct linux_binprm *bprm)
 				   MAY_EXEC, CREDS_CHECK);
 }
 
+/**
+ * ima_delayed_update - add a file to delayed update list
+ * @file: pointer to file structure being updated
+ */
+void ima_delayed_update(struct file *file)
+{
+	struct inode *inode = file_inode(file);
+	struct integrity_iint_cache *iint;
+	unsigned long blocks;
+	unsigned long msecs;
+	bool creq;
+
+	iint = integrity_iint_find(inode);
+	if (!iint)
+		return;
+
+	if (iint->ima_work.file)
+		return;
+
+	/* Slow down the samping rate per the file size */
+	blocks = inode->i_size / SZ_1M + 1;
+	msecs = blocks * IMA_LATENCY_INCREMENT;
+	if (msecs > CONFIG_IMA_HASH_LATENCY_CEILING)
+		msecs = CONFIG_IMA_HASH_LATENCY_CEILING;
+
+	get_file(file);
+	iint->ima_work.file = file;
+	INIT_DELAYED_WORK(&iint->ima_work.work, ima_delayed_update_handler);
+
+	creq = queue_delayed_work(ima_update_wq,
+				  &iint->ima_work.work,
+				  msecs_to_jiffies(msecs));
+	if (creq == false) {
+		iint->ima_work.file = NULL;
+		fput(file);
+	}
+}
+EXPORT_SYMBOL_GPL(ima_delayed_update);
+
+/**
+ * ima_file_update - update the file measurement
+ * @file: pointer to file structure being updated
+ */
+void ima_file_update(struct file *file)
+{
+	struct inode *inode = file_inode(file);
+	struct integrity_iint_cache *iint;
+	bool should_measure = true;
+	u64 i_version;
+
+	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
+		return;
+
+	iint = integrity_iint_find(inode);
+	if (!iint)
+		return;
+
+	mutex_lock(&iint->mutex);
+	clear_bit(IMA_UPDATE_XATTR, &iint->atomic_flags);
+	if (IS_I_VERSION(inode)) {
+		i_version = inode_query_iversion(inode);
+		if (i_version == iint->version)
+			should_measure = false;
+	}
+	if (should_measure) {
+		iint->flags &= ~IMA_COLLECTED;
+		ima_update_xattr(iint, file);
+	}
+	mutex_unlock(&iint->mutex);
+}
+EXPORT_SYMBOL_GPL(ima_file_update);
+
 /**
  * ima_path_check - based on policy, collect/store measurement.
  * @file: pointer to the file to be measured
@@ -580,6 +681,12 @@ static int __init init_ima(void)
 {
 	int error;
 
+	ima_update_wq = alloc_workqueue("ima-update-wq",
+					WQ_MEM_RECLAIM | WQ_CPU_INTENSIVE,
+					0);
+	if (!ima_update_wq)
+		return -ENOMEM;
+
 	ima_init_template_list();
 	hash_setup(CONFIG_IMA_DEFAULT_HASH);
 	error = ima_init();
@@ -595,6 +702,8 @@ static int __init init_ima(void)
 
 	if (!error)
 		ima_update_policy_flag();
+	else
+		destroy_workqueue(ima_update_wq);
 
 	return error;
 }
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 7de59f44cba3..860c7a475a24 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -113,6 +113,11 @@ struct signature_v2_hdr {
 	uint8_t sig[0];		/* signature payload */
 } __packed;
 
+struct ima_work_entry {
+	struct delayed_work work;
+	struct file *file;
+};
+
 /* integrity data associated with an inode */
 struct integrity_iint_cache {
 	struct rb_node rb_node;	/* rooted in integrity_iint_tree */
@@ -129,6 +134,7 @@ struct integrity_iint_cache {
 	enum integrity_status ima_creds_status:4;
 	enum integrity_status evm_status:4;
 	struct ima_digest_data *ima_hash;
+	struct ima_work_entry ima_work;
 };
 
 /* rbtree tree calls to lookup, insert, delete
-- 
2.17.1


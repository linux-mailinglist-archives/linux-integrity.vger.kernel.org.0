Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09A1E1B675
	for <lists+linux-integrity@lfdr.de>; Mon, 13 May 2019 14:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730009AbfEMMyh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 May 2019 08:54:37 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46273 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727462AbfEMMyg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 May 2019 08:54:36 -0400
Received: by mail-lj1-f195.google.com with SMTP id h21so9081258ljk.13;
        Mon, 13 May 2019 05:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UzjKz/vW2dstXFpDFu7i07LcKQv51GH59FID2+twh4o=;
        b=d3QeS1y68Q5158M0RcnJlY55PLPtKDsCHYX2h+0lrGdGqaMlHJvi+Q4nwGfZYUu5iZ
         YgG4lpE9BXzz5LXmPYpCYLi1yVuCXBGj2Gd4Sk78tI6i9T90IQgBr6s4HdcDd+6/BPQ8
         J/+bRcC5h6vtAiB0T2u+O/ZjWSW45Y0mTQvJI0kA4nYbg7m68HAUj1y6/qr7213tWeaI
         GRHfhpono6CD72Qb58TLCY5NqELT4G8a1DqV5wkbR+Vm40wFCcjpb+qRB8KD2Vv4P3gG
         i+Frk000VXQAWPSTHIVCZiOEPxpQrMgbLG5qBOczLLkDH3Vk2z8Cph6cYX7Ivqq+9wfF
         xrnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UzjKz/vW2dstXFpDFu7i07LcKQv51GH59FID2+twh4o=;
        b=EhgxGVGXCTnKRVOUI/bIC6qpjW7u+NLy9rROwQhmOdTRdhOpnnOowUyA0QkXQYnhmf
         5QpvMwd4AZ3KHybixZzueuzs820EodaDrfRM9tZV9lcvTVgeqgANi2l3MUpqFRLQMkVy
         2PASlWvpnl1BIdZK4dPlUqdtnRQpjgmd4IQ7/lZrh4zKaY0vqkdcgQbzqGaG4PV1XlPD
         QqFVdk9ynEBS4UAXwl0Zy9P5u9cTjWTfHbY5S4mMzrr27zBsr+mRopMmNsfbQD3r5upl
         AqCeR5aaCeqyajb/MPItcUpTVfK8XyPHgd25uYGZLuP62EA1cktjufLYOJpSIhOT0m2+
         WQ6w==
X-Gm-Message-State: APjAAAX6JwOM0JT6YAfyw9ZiQxSQTzIGCaudIOB3Qv+E+Rms3AKts3DF
        j0ZYOsb4uijWb16F+uH0CIe9GhZox94=
X-Google-Smtp-Source: APXvYqzSIU9QtkOK7Xk7MUr0Asq8Hrzv0i79PvneROjR8LJc4+uBNOYawuxsZ10AgPGteOW4Q97SNw==
X-Received: by 2002:a2e:121d:: with SMTP id t29mr5476290lje.29.1557752073701;
        Mon, 13 May 2019 05:54:33 -0700 (PDT)
Received: from localhost.localdomain (mobile-user-2e84ba-11.dhcp.inet.fi. [46.132.186.11])
        by smtp.gmail.com with ESMTPSA id t22sm3202924lje.58.2019.05.13.05.54.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 05:54:33 -0700 (PDT)
From:   Janne Karhunen <janne.karhunen@gmail.com>
To:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, zohar@linux.ibm.com
Cc:     Janne Karhunen <janne.karhunen@gmail.com>,
        Konsta Karsisto <konsta.karsisto@gmail.com>
Subject: [PATCH 1/5] integrity: keep the integrity state of open files up to date
Date:   Mon, 13 May 2019 15:53:50 +0300
Message-Id: <20190513125354.23126-2-janne.karhunen@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513125354.23126-1-janne.karhunen@gmail.com>
References: <20190513125354.23126-1-janne.karhunen@gmail.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

When a file is open for writing, kernel crash or power outage
is guaranteed to corrupt the inode integrity state leading to
file appraisal failure on the subsequent boot. Add some basic
infrastructure to keep the integrity measurements up to date
as the files are written to.

Core file operations (open, close, sync, msync, truncate) are
now allowed to update the measurement immediately. In order
to maintain sufficient write performance for writes, add a
latency tunable delayed work workqueue for computing the
re-measurements.

Signed-off-by: Janne Karhunen <janne.karhunen@gmail.com>
Signed-off-by: Konsta Karsisto <konsta.karsisto@gmail.com>
---
 include/linux/ima.h                   |  12 +++
 security/integrity/ima/Kconfig        |  20 +++++
 security/integrity/ima/ima_appraise.c |   6 +-
 security/integrity/ima/ima_main.c     | 103 +++++++++++++++++++++++++-
 security/integrity/integrity.h        |   6 ++
 5 files changed, 145 insertions(+), 2 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index dc12fbcf484c..c4e83f5c450a 100644
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
@@ -66,6 +68,16 @@ static inline void ima_file_free(struct file *file)
 	return;
 }
 
+static inline void ima_file_update(struct file *file)
+{
+	return;
+}
+
+static inline void ima_delayed_update(struct file *file)
+{
+	return;
+}
+
 static inline int ima_file_mmap(struct file *file, unsigned long prot)
 {
 	return 0;
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
index 357edd140c09..67d41005cd22 100644
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
@@ -127,6 +136,7 @@ static void ima_check_last_writer(struct integrity_iint_cache *iint,
 {
 	fmode_t mode = file->f_mode;
 	bool update;
+	bool creq;
 
 	if (!(mode & FMODE_WRITE))
 		return;
@@ -322,6 +332,17 @@ static int process_measurement(struct file *file, const struct cred *cred,
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
@@ -375,6 +396,78 @@ int ima_bprm_check(struct linux_binprm *bprm)
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
@@ -580,6 +673,12 @@ static int __init init_ima(void)
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
@@ -595,6 +694,8 @@ static int __init init_ima(void)
 
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


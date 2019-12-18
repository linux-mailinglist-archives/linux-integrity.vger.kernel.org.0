Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 325F3124752
	for <lists+linux-integrity@lfdr.de>; Wed, 18 Dec 2019 13:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfLRMyB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 Dec 2019 07:54:01 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37365 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbfLRMyB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 Dec 2019 07:54:01 -0500
Received: by mail-lj1-f193.google.com with SMTP id u17so2014435lja.4
        for <linux-integrity@vger.kernel.org>; Wed, 18 Dec 2019 04:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2SyZi5pNlMkz7YRn2wIGBxUI+rlEq+j22yMG+y7trsM=;
        b=mIU4FH0SrZ7wLesiDeVWDF/y1YCxbJL0Pw0vInFPVi7vnqM7DBNd0VR05eCFX9SJ/w
         dZFrK0z8EqRxqrymeE1yw1K6Zo5H7h1yRCFywJqHlYt1eRdDvc32L+5Y5JFh/F0wbQAC
         NbAEY/f6qBcUNLj6QaEqxJk5oKKQT9yTBiWWEAeJhp1vIxwQicEbhTkg839FM+KCHkM+
         R7Vpj9E/IqAIk/KVP9frqQ9epiy/NyUEawMZ3opj75l6DNcmHAOI9P/DUsVbUrbUYGWr
         DsrLTAefwukYwTVb9eAU+vLSpWr8Tt+iL2DPqcn7QmJg3nYioc09jH9sMSTKCicfUvmc
         lhUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2SyZi5pNlMkz7YRn2wIGBxUI+rlEq+j22yMG+y7trsM=;
        b=qDGpGAB4m9z2sSpBy9QpVYIbSaEmSspm28Lhr6ynsHNIVC+plVlG3PX0CBEZX6t3zh
         PBcDyGFDG435vdM791SddmRBE9SkJA8Dk2yp3i6GdxlGHttxoMU9eBKcH8Ay1MSJw/h+
         IFvCLDo0acCCtgpDzcyZHuWoBvET5yR+SAC1AnfzZE52ND+LpjFO9EevfrEUlxvL3hcO
         bylxTpwRoCmXnuNqyO/qxydFow6uzpzDUao2W3HgIlA4FWlVC2dIA59yp0OV2tEnquEc
         WM7RZJYEnZO6t3XUxzNj008dqvgMm1wGu5ldI/4h7n3My//RRBnrT4A+NHSL5uSeViPp
         bMJg==
X-Gm-Message-State: APjAAAWZF3DVxOOZHRUdr/w0A7zvVGGZBmpsSYDDPB3Uoia4UWMuLRSz
        Kt70HrasELgflLMqZtfTcpOsfS91
X-Google-Smtp-Source: APXvYqzMNxMqavGRD34eaGs0eQy7VwcsxV895TAqVfgQek/kNmYMORFv4Ty4FjzDweSSU4WVbiuu9Q==
X-Received: by 2002:a05:651c:119b:: with SMTP id w27mr1650752ljo.242.1576673638308;
        Wed, 18 Dec 2019 04:53:58 -0800 (PST)
Received: from localhost.localdomain (mobile-user-c1d2e7-242.dhcp.inet.fi. [193.210.231.242])
        by smtp.gmail.com with ESMTPSA id u20sm1120965lju.34.2019.12.18.04.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 04:53:57 -0800 (PST)
From:   Janne Karhunen <janne.karhunen@gmail.com>
To:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com
Cc:     kgold@linux.ibm.com, david.safford@gmail.com, monty.wiseman@ge.com,
        Janne Karhunen <janne.karhunen@gmail.com>
Subject: [RFC] ima: export the measurement list when needed
Date:   Wed, 18 Dec 2019 14:53:42 +0200
Message-Id: <20191218125342.15957-1-janne.karhunen@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Some systems can end up carrying lots of entries in the ima
measurement list. Since every entry is using a bit of kernel
memory, add a new Kconfig variable to allow the sysadmin to
define the maximum measurement list size and the location
of the exported list.

The list is written out in append mode, so the system will
keep writing new entries as long as it stays running or runs
out of space. File is also automatically truncated on startup.

Signed-off-by: Janne Karhunen <janne.karhunen@gmail.com>
---
 security/integrity/ima/Kconfig     |  10 ++
 security/integrity/ima/ima.h       |   7 +-
 security/integrity/ima/ima_fs.c    | 178 +++++++++++++++++++++++++++++
 security/integrity/ima/ima_queue.c |   2 +-
 4 files changed, 192 insertions(+), 5 deletions(-)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 897bafc59a33..dbfb76c7b347 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -310,3 +310,13 @@ config IMA_APPRAISE_SIGNED_INIT
 	default n
 	help
 	   This option requires user-space init to be signed.
+
+config IMA_MEASUREMENT_LIST_SIZE
+	int
+	depends on IMA
+	default 5000
+	help
+	   This option defines the maximum amount of entries in the
+	   measurement list. Once the limit is reached, the entire
+	   list is exported to a user defined file and the kernel
+	   list is freed.
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 19769bf5f6ab..cc9a8bbb723d 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -151,20 +151,19 @@ int template_desc_init_fields(const char *template_fmt,
 struct ima_template_desc *ima_template_desc_current(void);
 struct ima_template_desc *lookup_template_desc(const char *name);
 bool ima_template_has_modsig(const struct ima_template_desc *ima_template);
+void ima_free_template_entry(struct ima_template_entry *entry);
 int ima_restore_measurement_entry(struct ima_template_entry *entry);
 int ima_restore_measurement_list(loff_t bufsize, void *buf);
 int ima_measurements_show(struct seq_file *m, void *v);
 unsigned long ima_get_binary_runtime_size(void);
 int ima_init_template(void);
 void ima_init_template_list(void);
+int ima_export_list(void);
 int __init ima_init_digests(void);
 int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
 			  void *lsm_data);
 
-/*
- * used to protect h_table and sha_table
- */
-extern spinlock_t ima_queue_lock;
+extern struct mutex ima_extend_list_mutex;
 
 struct ima_h_table {
 	atomic_long_t len;	/* number of stored measurements in the list */
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 2000e8df0301..d938d3921c43 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -22,10 +22,17 @@
 #include <linux/rcupdate.h>
 #include <linux/parser.h>
 #include <linux/vmalloc.h>
+#include <linux/fs_struct.h>
+#include <linux/syscalls.h>
 
 #include "ima.h"
 
+#define secfs_mnt	"/sys/kernel/security"
+#define am_filename	"/integrity/ima/ascii_runtime_measurements"
+
 static DEFINE_MUTEX(ima_write_mutex);
+static DEFINE_MUTEX(ima_list_mutex);
+static char ima_msmt_list_name[255];
 
 bool ima_canonical_fmt;
 static int __init default_canonical_fmt_setup(char *str)
@@ -362,6 +369,7 @@ static struct dentry *ascii_runtime_measurements;
 static struct dentry *runtime_measurements_count;
 static struct dentry *violations;
 static struct dentry *ima_policy;
+static struct dentry *ima_list_name;
 
 enum ima_fs_flags {
 	IMA_FS_BUSY,
@@ -449,6 +457,169 @@ static const struct file_operations ima_measure_policy_ops = {
 	.llseek = generic_file_llseek,
 };
 
+static void ima_free_list(void)
+{
+	struct ima_queue_entry *qe, *e;
+
+	mutex_lock(&ima_extend_list_mutex);
+	list_for_each_entry_safe(qe, e, &ima_measurements, later) {
+		hlist_del_rcu(&qe->hnext);
+		atomic_long_dec(&ima_htable.len);
+
+		list_del_rcu(&qe->later);
+		ima_free_template_entry(qe->entry);
+	}
+	mutex_unlock(&ima_extend_list_mutex);
+}
+
+static int ima_unlink_file(const char *filename)
+{
+	struct filename *file;
+
+	file = getname_kernel(filename);
+	if (IS_ERR(file))
+		return -EINVAL;
+
+	return do_unlinkat(AT_FDCWD, file);
+}
+
+int ima_export_list(void)
+{
+	static bool export_ok = true;
+	static bool init_export = true;
+
+	struct file *file_out = NULL;
+	struct file *file_in = NULL;
+	struct path root;
+	ssize_t bytesin, bytesout;
+	mm_segment_t fs;
+	loff_t offin = 0, offout = 0;
+	char data[512];
+	long htable_len;
+	int err = 0;
+
+	mutex_lock(&ima_list_mutex);
+	htable_len = atomic_long_read(&ima_htable.len);
+	if (htable_len <= CONFIG_IMA_MEASUREMENT_LIST_SIZE)
+		goto out_unlock;
+
+	if (strlen(ima_msmt_list_name) == 0) {
+		err = -ENOENT;
+		goto out_unlock;
+	}
+	if (!export_ok) {
+		err = -EINVAL;
+		goto out_unlock;
+	}
+
+	fs = get_fs();
+	set_fs(KERNEL_DS);
+
+	if (init_export) {
+		pr_info("ima: list size (%ld/%ld) exceeded, exporting to %s\n",
+			htable_len, (long)CONFIG_IMA_MEASUREMENT_LIST_SIZE,
+			ima_msmt_list_name);
+
+		ima_unlink_file(ima_msmt_list_name);
+		init_export = false;
+	}
+	/*
+	 * Use the root of the init task..
+	 */
+	task_lock(&init_task);
+	get_fs_root(init_task.fs, &root);
+	task_unlock(&init_task);
+
+	file_out = file_open_root(root.dentry, root.mnt, ima_msmt_list_name,
+				  O_CREAT|O_WRONLY|O_APPEND|O_NOFOLLOW|O_EXCL,
+				  0400);
+	if (IS_ERR(file_out)) {
+		err = PTR_ERR(file_out);
+		goto out;
+	}
+	file_in = file_open_root(root.dentry, root.mnt, secfs_mnt am_filename,
+				 O_RDONLY, 0);
+	if (IS_ERR(file_in)) {
+		err = PTR_ERR(file_in);
+		goto out;
+	}
+	do {
+		bytesin = vfs_read(file_in, data, 512, &offin);
+		if (bytesin < 0) {
+			pr_err("ima: read error at %lld\n", offin);
+			err = -EIO;
+			goto out;
+		}
+		bytesout = vfs_write(file_out, data, bytesin, &offout);
+		if (bytesout < 0) {
+			pr_err("ima: write error at %lld\n", offout);
+			err = -EIO;
+			goto out;
+		}
+		if (bytesin != bytesout) {
+			/*
+			 * If we fail writing, the recovery is a job for the
+			 * admin. Keep piling things in the memory for now.
+			 */
+			export_ok = false;
+			err = bytesout;
+			goto out;
+		}
+	} while (bytesin == 512);
+	ima_free_list();
+
+out:
+	filp_close(file_in, NULL);
+	filp_close(file_out, NULL);
+
+	path_put(&root);
+	set_fs(fs);
+
+out_unlock:
+	mutex_unlock(&ima_list_mutex);
+	return err;
+}
+
+static ssize_t ima_write_list_name(struct file *filp,
+				   const char __user *buf,
+				   size_t count, loff_t *ppos)
+{
+	int err, len;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if ((count <= 1) || (count >= 255))
+		return -EINVAL;
+
+	if (*buf != '/')
+		return -EINVAL;
+
+	if (*ima_msmt_list_name == '/')
+		goto try_export;
+
+	err = copy_from_user(ima_msmt_list_name, buf, count);
+	if (err) {
+		memset(ima_msmt_list_name, 0, 255);
+		return -EFAULT;
+	}
+	len = strnlen(ima_msmt_list_name, 255);
+	if (ima_msmt_list_name[len-1] == '\n')
+		ima_msmt_list_name[len-1] = 0;
+
+try_export:
+	err = ima_export_list();
+	if (err) {
+		pr_err("ima: list export failed with %d\n", err);
+		return -1;
+	}
+	return count;
+}
+
+static const struct file_operations ima_list_export_ops = {
+	.write = ima_write_list_name,
+};
+
 int __init ima_fs_init(void)
 {
 	ima_dir = securityfs_create_dir("ima", integrity_dir);
@@ -493,6 +664,11 @@ int __init ima_fs_init(void)
 	if (IS_ERR(ima_policy))
 		goto out;
 
+	ima_list_name = securityfs_create_file("list_name", 0600, ima_dir,
+					       NULL, &ima_list_export_ops);
+	if (IS_ERR(ima_list_name))
+		goto out;
+
 	return 0;
 out:
 	securityfs_remove(violations);
@@ -502,5 +678,7 @@ int __init ima_fs_init(void)
 	securityfs_remove(ima_symlink);
 	securityfs_remove(ima_dir);
 	securityfs_remove(ima_policy);
+	securityfs_remove(ima_list_name);
+
 	return -1;
 }
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 1ce8b1701566..77c538ec8474 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -44,7 +44,7 @@ struct ima_h_table ima_htable = {
  * and extending the TPM PCR aggregate. Since tpm_extend can take
  * long (and the tpm driver uses a mutex), we can't use the spinlock.
  */
-static DEFINE_MUTEX(ima_extend_list_mutex);
+DEFINE_MUTEX(ima_extend_list_mutex);
 
 /* lookup up the digest value in the hash table, and return the entry */
 static struct ima_queue_entry *ima_lookup_digest_entry(u8 *digest_value,
-- 
2.17.1


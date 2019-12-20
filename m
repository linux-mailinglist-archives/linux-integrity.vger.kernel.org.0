Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 201471276C0
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Dec 2019 08:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbfLTHt7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 Dec 2019 02:49:59 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40249 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfLTHt7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Dec 2019 02:49:59 -0500
Received: by mail-lj1-f196.google.com with SMTP id u1so9001631ljk.7
        for <linux-integrity@vger.kernel.org>; Thu, 19 Dec 2019 23:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xC7buNP0bEw8BFo7/cK9VuE6trQQ0tu1ZWSeGUWJJNM=;
        b=mpzIMKQrK6elIC8kRuPDCeVTTb/GUd4k5EceoNgn97RcGT7NouBE226slI0C7amG77
         +dgbuSpzADH8/Lxy32+qdAQPd1b9LHj0tABwCvbhjaEUJgpLA940Vr02els6e6LTMogu
         c+zrzFM01kPmQSL4Y2PG+eWZ6oeC+1rpmGZ6tKBk1JKPITcXYKb/S+quE2Sqwutww9gb
         aX8AR3ZU7g/9cF+jQuqwBvoWlMYt9oEVHUIBH9Vz0uT4qTQK97LsS7Z0cGcGKbS3dhNI
         kK7l4k/4KZVziXRVzJeqHJZja4kf3v9IgZr+sSGMP6L7TAKubqRxLC9rHMC1yvAZhuC3
         d/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xC7buNP0bEw8BFo7/cK9VuE6trQQ0tu1ZWSeGUWJJNM=;
        b=IjiHAVg8WsdC6hiJlaDbivYTMO7IsNOddt1owd+Q4JBZxJr9PEVm2uc6V0DcrAWASH
         PJff9BNrpxTz5OZpLPKlkYk0V9L47oCNmGOXSRSLNnNV+W35NKi+a+Epq7RCekGfutld
         iwqnUNizI3iT1hVcTcHGlrvFco/f8K9XWYK3oo9tyVd6NDUH6v+IB0cI5YdkyMGdgcV2
         b2A7V26ecForA9bL6hLSB9VjW2cNokOI96nkq1If+ddBBQa+CuA/SGYjKalavjNDCrLN
         NPaK/ljc12edrVTGEWYnfR8bACEmKZRKMFvpPyBiXrDRupXjv5ubHig5PjiyFk/g4HIk
         uqyw==
X-Gm-Message-State: APjAAAVIRzWlTFi20sRnXj9wc+VvKc5PoOyEpT9LUQeI/YRnVCahuyej
        vDWbKKV90Ur1phgv5cuhkPv97yUR
X-Google-Smtp-Source: APXvYqwmkSO7k8A2BtbqX0TIyI25PG1LMQMGlCJHxW31Xpp6vTuUljqiNHxX5H+T5jPcwAr/xYK8HA==
X-Received: by 2002:a2e:8551:: with SMTP id u17mr3908688ljj.165.1576828196358;
        Thu, 19 Dec 2019 23:49:56 -0800 (PST)
Received: from localhost.localdomain (mobile-user-c1d2e7-242.dhcp.inet.fi. [193.210.231.242])
        by smtp.gmail.com with ESMTPSA id p4sm3935428lji.107.2019.12.19.23.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 23:49:55 -0800 (PST)
From:   Janne Karhunen <janne.karhunen@gmail.com>
To:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com
Cc:     kgold@linux.ibm.com, david.safford@gmail.com, monty.wiseman@ge.com,
        Janne Karhunen <janne.karhunen@gmail.com>
Subject: [PATCH v1 - RFC] ima: export the measurement list when needed
Date:   Fri, 20 Dec 2019 09:49:29 +0200
Message-Id: <20191220074929.8191-1-janne.karhunen@gmail.com>
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
 security/integrity/ima/ima_fs.c    | 188 +++++++++++++++++++++++++++++
 security/integrity/ima/ima_queue.c |   2 +-
 4 files changed, 202 insertions(+), 5 deletions(-)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 897bafc59a33..3aefead28864 100644
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
+	default 2000
+	help
+	   This option defines the maximum amount of entries in the
+	   measurement list. Once the limit is reached, the entire
+	   list is exported to a user defined file and the kernel
+	   list is freed.
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 19769bf5f6ab..78f0b706848d 100644
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
+int ima_export_list(const char *from);
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
index 2000e8df0301..ad7daf7d2fbb 100644
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
+static char *ima_msmt_list_name;
 
 bool ima_canonical_fmt;
 static int __init default_canonical_fmt_setup(char *str)
@@ -362,6 +369,7 @@ static struct dentry *ascii_runtime_measurements;
 static struct dentry *runtime_measurements_count;
 static struct dentry *violations;
 static struct dentry *ima_policy;
+static struct dentry *ima_list_name;
 
 enum ima_fs_flags {
 	IMA_FS_BUSY,
@@ -449,6 +457,179 @@ static const struct file_operations ima_measure_policy_ops = {
 	.llseek = generic_file_llseek,
 };
 
+static void ima_free_list(void)
+{
+	struct ima_queue_entry *qe, *e;
+
+	list_for_each_entry_safe(qe, e, &ima_measurements, later) {
+		hlist_del_rcu(&qe->hnext);
+		atomic_long_dec(&ima_htable.len);
+
+		list_del_rcu(&qe->later);
+		ima_free_template_entry(qe->entry);
+		kfree(qe);
+	}
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
+int ima_export_list(const char *from)
+{
+	static bool export_ok = true;
+	static bool init_export = true;
+
+	struct file *file_out = NULL;
+	struct file *file_in = NULL;
+	const char *to = ima_msmt_list_name;
+	ssize_t bytesin, bytesout;
+	mm_segment_t fs;
+	struct path root;
+	loff_t offin = 0, offout = 0;
+	char data[512];
+	long htable_len;
+	int err = 0;
+
+	htable_len = atomic_long_read(&ima_htable.len);
+	if (htable_len <= CONFIG_IMA_MEASUREMENT_LIST_SIZE)
+		goto out_err;
+	if (to == NULL)
+		goto out_err;
+	if (from == NULL)
+		from = secfs_mnt am_filename;
+	if (!export_ok) {
+		err = -EFAULT;
+		goto out_err;
+	}
+
+	pr_info("msmt list size (%ld/%ld) exceeded, exporting to %s\n",
+		htable_len, (long)CONFIG_IMA_MEASUREMENT_LIST_SIZE, to);
+	fs = get_fs();
+	set_fs(KERNEL_DS);
+
+	if (init_export) {
+		ima_unlink_file(to);
+		init_export = false;
+	}
+	/*
+	 * Use the root of the init task..
+	 */
+	task_lock(&init_task);
+	get_fs_root(init_task.fs, &root);
+	task_unlock(&init_task);
+
+	file_out = file_open_root(root.dentry, root.mnt, to,
+				  O_CREAT|O_WRONLY|O_APPEND|O_NOFOLLOW,
+				  0400);
+	if (IS_ERR(file_out)) {
+		err = PTR_ERR(file_out);
+		pr_err("failed to open %s, err %d\n", to, err);
+		file_out = NULL;
+		goto out_close;
+	}
+	file_in = file_open_root(root.dentry, root.mnt, from, O_RDONLY, 0);
+	if (IS_ERR(file_in)) {
+		err = PTR_ERR(file_in);
+		pr_err("failed to open %s, err %d\n", from, err);
+		file_in = NULL;
+		goto out_close;
+	}
+	mutex_lock(&ima_extend_list_mutex);
+	do {
+		bytesin = vfs_read(file_in, data, 512, &offin);
+		if (bytesin < 0) {
+			pr_err("read error at %lld\n", offin);
+			err = -EIO;
+			goto out_unlock;
+		}
+		bytesout = vfs_write(file_out, data, bytesin, &offout);
+		if (bytesout < 0) {
+			pr_err("write error at %lld\n", offout);
+			err = -EIO;
+			goto out_unlock;
+		}
+		if (bytesin != bytesout) {
+			/*
+			 * If we fail writing, the recovery is a job for the
+			 * admin. Keep piling things in the memory for now.
+			 */
+			export_ok = false;
+			err = bytesout;
+			goto out_unlock;
+		}
+	} while (bytesin == 512);
+	ima_free_list();
+
+out_unlock:
+	mutex_unlock(&ima_extend_list_mutex);
+out_close:
+	if (file_in)
+		filp_close(file_in, NULL);
+	if (file_out)
+		filp_close(file_out, NULL);
+
+	path_put(&root);
+	set_fs(fs);
+out_err:
+	return err;
+}
+
+static ssize_t ima_write_list_name(struct file *filp,
+				   const char __user *buf,
+				   size_t count, loff_t *ppos)
+{
+	int err;
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
+	mutex_lock(&ima_list_mutex);
+	if (ima_msmt_list_name)
+		goto try_export;
+
+	ima_msmt_list_name = kzalloc(count, GFP_KERNEL);
+	if (!ima_msmt_list_name) {
+		mutex_unlock(&ima_list_mutex);
+		return -ENOMEM;
+	}
+	err = copy_from_user(ima_msmt_list_name, buf, count);
+	if (err) {
+		kfree(ima_msmt_list_name);
+		ima_msmt_list_name = NULL;
+		mutex_unlock(&ima_list_mutex);
+		return -EFAULT;
+	}
+	if (ima_msmt_list_name[count-1] == '\n')
+		ima_msmt_list_name[count-1] = 0;
+
+try_export:
+	err = ima_export_list(NULL);
+	mutex_unlock(&ima_list_mutex);
+	if (err) {
+		pr_err("list export failed with %d\n", err);
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
@@ -493,6 +674,11 @@ int __init ima_fs_init(void)
 	if (IS_ERR(ima_policy))
 		goto out;
 
+	ima_list_name = securityfs_create_file("list_name", 0200, ima_dir,
+					       NULL, &ima_list_export_ops);
+	if (IS_ERR(ima_list_name))
+		goto out;
+
 	return 0;
 out:
 	securityfs_remove(violations);
@@ -502,5 +688,7 @@ int __init ima_fs_init(void)
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


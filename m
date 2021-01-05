Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8C12EB3C5
	for <lists+linux-integrity@lfdr.de>; Tue,  5 Jan 2021 20:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730931AbhAET6d (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 5 Jan 2021 14:58:33 -0500
Received: from linux.microsoft.com ([13.77.154.182]:42028 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730887AbhAET6c (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 5 Jan 2021 14:58:32 -0500
Received: from rapha-Virtual-Machine.mshome.net (unknown [131.107.160.57])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6FEEB20B7192;
        Tue,  5 Jan 2021 11:57:51 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6FEEB20B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1609876671;
        bh=TkslHbaczP8oeubEpEAetQD431q8kpd0060+1grQUx4=;
        h=From:To:Cc:Subject:Date:From;
        b=LVJb/0iBo9UkborSzSUyk4tiyXbIcFd6KlSw9pfa70mmNK2tV+VeOPwDUIW1EmYW0
         BwzTVUdrVADbSUYRUOMRrt/OVcenUWhhiIUzWhckq4cnvYlLc7Dpe0OGGhyODjM8dv
         b9UrKuVzBNY5Y+Q3uQ0q1SbEo1eqsGVall3XJeqI=
From:   Raphael Gianotti <raphgi@linux.microsoft.com>
To:     zohar@linux.ibm.com, janne.karhunen@gmail.com
Cc:     linux-integrity@vger.kernel.org, tusharsu@linux.microsoft.com,
        tyhicks@linux.microsoft.com, nramas@linux.microsoft.com,
        balajib@linux.microsoft.com
Subject: [RFC] Persist ima logs to disk
Date:   Tue,  5 Jan 2021 11:57:42 -0800
Message-Id: <20210105195742.2629-1-raphgi@linux.microsoft.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

IMA measures files and buffer data and some systems may end up
generating lots of entries in the IMA measurement list. This list is
kept in kernel memoryc and as it grows in size it could end up taking
too many resources, causing the system to run out of available
memory. During kexec, the IMA measurement list can be carried over in
memory, but it's possible for the list to become too large for that
to happen.

The Kconfig introduced in this series enables admins to configure a
maximum number of entries and a file to export the IMA measurement
list to whenever the set limit is reached.

The list is written out in append mode, so the system will keep
writing new entries as long as it stays running or runs out of
space. Whenever the export file is set, it's truncated. If writing
to the export list fails, a flag is set to prevent further exports,
as the file is likely in a bad state. Setting a new export file
resets this flag, allowing exports to resume and giving admins a way
to recover from this state if necessary.

In the case of kexec, if the list is too large too be carried over in
memory and an export file is configured, the list will be exported,
preventing the measurements from being lost during kexec.

This code is based off of a previous RFC sent by Janne Karhunen[1],
and is intended to pick up where that was left off.

In a thread with Janne Karhunen[2], it was mentioned that another
approach, using mm had been considered. Upon some investigation the
approach used in this RFC still seemed adequate for solving this
problem.

[1] https://patchwork.kernel.org/project/linux-integrity/patch/201912
20074929.8191-1-janne.karhunen@gmail.com/
[2] https://lore.kernel.org/linux-integrity/CAE=NcrbdS-3gVvnnEwdNSOLO
vTenLjyppDz2aJACGRgBYSh=Gw@mail.gmail.com/

Signed-off-by: Raphael Gianotti <raphgi@linux.microsoft.com>
---
 security/integrity/ima/Kconfig     |   9 ++
 security/integrity/ima/ima.h       |   7 ++
 security/integrity/ima/ima_api.c   |   1 +
 security/integrity/ima/ima_fs.c    | 194 +++++++++++++++++++++++++++++
 security/integrity/ima/ima_kexec.c |   7 +-
 security/integrity/ima/ima_queue.c |   2 +-
 6 files changed, 217 insertions(+), 3 deletions(-)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 12e9250c1bec..faea01fc1dd1 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -334,3 +334,12 @@ config IMA_SECURE_AND_OR_TRUSTED_BOOT
        help
           This option is selected by architectures to enable secure and/or
           trusted boot based on IMA runtime policies.
+config IMA_MEASUREMENT_ENTRY_COUNT
+	int
+	depends on IMA
+	default 2000
+	help
+	   This option defines the maximum number of entries in the
+	   measurement list. Once the limit is reached, the entire
+	   list is exported to a user defined file and the kernel
+	   list is freed.
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 38043074ce5e..d072943149d8 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -47,6 +47,9 @@ enum tpm_pcrs { TPM_PCR0 = 0, TPM_PCR8 = 8, TPM_PCR10 = 10 };
 
 #define NR_BANKS(chip) ((chip != NULL) ? chip->nr_allocated_banks : 0)
 
+#define secfs_mnt       "/sys/kernel/security"
+#define am_filename     "/integrity/ima/ascii_runtime_measurements"
+
 /* current content of the policy */
 extern int ima_policy_flag;
 
@@ -158,6 +161,7 @@ int template_desc_init_fields(const char *template_fmt,
 struct ima_template_desc *ima_template_desc_current(void);
 struct ima_template_desc *lookup_template_desc(const char *name);
 bool ima_template_has_modsig(const struct ima_template_desc *ima_template);
+void ima_free_template_entry(struct ima_template_entry *entry);
 int ima_restore_measurement_entry(struct ima_template_entry *entry);
 int ima_restore_measurement_list(loff_t bufsize, void *buf);
 int ima_measurements_show(struct seq_file *m, void *v);
@@ -167,12 +171,15 @@ void ima_init_template_list(void);
 int __init ima_init_digests(void);
 int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
 			  void *lsm_data);
+int ima_export_list(const char *sourcefile);
 
 /*
  * used to protect h_table and sha_table
  */
 extern spinlock_t ima_queue_lock;
 
+extern struct mutex ima_extend_list_mutex;
+
 struct ima_h_table {
 	atomic_long_t len;	/* number of stored measurements in the list */
 	atomic_long_t violations;
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 4f39fb93f278..37fbf59547c1 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -120,6 +120,7 @@ int ima_store_template(struct ima_template_entry *entry,
 	}
 	entry->pcr = pcr;
 	result = ima_add_template_entry(entry, violation, op, inode, filename);
+	ima_export_list(NULL);
 	return result;
 }
 
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index e3fcad871861..dd9e2d04e9bc 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -20,10 +20,15 @@
 #include <linux/rcupdate.h>
 #include <linux/parser.h>
 #include <linux/vmalloc.h>
+#include <linux/fs_struct.h>
+#include <linux/syscalls.h>
+#include <../fs/internal.h>
 
 #include "ima.h"
 
 static DEFINE_MUTEX(ima_write_mutex);
+static DEFINE_MUTEX(ima_list_mutex);
+static char *ima_msmt_list_name = NULL;
 
 bool ima_canonical_fmt;
 static int __init default_canonical_fmt_setup(char *str)
@@ -37,6 +42,9 @@ __setup("ima_canonical_fmt", default_canonical_fmt_setup);
 
 static int valid_policy = 1;
 
+static bool init_list_export = true;
+static bool list_export_ok = true;
+
 static ssize_t ima_show_htable_value(char __user *buf, size_t count,
 				     loff_t *ppos, atomic_long_t *val)
 {
@@ -359,6 +367,7 @@ static struct dentry *ascii_runtime_measurements;
 static struct dentry *runtime_measurements_count;
 static struct dentry *violations;
 static struct dentry *ima_policy;
+static struct dentry *ima_list_name;
 
 enum ima_fs_flags {
 	IMA_FS_BUSY,
@@ -446,6 +455,184 @@ static const struct file_operations ima_measure_policy_ops = {
 	.llseek = generic_file_llseek,
 };
 
+/*
+ * (Called with ima_extend_list_mutex held.)
+ */
+static void ima_free_list(void)
+{
+	struct ima_queue_entry *qe, *e;
+
+	list_for_each_entry_safe(qe, e, &ima_measurements, later) {
+		hlist_del_rcu(&qe->hnext);
+		list_del_rcu(&qe->later);
+		ima_free_template_entry(qe->entry);
+		kzfree(qe);
+	}
+	atomic_long_set(&ima_htable.len, 0);
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
+int ima_export_list(const char *sourcefile)
+{
+	struct file *file_out = NULL;
+	struct file *file_in = NULL;
+	const char *targetfile = ima_msmt_list_name;
+	ssize_t bytesin, bytesout;
+	mm_segment_t fs;
+	struct path root;
+	loff_t offin = 0, offout = 0;
+	char data[512];
+	long htable_len;
+	int err = 0;
+
+	htable_len = atomic_long_read(&ima_htable.len);
+	if (CONFIG_IMA_MEASUREMENT_ENTRY_COUNT <= 0)
+		goto out_err;
+	if (sourcefile == NULL && htable_len <= CONFIG_IMA_MEASUREMENT_ENTRY_COUNT)
+		goto out_err;
+	if (targetfile == NULL)
+		goto out_err;
+	if (sourcefile == NULL) {
+		pr_info("msmt list size (%ld/%ld) exceeded, exporting to %s\n",
+                	htable_len, (long)CONFIG_IMA_MEASUREMENT_ENTRY_COUNT, targetfile);
+		sourcefile = secfs_mnt am_filename;
+	}
+	if (!list_export_ok) {
+		err = -EFAULT;
+		goto out_err;
+	}
+
+	fs = get_fs();
+	set_fs(KERNEL_DS);
+
+	if (init_list_export) {
+		ima_unlink_file(targetfile);
+		init_list_export = false;
+	}
+	task_lock(&init_task);
+	get_fs_root(init_task.fs, &root);
+	task_unlock(&init_task);
+
+	file_out = file_open_root(root.dentry, root.mnt, targetfile,
+				  O_CREAT|O_WRONLY|O_APPEND|O_NOFOLLOW,
+				  0400);
+	if (IS_ERR(file_out)) {
+		err = PTR_ERR(file_out);
+		pr_err("failed to open %s, err %d\n", targetfile, err);
+		file_out = NULL;
+		goto out_close;
+	}
+	file_in = file_open_root(root.dentry, root.mnt, sourcefile, O_RDONLY, 0);
+	if (IS_ERR(file_in)) {
+		err = PTR_ERR(file_in);
+		pr_err("failed to open %s, err %d\n", sourcefile, err);
+		file_in = NULL;
+		goto out_close;
+	}
+	mutex_lock(&ima_extend_list_mutex);
+	/*
+	 * if we fail writing, the recovery is a job for the admin.
+	 * Logs will be kept in memory.
+	 */
+	list_export_ok = false;
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
+			err = bytesout;
+			goto out_unlock;
+		}
+	} while (bytesin == 512);
+	list_export_ok = true;
+	ima_free_list();
+
+out_unlock:
+	if (!list_export_ok) {
+		pr_err("failed to export measurement list to %s", targetfile);
+	}
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
+static ssize_t ima_write_list_name(struct file *file,
+				   const char __user *buf,
+				   size_t datalen, loff_t *ppos)
+{
+	int err;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if ((datalen <= 1) || (datalen >= 255))
+		return -EINVAL;
+
+	mutex_lock(&ima_list_mutex);
+	
+	ima_msmt_list_name = memdup_user(buf, datalen);
+
+	if (IS_ERR(ima_msmt_list_name)) {
+		err = PTR_ERR(ima_msmt_list_name);
+		goto out_unlock;
+	}
+
+	if (*ima_msmt_list_name != '/') {
+		kfree(ima_msmt_list_name);
+		ima_msmt_list_name = NULL;
+		err = -EINVAL;
+		goto out_unlock;
+	}
+
+	if (ima_msmt_list_name[datalen-1] != '\0')
+		ima_msmt_list_name[datalen-1] = '\0';
+
+	list_export_ok = true;
+	init_list_export = true;
+	err = ima_export_list(NULL);
+	if (err) {
+		pr_err("list export failed with %d\n", err);
+		goto out_unlock;
+	}
+
+	err = datalen;
+
+out_unlock:
+	mutex_unlock(&ima_list_mutex);
+	return err;
+}
+
+static const struct file_operations ima_list_export_ops = {
+	.write = ima_write_list_name,
+};
+
 int __init ima_fs_init(void)
 {
 	ima_dir = securityfs_create_dir("ima", integrity_dir);
@@ -490,6 +677,11 @@ int __init ima_fs_init(void)
 	if (IS_ERR(ima_policy))
 		goto out;
 
+	ima_list_name = securityfs_create_file("runtime_measurements_export_list_path", S_IWUSR | S_IWGRP, ima_dir,
+					       NULL, &ima_list_export_ops);
+	if (IS_ERR(ima_list_name))
+		goto out;
+
 	return 0;
 out:
 	securityfs_remove(violations);
@@ -499,5 +691,7 @@ int __init ima_fs_init(void)
 	securityfs_remove(ima_symlink);
 	securityfs_remove(ima_dir);
 	securityfs_remove(ima_policy);
+	securityfs_remove(ima_list_name);
+
 	return -1;
 }
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 121de3e04af2..aa4bd4ba07c7 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -102,8 +102,11 @@ void ima_add_kexec_buffer(struct kimage *image)
 					   PAGE_SIZE / 2, PAGE_SIZE);
 	if ((kexec_segment_size == ULONG_MAX) ||
 	    ((kexec_segment_size >> PAGE_SHIFT) > totalram_pages() / 2)) {
-		pr_err("Binary measurement list too large.\n");
-		return;
+		ret = export_ima_list(secfs_mnt am_filename);
+		if (ret) {
+			pr_err("Binary measurement list too large.\n");
+			return;
+		}
 	}
 
 	ima_dump_measurement_list(&kexec_buffer_size, &kexec_buffer,
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index c096ef8945c7..deaea4780359 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -42,7 +42,7 @@ struct ima_h_table ima_htable = {
  * and extending the TPM PCR aggregate. Since tpm_extend can take
  * long (and the tpm driver uses a mutex), we can't use the spinlock.
  */
-static DEFINE_MUTEX(ima_extend_list_mutex);
+DEFINE_MUTEX(ima_extend_list_mutex);
 
 /* lookup up the digest value in the hash table, and return the entry */
 static struct ima_queue_entry *ima_lookup_digest_entry(u8 *digest_value,
-- 
2.28.0


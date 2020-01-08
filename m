Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEB0413402A
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Jan 2020 12:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbgAHLSG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Jan 2020 06:18:06 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45519 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbgAHLSG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Jan 2020 06:18:06 -0500
Received: by mail-lf1-f66.google.com with SMTP id 203so2121153lfa.12;
        Wed, 08 Jan 2020 03:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=hiV8J9VLX3arvGiBJFG2oz/6M+ZQKxm0yyTac9Dd+Wo=;
        b=N+c+lWBYnCMx+WySr7BwJeqBxQQacAOxxCJl0SRy/e2Walk8EQvv9nAUeIvexUsq1x
         j+fn/GAVjl/zaCblEctG0vVKCJeJtEnxjhJd9MnG/DWu+gl9llemTa/8uNxwyQjhLT8o
         jg5MlaChI8v9r5U78wKdDKbgzYRZIu9z8gk2NiZuImMXw4PT1Iy0q/FlwvQxOPIk6UxV
         obegPDxJsCaIgIl5/BYHmZjuBpgUhNK8RjTG1kdNzISsJyc7RKIWa+rB1chK6rLlmVQ7
         uYgvEYpaqscd0hWIV3Y16kV5p7mRsGjkF+SQ2O06N5+PqmCZtRn68+xFbeC+iyg+vX7x
         tatw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hiV8J9VLX3arvGiBJFG2oz/6M+ZQKxm0yyTac9Dd+Wo=;
        b=PHHSRrfoiWhIqC1eCLnZ5z5Qgp2e0hUlET6eSbLJEBHAA8iRNKmQu7RXce76FS2tR7
         HldNSTEYsVWl08X64qW8gRIsmN6HxZFutASqiQLFAEo2M3CQiTnQ+SWQYzwLPKAqmfh4
         PB64puwq6Ld4XLj5uk8mTZFH7lN93WLr/3HIpBCecz8JdiXBgiOOOW2ea0KBBYlcmv9u
         vieNUMnLnRO7wMtQlVuXjhLA8XDnW1q9Hg48gFKehRLbqRYWl2lKkA+MfXTCxuuKtovP
         vN5ZCIlHKwh/pXxVE5A7OgRRb5OGvPozQx7eHkdOvUAUkEFsreS+gzl2YwaUbAldWM9I
         8nEw==
X-Gm-Message-State: APjAAAWM4TvQ8r/io40k3v+4tunCHTxS0u/UIr/7Q2YlI5U74xwV1WNh
        DbAh3oao9X0UbZreBa7kb9Rj9X8KF18=
X-Google-Smtp-Source: APXvYqz+iYFFIcRb1I5pnoRs5cWJMxRKcYJ6HmMQlljF00JhSezz1KHDsVoBuk8Tojxhe2xd1hB5VQ==
X-Received: by 2002:a19:7701:: with SMTP id s1mr2551029lfc.180.1578482283030;
        Wed, 08 Jan 2020 03:18:03 -0800 (PST)
Received: from localhost.localdomain (mobile-user-c1d2e4-97.dhcp.inet.fi. [193.210.228.97])
        by smtp.gmail.com with ESMTPSA id u17sm1083763ljk.62.2020.01.08.03.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 03:18:02 -0800 (PST)
From:   Janne Karhunen <janne.karhunen@gmail.com>
To:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, zohar@linux.ibm.com
Cc:     kgold@linux.ibm.com, david.safford@gmail.com, monty.wiseman@ge.com,
        Janne Karhunen <janne.karhunen@gmail.com>
Subject: [PATCH v2] ima: export the measurement list when needed
Date:   Wed,  8 Jan 2020 13:17:43 +0200
Message-Id: <20200108111743.23393-1-janne.karhunen@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Some systems can end up carrying lots of entries in the ima
measurement list. Since every entry is using a bit of kernel
memory, allow the sysadmin to export the measurement list to
the filesystem to free up some memory.

Signed-off-by: Janne Karhunen <janne.karhunen@gmail.com>
---
 security/integrity/ima/ima.h       |   7 +-
 security/integrity/ima/ima_fs.c    | 171 +++++++++++++++++++++++++++++
 security/integrity/ima/ima_queue.c |   2 +-
 3 files changed, 175 insertions(+), 5 deletions(-)

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
index 2000e8df0301..b60a241b0d8b 100644
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
@@ -449,6 +457,162 @@ static const struct file_operations ima_measure_policy_ops = {
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
+	int err = 0;
+
+	if (to == NULL)
+		goto out_err;
+	if (from == NULL)
+		from = secfs_mnt am_filename;
+
+	pr_info("exporting msmt list to %s\n", to);
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
+				  0600);
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
+		if (bytesin != bytesout) {
+			/*
+			 * If we fail writing, don't free the list and allow
+			 * a retry later on.
+			 */
+			pr_err("write error at %lld\n", offout);
+			err = -EIO;
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
+	kfree(ima_msmt_list_name);
+
+	ima_msmt_list_name = kzalloc(count, GFP_KERNEL);
+	if (!ima_msmt_list_name) {
+		err = -ENOMEM;
+		goto out_unlock;
+	}
+	err = copy_from_user(ima_msmt_list_name, buf, count);
+	if (err) {
+		kfree(ima_msmt_list_name);
+		ima_msmt_list_name = NULL;
+		goto out_unlock;
+	}
+	if (ima_msmt_list_name[count-1] == '\n')
+		ima_msmt_list_name[count-1] = 0;
+
+	err = ima_export_list(NULL);
+out_unlock:
+	mutex_unlock(&ima_list_mutex);
+	if (err) {
+		pr_err("list export failed with %d\n", err);
+		return err;
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
@@ -493,6 +657,11 @@ int __init ima_fs_init(void)
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
@@ -502,5 +671,7 @@ int __init ima_fs_init(void)
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


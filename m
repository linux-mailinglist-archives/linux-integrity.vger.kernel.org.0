Return-Path: <linux-integrity+bounces-8171-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD010CF6693
	for <lists+linux-integrity@lfdr.de>; Tue, 06 Jan 2026 03:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4AC3330049C5
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Jan 2026 02:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC7422D9F7;
	Tue,  6 Jan 2026 02:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="isr+iXwo"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B70253E0B;
	Tue,  6 Jan 2026 02:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767665248; cv=none; b=eWIBK/a4sns9+c+ZvmfCrq3xeUsJjXC4zkfc9236W/5+3GaKq0UaPXdXyp8z+EnHV36qIyf8WkePHzsTxBYsh+v/NcGY1jlnlJl+CxamfRvViXP6OnlVHEwPIlWfUUqvY8R915I+yp1MpAWfl/991MUK1lKR4u5ujc1EdvqIEaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767665248; c=relaxed/simple;
	bh=ubo/Lb27Iw6DcT1FuUX7IOQWu3Mb8H66Nh8ycZpKL/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cQvNjVqAtBGFMOSHJar2Z1DDZednrSFAvtMFAztgTJie0QZNAIvjcC6r5tknhC6UgariiPyGzLUQrjPeGO0uHEqQHpzRl/MENg52LSgb5nF9Zjv4qjzaJ285vTwVfIxJvJUkvjfTxRP6aKsW9DztKlxdLJw2vR6BqfqhGBFa4xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=isr+iXwo; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from chenste-Virtual-Machine.mshome.net (unknown [50.168.180.218])
	by linux.microsoft.com (Postfix) with ESMTPSA id EF12B2126881;
	Mon,  5 Jan 2026 18:07:24 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EF12B2126881
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1767665246;
	bh=4PawjqN/gAjrZzWyQoTzlElu2ypxW6v/WJX90AMU07Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=isr+iXwoeGd2BFHZfxZOL6aeSCSlKTsQY9yz5VQ28qLUjmxjF8bWew5Mgjl5D9iuS
	 OnNgudBvnTnGNVYn1FYLYtp/vkaj1yF3TYvXdmb6meS+/FlcbqDVy53s7q9PJM8J2Q
	 Hxco0ZT4IIQOf44Tj0AcomCTOs+8tX5hMUKSWMtI=
From: steven chen <chenste@linux.microsoft.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	corbet@lwn.net,
	serge@hallyn.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	linux-security-module@vger.kernel.org,
	anirudhve@linux.microsoft.com,
	chenste@linux.microsoft.com,
	gregorylumen@linux.microsoft.com,
	nramas@linux.microsoft.com,
	sushring@linux.microsoft.com,
	linux-doc@vger.kernel.org
Subject: [PATCH v3 2/3] ima: trim N IMA event log records
Date: Mon,  5 Jan 2026 18:07:11 -0800
Message-ID: <20260106020713.3994-3-chenste@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260106020713.3994-1-chenste@linux.microsoft.com>
References: <20260106020713.3994-1-chenste@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Trim N entries of the IMA event logs. Clean the hash table if
ima_flush_htable is set.

Provide a userspace interface ima_trim_log that can be used to input
number N to let kernel to trim N entries of IMA event logs. When read
this interface, it returns number of entries trimmed last time.

Signed-off-by: steven chen <chenste@linux.microsoft.com>
---
 .../admin-guide/kernel-parameters.txt         |   4 +
 security/integrity/ima/ima.h                  |   2 +
 security/integrity/ima/ima_fs.c               | 164 +++++++++++++++++-
 security/integrity/ima/ima_queue.c            |  85 +++++++++
 4 files changed, 251 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index e92c0056e4e0..cd1a1d0bf0e2 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2197,6 +2197,10 @@
 			Use the canonical format for the binary runtime
 			measurements, instead of host native format.
 
+	ima_flush_htable  [IMA]
+			Flush the measurement list hash table when trim all
+			or a part of it for deletion.
+
 	ima_hash=	[IMA]
 			Format: { md5 | sha1 | rmd160 | sha256 | sha384
 				   | sha512 | ... }
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index e3d71d8d56e3..2102c523dca0 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -246,8 +246,10 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
 
 #ifdef CONFIG_IMA_KEXEC
 void ima_measure_kexec_event(const char *event_name);
+long ima_delete_event_log(long req_val);
 #else
 static inline void ima_measure_kexec_event(const char *event_name) {}
+static inline long ima_delete_event_log(long req_val) { return 0; }
 #endif
 
 /*
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 87045b09f120..67ff0cfc3d3f 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -21,6 +21,9 @@
 #include <linux/rcupdate.h>
 #include <linux/parser.h>
 #include <linux/vmalloc.h>
+#include <linux/ktime.h>
+#include <linux/timekeeping.h>
+#include <linux/ima.h>
 
 #include "ima.h"
 
@@ -38,6 +41,17 @@ __setup("ima_canonical_fmt", default_canonical_fmt_setup);
 
 static int valid_policy = 1;
 
+#define IMA_LOG_TRIM_REQ_LENGTH 11
+#define IMA_LOG_TRIM_EVENT_LEN 256
+
+static long trimcount;
+/* mutex protects atomicity of trimming measurement list
+ * and also protects atomicity the measurement list read
+ * write operation.
+ */
+static DEFINE_MUTEX(ima_measure_lock);
+static long ima_measure_users;
+
 static ssize_t ima_show_htable_value(char __user *buf, size_t count,
 				     loff_t *ppos, atomic_long_t *val)
 {
@@ -202,16 +216,77 @@ static const struct seq_operations ima_measurments_seqops = {
 	.show = ima_measurements_show
 };
 
+/*
+ * _ima_measurements_open - open the IMA measurements file
+ * @inode: inode of the file being opened
+ * @file: file being opened
+ * @seq_ops: sequence operations for the file
+ *
+ * Returns 0 on success, or negative error code.
+ * Implements mutual exclusion between readers and writer
+ * of the measurements file. Multiple readers are allowed,
+ * but writer get exclusive access only no other readers/writers.
+ * Readers is not allowed when there is a writer.
+ */
+static int _ima_measurements_open(struct inode *inode, struct file *file,
+				  const struct seq_operations *seq_ops)
+{
+	bool write = !!(file->f_mode & FMODE_WRITE);
+	int ret;
+
+	if (write && !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	mutex_lock(&ima_measure_lock);
+	if ((write && ima_measure_users != 0) ||
+	    (!write && ima_measure_users < 0)) {
+		mutex_unlock(&ima_measure_lock);
+		return -EBUSY;
+	}
+
+	ret = seq_open(file, seq_ops);
+	if (ret < 0) {
+		mutex_unlock(&ima_measure_lock);
+		return ret;
+	}
+
+	if (write)
+		ima_measure_users--;
+	else
+		ima_measure_users++;
+
+	mutex_unlock(&ima_measure_lock);
+	return ret;
+}
+
 static int ima_measurements_open(struct inode *inode, struct file *file)
 {
-	return seq_open(file, &ima_measurments_seqops);
+	return _ima_measurements_open(inode, file, &ima_measurments_seqops);
+}
+
+static int ima_measurements_release(struct inode *inode, struct file *file)
+{
+	bool write = !!(file->f_mode & FMODE_WRITE);
+	int ret;
+
+	mutex_lock(&ima_measure_lock);
+	ret = seq_release(inode, file);
+	if (!ret) {
+		if (write)
+			ima_measure_users++;
+		else
+			ima_measure_users--;
+	}
+
+	mutex_unlock(&ima_measure_lock);
+	return ret;
 }
 
 static const struct file_operations ima_measurements_ops = {
 	.open = ima_measurements_open,
 	.read = seq_read,
 	.llseek = seq_lseek,
-	.release = seq_release,
+	.release = ima_measurements_release,
 };
 
 void ima_print_digest(struct seq_file *m, u8 *digest, u32 size)
@@ -279,14 +354,83 @@ static const struct seq_operations ima_ascii_measurements_seqops = {
 
 static int ima_ascii_measurements_open(struct inode *inode, struct file *file)
 {
-	return seq_open(file, &ima_ascii_measurements_seqops);
+	return _ima_measurements_open(inode, file, &ima_ascii_measurements_seqops);
 }
 
 static const struct file_operations ima_ascii_measurements_ops = {
 	.open = ima_ascii_measurements_open,
 	.read = seq_read,
 	.llseek = seq_lseek,
-	.release = seq_release,
+	.release = ima_measurements_release,
+};
+
+static int ima_log_trim_open(struct inode *inode, struct file *file)
+{
+	bool write = !!(file->f_mode & FMODE_WRITE);
+
+	if (!write && capable(CAP_SYS_ADMIN))
+		return 0;
+	else if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	return _ima_measurements_open(inode, file, &ima_measurments_seqops);
+}
+
+static ssize_t ima_log_trim_read(struct file *file, char __user *buf, size_t size, loff_t *ppos)
+{
+	char tmpbuf[IMA_LOG_TRIM_REQ_LENGTH];	/* greater than largest 'long' string value */
+	ssize_t len;
+
+	len = scnprintf(tmpbuf, sizeof(tmpbuf), "%li\n", trimcount);
+	return simple_read_from_buffer(buf, size, ppos, tmpbuf, len);
+}
+
+static ssize_t ima_log_trim_write(struct file *file,
+				  const char __user *buf, size_t datalen, loff_t *ppos)
+{
+	long count, n, ret;
+
+	if (*ppos > 0 || datalen > IMA_LOG_TRIM_REQ_LENGTH || datalen < 2) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	n = (int)datalen;
+
+	ret = kstrtol_from_user(buf, n, 10, &count);
+	if (ret < 0)
+		goto out;
+
+	ret = ima_delete_event_log(count);
+
+	if (ret < 0)
+		goto out;
+
+	trimcount = ret;
+
+	ret = datalen;
+out:
+	return ret;
+}
+
+static int ima_log_trim_release(struct inode *inode, struct file *file)
+{
+	bool write = !!(file->f_mode & FMODE_WRITE);
+
+	if (!write && capable(CAP_SYS_ADMIN))
+		return 0;
+	else if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	return ima_measurements_release(inode, file);
+}
+
+static const struct file_operations ima_log_trim_ops = {
+	.open = ima_log_trim_open,
+	.read = ima_log_trim_read,
+	.write = ima_log_trim_write,
+	.llseek = generic_file_llseek,
+	.release = ima_log_trim_release
 };
 
 static ssize_t ima_read_policy(char *path)
@@ -528,6 +672,18 @@ int __init ima_fs_init(void)
 		goto out;
 	}
 
+	if (IS_ENABLED(CONFIG_IMA_LOG_TRIMMING)) {
+		dentry = securityfs_create_file("ima_trim_log",
+						S_IRUSR | S_IRGRP | S_IWUSR | S_IWGRP,
+						ima_dir, NULL, &ima_log_trim_ops);
+		if (IS_ERR(dentry)) {
+			ret = PTR_ERR(dentry);
+			goto out;
+		}
+	}
+
+	trimcount = 0;
+
 	dentry = securityfs_create_file("runtime_measurements_count",
 				   S_IRUSR | S_IRGRP, ima_dir, NULL,
 				   &ima_measurements_count_ops);
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 590637e81ad1..33bb5414b8cc 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -22,6 +22,14 @@
 
 #define AUDIT_CAUSE_LEN_MAX 32
 
+bool ima_flush_htable;
+static int __init ima_flush_htable_setup(char *str)
+{
+	ima_flush_htable = true;
+	return 1;
+}
+__setup("ima_flush_htable", ima_flush_htable_setup);
+
 /* pre-allocated array of tpm_digest structures to extend a PCR */
 static struct tpm_digest *digests;
 
@@ -220,6 +228,83 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
 	return result;
 }
 
+/**
+ * ima_delete_event_log - delete IMA event entry
+ * @num_records: number of records to delete
+ *
+ * delete num_records entries off the measurement list.
+ * Returns the number of entries deleted, or negative error code.
+ */
+long ima_delete_event_log(long num_records)
+{
+	long len, cur = num_records, tmp_len = 0;
+	struct ima_queue_entry *qe, *qe_tmp;
+	LIST_HEAD(ima_measurements_staged);
+	struct list_head *list_ptr;
+
+	if (num_records <= 0)
+		return num_records;
+
+	if (!IS_ENABLED(CONFIG_IMA_LOG_TRIMMING))
+		return -EOPNOTSUPP;
+
+	mutex_lock(&ima_extend_list_mutex);
+	len = atomic_long_read(&ima_htable.len);
+
+	if (num_records > len) {
+		mutex_unlock(&ima_extend_list_mutex);
+		return -ENOENT;
+	}
+
+	list_ptr = &ima_measurements;
+
+	if (cur == len) {
+		list_replace(&ima_measurements, &ima_measurements_staged);
+		INIT_LIST_HEAD(&ima_measurements);
+		atomic_long_set(&ima_htable.len, 0);
+		list_ptr = &ima_measurements_staged;
+		if (IS_ENABLED(CONFIG_IMA_KEXEC))
+			binary_runtime_size = 0;
+	}
+
+	list_for_each_entry(qe, list_ptr, later) {
+		if (num_records > 0) {
+			if (!IS_ENABLED(CONFIG_IMA_DISABLE_HTABLE) && ima_flush_htable)
+				hlist_del_rcu(&qe->hnext);
+
+			--num_records;
+			if (num_records == 0)
+				qe_tmp = qe;
+			continue;
+		}
+		if (len != cur && IS_ENABLED(CONFIG_IMA_KEXEC))
+			tmp_len += get_binary_runtime_size(qe->entry);
+		else
+			break;
+	}
+
+	if (len != cur) {
+		__list_cut_position(&ima_measurements_staged, &ima_measurements,
+				    &qe_tmp->later);
+		atomic_long_sub(cur, &ima_htable.len);
+		if (IS_ENABLED(CONFIG_IMA_KEXEC))
+			binary_runtime_size = tmp_len;
+	}
+
+	mutex_unlock(&ima_extend_list_mutex);
+
+	if (ima_flush_htable)
+		synchronize_rcu();
+
+	list_for_each_entry_safe(qe, qe_tmp, &ima_measurements_staged, later) {
+		ima_free_template_entry(qe->entry);
+		list_del(&qe->later);
+		kfree(qe);
+	}
+
+	return cur;
+}
+
 int ima_restore_measurement_entry(struct ima_template_entry *entry)
 {
 	int result = 0;
-- 
2.43.0



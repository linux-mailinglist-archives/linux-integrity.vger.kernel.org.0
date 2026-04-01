Return-Path: <linux-integrity+bounces-9116-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEquEexazWkRcQYAu9opvQ
	(envelope-from <linux-integrity+bounces-9116-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 01 Apr 2026 19:50:36 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBD837ED47
	for <lists+linux-integrity@lfdr.de>; Wed, 01 Apr 2026 19:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 492743069771
	for <lists+linux-integrity@lfdr.de>; Wed,  1 Apr 2026 17:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD1A47DD6A;
	Wed,  1 Apr 2026 17:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="aoXqjKOn"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45EF247D95C;
	Wed,  1 Apr 2026 17:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775064932; cv=none; b=rpfyFFHwDh57mTrd0en8gWthuk5X5pUrJrEgI9Om4ouA+RRQhsO1WoVj2Ct3Ymox7xT/QrgBNfp/h2Tm40gR2daayJL8q8wsNTN1hM8uYvOT569I1YGgdcyeVS+z83A+rhoMWeI+eFZfaeLRBBqrW9w/Lm1+mhRPUs7u/wsFxZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775064932; c=relaxed/simple;
	bh=v7vASyRLyvzHSEpZZ+rC41cH+wZDAumsjjWjHcetXlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=unkqXgmdzGrVGDTpmpijNekiieUf5Ij3KTNo4RP61AsfqDrA5kDRlHYJsWCcEcJA2aDzQFwiiqgB0Sc1g8DQJicPWPqaSEboBTWu2qYw5syttsjDRfbsEjJq+vR1mse6DO+bqEBB4IXzkSsT8GX6G4Pgt+5DA7uEwuleUQJHoQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=aoXqjKOn; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from chenste-Virtual-Machine.mshome.net (unknown [131.107.174.223])
	by linux.microsoft.com (Postfix) with ESMTPSA id 90EC720B7135;
	Wed,  1 Apr 2026 10:35:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 90EC720B7135
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775064928;
	bh=tzUs/DoWbJW3Rl+eFcYUxd8GaGckNeWvIgytCrFzf3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aoXqjKOnB823CusfXRQiTUKbAPns9Od9G5pSOPuREgCm9aJcwBxTpuduy/SN26RhV
	 Qi2tXgl+4P6kRhsU5VGmYljE+t/BvyE1oRYL3KCgAYXhsrtm0we88LJUsSWkrJkrCP
	 QtfTr7n0x1rAkwKGjqgK5uRfet3Quc/kxTzwT79U=
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
Subject: [PATCH v5 2/3] ima: trim N IMA event log records
Date: Wed,  1 Apr 2026 10:29:54 -0700
Message-ID: <20260401172956.4581-3-chenste@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260401172956.4581-1-chenste@linux.microsoft.com>
References: <20260401172956.4581-1-chenste@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.ibm.com,huawei.com,gmail.com,oracle.com,lwn.net,hallyn.com,paul-moore.com,namei.org,vger.kernel.org,linux.microsoft.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9116-lists,linux-integrity=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenste@linux.microsoft.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,linux.microsoft.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9CBD837ED47
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Trim N entries of the IMA event logs. Do not clean the hash table.
The values saved in hash table were already used.

Provide a userspace interface ima_trim_log:
When read this interface, it returns total number T of entries trimmed
since system boot up.
When write to this interface need to provide two numbers T:N to let
kernel to trim N entries of IMA event logs.

Kernel measurement list lock time performance improvement by not
clean the hash table.

when kernel get log trim request T:N
 - Get the T, compare with the total trimmed number
 - if equal, then do trim N and change T to T+N
 - else return error

Signed-off-by: steven chen <chenste@linux.microsoft.com>
---
 .../admin-guide/kernel-parameters.txt         |   4 +
 security/integrity/ima/ima.h                  |   4 +-
 security/integrity/ima/ima_fs.c               | 198 +++++++++++++++++-
 security/integrity/ima/ima_kexec.c            |   2 +-
 security/integrity/ima/ima_queue.c            |  96 +++++++++
 5 files changed, 296 insertions(+), 8 deletions(-)

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
index e3d71d8d56e3..5cbee3a295a0 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -243,11 +243,13 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
 				   const void *payload, size_t plen,
 				   unsigned long flags, bool create);
 #endif
-
+extern atomic_long_t ima_number_entries;
 #ifdef CONFIG_IMA_KEXEC
 void ima_measure_kexec_event(const char *event_name);
+long ima_delete_event_log(long req_val);
 #else
 static inline void ima_measure_kexec_event(const char *event_name) {}
+static inline long ima_delete_event_log(long req_val) { return 0; }
 #endif
 
 /*
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 87045b09f120..8e26e0f34311 100644
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
 
+#define IMA_LOG_TRIM_REQ_NUM_LENGTH 15
+#define IMA_LOG_TRIM_REQ_TOTAL_LENGTH 32
+atomic_long_t ima_number_entries = ATOMIC_LONG_INIT(0);
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
@@ -64,8 +78,7 @@ static ssize_t ima_show_measurements_count(struct file *filp,
 					   char __user *buf,
 					   size_t count, loff_t *ppos)
 {
-	return ima_show_htable_value(buf, count, ppos, &ima_htable.len);
-
+	return ima_show_htable_value(buf, count, ppos, &ima_number_entries);
 }
 
 static const struct file_operations ima_measurements_count_ops = {
@@ -202,16 +215,77 @@ static const struct seq_operations ima_measurments_seqops = {
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
+		if (!write)
+			ima_measure_users--;
+		else
+			ima_measure_users++;
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
@@ -279,14 +353,114 @@ static const struct seq_operations ima_ascii_measurements_seqops = {
 
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
+	char tmpbuf[IMA_LOG_TRIM_REQ_NUM_LENGTH];
+	ssize_t len;
+
+	len = scnprintf(tmpbuf, sizeof(tmpbuf), "%li\n", trimcount);
+	return simple_read_from_buffer(buf, size, ppos, tmpbuf, len);
+}
+
+static ssize_t ima_log_trim_write(struct file *file,
+				  const char __user *buf, size_t datalen, loff_t *ppos)
+{
+	char tmpbuf[IMA_LOG_TRIM_REQ_TOTAL_LENGTH];
+	char *p = tmpbuf;
+	long count, ret, val = 0, max = LONG_MAX;
+
+	if (*ppos > 0 || datalen > IMA_LOG_TRIM_REQ_TOTAL_LENGTH || datalen < 2) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (copy_from_user(tmpbuf, buf, datalen) != 0) {
+		ret = -EFAULT;
+		goto out;
+	}
+
+	p = tmpbuf;
+
+	while (*p && *p != ':') {
+		if (!isdigit((unsigned char)*p))
+			return -EINVAL;
+
+		/* digit value */
+		int d = *p - '0';
+
+		/* overflow check: val * 10 + d > max -> (val > (max - d) / 10) */
+		if (val > (max - d) / 10)
+			return -ERANGE;
+
+		val = val * 10 + d;
+		p++;
+	}
+
+	if (*p != ':')
+		return -EINVAL;
+
+	/* verify trim count matches */
+	if (val != trimcount)
+		return -EINVAL;
+
+	p++; /* skip ':' */
+	ret = kstrtoul(p, 0, &count);
+
+	if (ret < 0)
+		goto out;
+
+	ret = ima_delete_event_log(count);
+
+	if (ret < 0)
+		goto out;
+
+	trimcount += ret;
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
@@ -528,6 +702,18 @@ int __init ima_fs_init(void)
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
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 7362f68f2d8b..bee997683e03 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -41,7 +41,7 @@ void ima_measure_kexec_event(const char *event_name)
 	int n;
 
 	buf_size = ima_get_binary_runtime_size();
-	len = atomic_long_read(&ima_htable.len);
+	len = atomic_long_read(&ima_number_entries);
 
 	n = scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
 		      "kexec_segment_size=%lu;ima_binary_runtime_size=%lu;"
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 590637e81ad1..07225e19b9b5 100644
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
 
@@ -114,6 +122,7 @@ static int ima_add_digest_entry(struct ima_template_entry *entry,
 	list_add_tail_rcu(&qe->later, &ima_measurements);
 
 	atomic_long_inc(&ima_htable.len);
+	atomic_long_inc(&ima_number_entries);
 	if (update_htable) {
 		key = ima_hash_key(entry->digests[ima_hash_algo_idx].digest);
 		hlist_add_head_rcu(&qe->hnext, &ima_htable.queue[key]);
@@ -220,6 +229,93 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
 	return result;
 }
 
+/**
+ * ima_delete_event_log - delete IMA event entry
+ * @num_records: number of records to delete
+ *
+ * delete num_records entries off the measurement list.
+ * Returns num_records, or negative error code.
+ */
+long ima_delete_event_log(long num_records)
+{
+	long len, cur = num_records, tmp_len = 0;
+	struct ima_queue_entry *qe, *qe_tmp;
+	LIST_HEAD(ima_measurements_to_delete);
+	struct list_head *list_ptr;
+
+	if (!IS_ENABLED(CONFIG_IMA_LOG_TRIMMING))
+		return -EOPNOTSUPP;
+
+	if (num_records <= 0)
+		return num_records;
+
+	list_ptr = &ima_measurements;
+
+	len = atomic_long_read(&ima_number_entries);
+
+	if (num_records <= len) {
+		list_for_each_entry(qe, list_ptr, later) {
+			if (cur > 0) {
+				tmp_len += get_binary_runtime_size(qe->entry);
+				--cur;
+			}
+			if (cur == 0) {
+				qe_tmp = qe;
+				break;
+			}
+		}
+	}
+	else {
+		return -ENOENT;
+	}
+
+
+	mutex_lock(&ima_extend_list_mutex);
+	len = atomic_long_read(&ima_number_entries);
+
+	if (num_records == len) {
+		list_replace(&ima_measurements, &ima_measurements_to_delete);
+		INIT_LIST_HEAD(&ima_measurements);
+		atomic_long_set(&ima_number_entries, 0);
+		list_ptr = &ima_measurements_to_delete;
+	}
+	else {
+		__list_cut_position(&ima_measurements_to_delete, &ima_measurements,
+				    &qe_tmp->later);
+		atomic_long_sub(num_records, &ima_number_entries);
+		if (IS_ENABLED(CONFIG_IMA_KEXEC))
+			binary_runtime_size -= tmp_len;
+	}
+
+	mutex_unlock(&ima_extend_list_mutex);
+
+	if (ima_flush_htable)
+		synchronize_rcu();
+
+	list_for_each_entry_safe(qe, qe_tmp, &ima_measurements_to_delete, later) {
+		/*
+		 * Ok because after list delete qe is only accessed by
+		 * ima_lookup_digest_entry().
+		 */
+		for (int i = 0; i < qe->entry->template_desc->num_fields; i++) {
+			kfree(qe->entry->template_data[i].data);
+			qe->entry->template_data[i].data = NULL;
+			qe->entry->template_data[i].len = 0;
+		}
+
+		list_del(&qe->later);
+
+		/* No leak if !ima_flush_htable, referenced by ima_htable. */
+		if (ima_flush_htable) {
+			kfree(qe->entry->digests);
+			kfree(qe->entry);
+			kfree(qe);
+		}
+	}
+
+	return num_records;
+}
+
 int ima_restore_measurement_entry(struct ima_template_entry *entry)
 {
 	int result = 0;
-- 
2.43.0



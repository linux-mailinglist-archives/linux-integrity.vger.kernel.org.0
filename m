Return-Path: <linux-integrity+bounces-7773-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D205AC9D56B
	for <lists+linux-integrity@lfdr.de>; Wed, 03 Dec 2025 00:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4FB1734AA60
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Dec 2025 23:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E652FABE6;
	Tue,  2 Dec 2025 23:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OeUkfebp"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2EE1427A;
	Tue,  2 Dec 2025 23:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764718155; cv=none; b=Mwzl4oInnSqdie77oalLNtwGbPwx8v/9l/CZ4Fh4PIyfQts+mvRkHqzJ+yvtAbTgLaLFTd8fR8cHKQqwzuKia/Rg9FVj9y7LzD6mhpWFxcuqeAZKTWQ72tNwZ0IJtb6BHNuTm4V+rdNywfwnuM+lgcS0/NBdxQbizEnyPlW3J2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764718155; c=relaxed/simple;
	bh=fBOGvHdapLhw5aF/LncIAexK9G4DVLiSbavQPboSHqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bl+fSilX/4iakYrV9XpUe+BDKLZdqxDjiXb979qPi3etazSxJmnGX6DpYYt1UVTG6JoudIg3i47Z6vQcIKMGIH7f87k7YeWs852Fq6Frtwv5p3sGhbBv7onz743S8dNm+K/6pbwWKHW7N0cVIIjBKdQDZvsAfMOpCXe/A9OTWM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=OeUkfebp; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from chenste-Virtual-Machine.mshome.net (unknown [131.107.1.211])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6AF552120E95;
	Tue,  2 Dec 2025 15:29:06 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6AF552120E95
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764718146;
	bh=/iceZDgyL+V9XSEq6lteUHXMk30iWjQbcTyV+Zvd/Do=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OeUkfebpZYjOC8so20carHcbtFFnqQyzlhgZs7uBLPoM+E9+vRs+6VCbzOcWfIl64
	 rz/dWmRTESCiv+pQX58wrkPpt+3A9ffbLrrZN1s+z0iEVVZZpQHYIePwNwphi4P4gx
	 nnSCjPE6F2OwVAsZQYomArDhYdRNqJiUh4Jqg12M=
From: steven chen <chenste@linux.microsoft.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	linux-security-module@vger.kernel.org,
	anirudhve@linux.microsoft.com,
	chenste@linux.microsoft.com,
	gregorylumen@linux.microsoft.com,
	nramas@linux.microsoft.com,
	sushring@linux.microsoft.com
Subject: [PATCH 1/1] IMA event log trimming
Date: Tue,  2 Dec 2025 15:28:56 -0800
Message-ID: <20251202232857.8211-2-chenste@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251202232857.8211-1-chenste@linux.microsoft.com>
References: <20251202232857.8211-1-chenste@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch is for trimming N entries of the IMA event logs as well as
cleaning the hash table.

It provides a userspace interface ima_trim_log that can be used to input
number N to let kernel to trim N entries of IMA event logs. When read
this interface, it returns number of entries trimmed last tim.

A mutex ima_trim_list_mutex is provided to allow one trimming request
at a time.

Signed-off-by: steven chen <chenste@linux.microsoft.com>
---
 security/integrity/ima/ima.h       |  2 +
 security/integrity/ima/ima_fs.c    | 78 ++++++++++++++++++++++++++++++
 security/integrity/ima/ima_queue.c | 42 ++++++++++++++++
 3 files changed, 122 insertions(+)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index e3d71d8d56e3..ab0e30ee25ea 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -246,8 +246,10 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
 
 #ifdef CONFIG_IMA_KEXEC
 void ima_measure_kexec_event(const char *event_name);
+long ima_purge_event_log(long number_logs);
 #else
 static inline void ima_measure_kexec_event(const char *event_name) {}
+static inline long ima_purge_event_log(long number_logs) { return 0; }
 #endif
 
 /*
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 87045b09f120..ea93448feedd 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -38,6 +38,11 @@ __setup("ima_canonical_fmt", default_canonical_fmt_setup);
 
 static int valid_policy = 1;
 
+#define IMA_LOG_TRIM_REQ_LENGTH 11
+static long trimcount;
+/* mutex protects atomicity of trimming measurement list requests */
+static DEFINE_MUTEX(ima_trim_list_mutex);
+
 static ssize_t ima_show_htable_value(char __user *buf, size_t count,
 				     loff_t *ppos, atomic_long_t *val)
 {
@@ -289,6 +294,69 @@ static const struct file_operations ima_ascii_measurements_ops = {
 	.release = seq_release,
 };
 
+static int ima_log_trim_open(struct inode *inode, struct file *filp)
+{
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+	return 0;
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
+	unsigned char req[IMA_LOG_TRIM_REQ_LENGTH];
+	long count, n;
+	int ret;
+
+	mutex_lock(&ima_trim_list_mutex);
+
+	if (*ppos > 0 || datalen > IMA_LOG_TRIM_REQ_LENGTH || datalen < 2) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	n = (int)datalen;
+
+	ret = copy_from_user(req, buf, datalen);
+	if (ret < 0)
+		goto out;
+
+	count = 0;
+	for (int i = 0; i < n; ++i) {
+		if (req[i] < '0' || req[i] > '9') {
+			ret = -EINVAL;
+			goto out;
+		}
+		count = count * 10 + req[i] - '0';
+	}
+	ret = ima_purge_event_log(count);
+
+	if (ret < 0)
+		goto out;
+
+	trimcount = ret;
+	ret = datalen;
+out:
+	mutex_unlock(&ima_trim_list_mutex);
+	return ret;
+}
+
+static const struct file_operations ima_log_trim_ops = {
+	.open = ima_log_trim_open,
+	.read = ima_log_trim_read,
+	.write = ima_log_trim_write,
+	.llseek = generic_file_llseek,
+};
+
 static ssize_t ima_read_policy(char *path)
 {
 	void *data = NULL;
@@ -528,6 +596,16 @@ int __init ima_fs_init(void)
 		goto out;
 	}
 
+	dentry = securityfs_create_file("ima_trim_log",
+					S_IRUSR | S_IRGRP | S_IWUSR | S_IWGRP,
+					ima_dir, NULL, &ima_log_trim_ops);
+	if (IS_ERR(dentry)) {
+		ret = PTR_ERR(dentry);
+		goto out;
+	}
+
+	trimcount = 0;
+
 	dentry = securityfs_create_file("runtime_measurements_count",
 				   S_IRUSR | S_IRGRP, ima_dir, NULL,
 				   &ima_measurements_count_ops);
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 590637e81ad1..999cd42c517c 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -220,6 +220,48 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
 	return result;
 }
 
+/* Delete the IMA event logs */
+long ima_purge_event_log(long number_logs)
+{
+	struct ima_queue_entry *qe;
+	long cur = 0;
+
+	if (number_logs <= 0)
+		return number_logs;
+
+	mutex_lock(&ima_extend_list_mutex);
+	rcu_read_lock();
+
+	/*
+	 * Remove this entry from both hash table and the measurement list
+	 * When removing from hash table, decrease the length counter
+	 * so that the hash table re-sizing logic works correctly
+	 */
+	list_for_each_entry_rcu(qe, &ima_measurements, later) {
+		int i;
+
+		/* if CONFIG_IMA_DISABLE_HTABLE is set, the hash table is not used */
+		if (!IS_ENABLED(CONFIG_IMA_DISABLE_HTABLE))
+			hlist_del_rcu(&qe->hnext);
+
+		for (i = 0; i < qe->entry->template_desc->num_fields; i++) {
+			kfree(qe->entry->template_data[i].data);
+			qe->entry->template_data[i].data = NULL;
+			qe->entry->template_data[i].len = 0;
+		}
+
+		atomic_long_dec(&ima_htable.len);
+		list_del_rcu(&qe->later);
+		++cur;
+		if (cur >= number_logs)
+			break;
+	}
+
+	rcu_read_unlock();
+	mutex_unlock(&ima_extend_list_mutex);
+	return cur;
+}
+
 int ima_restore_measurement_entry(struct ima_template_entry *entry)
 {
 	int result = 0;
-- 
2.43.0



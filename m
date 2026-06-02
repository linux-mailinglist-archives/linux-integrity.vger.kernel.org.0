Return-Path: <linux-integrity+bounces-9734-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNjOD+q9HmpNKQAAu9opvQ
	(envelope-from <linux-integrity+bounces-9734-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 02 Jun 2026 13:26:34 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5591462D728
	for <lists+linux-integrity@lfdr.de>; Tue, 02 Jun 2026 13:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 24DB9305FBED
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Jun 2026 11:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263F53D967A;
	Tue,  2 Jun 2026 11:17:39 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1553C988D;
	Tue,  2 Jun 2026 11:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780399058; cv=none; b=UjWi5u0UyqPwE9ZORLGM3Tebqu2C4yLvaEz2Y271ZNF9JiaDPRIV6f9pMrCz3j9OaqcokD58S/XebfFcWsh16LCUubNLY6/O6dDi/1r8sez1rQJT7o1KbeospXXYBgFF2bNqJBF93MpTX8T0T+b2R7a7Jx/UIwPS8beNwKCKhsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780399058; c=relaxed/simple;
	bh=yoEJwah63zLWE0ZPlSn8aLbr9OUX4Ve57goUnlgq1T8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Clx64vdBCxicHccHa7gwP5xLsreIJ9mVzPewc8g1szim0hPDJYDsb61y21sOLHHk4OKkS3RH+Rylgu5tWxDEYg0MWEVKplodAZhl0+pTMmLtol84AbPgdRHzz66sP7nCnWYRXqP+hOp2xG9OKfEBwOmOZP8k7Q46YE5yLudfl3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.235])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gV7T831BVz1HCb3;
	Tue,  2 Jun 2026 19:12:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 09EA04056C;
	Tue,  2 Jun 2026 19:17:27 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAnk860ux5qDyEzAA--.30490S3;
	Tue, 02 Jun 2026 12:17:26 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: corbet@lwn.net,
	skhan@linuxfoundation.org,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	gregorylumen@linux.microsoft.com,
	chenste@linux.microsoft.com,
	nramas@linux.microsoft.com,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v6 11/12] ima: Support staging and deleting N measurements records
Date: Tue,  2 Jun 2026 13:14:00 +0200
Message-ID: <20260602111401.1706052-12-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260602111401.1706052-1-roberto.sassu@huaweicloud.com>
References: <20260602111401.1706052-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwAnk860ux5qDyEzAA--.30490S3
X-Coremail-Antispam: 1UD129KBjvJXoWxKFykWFyrKr15JFW3ZFy7Wrg_yoW3tw1Dpa
	9aga4rCry8JryfKr1kGanrCr4ru3ykKF4DWrs8J342yF1rXryq9r45Cry2yFs8KrW8Jr18
	twsIqrs8Can8taDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7
	AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wr
	ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x
	07jjuWdUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAMBGoeRsQErgADsW
X-Rspamd-Queue-Id: 5591462D728
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9734-lists,linux-integrity=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lwn.net,linuxfoundation.org,linux.ibm.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[roberto.sassu@huaweicloud.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,huawei.com:email]
X-Rspamd-Action: no action

From: Roberto Sassu <roberto.sassu@huawei.com>

Add support for sending a value N between 1 and ULONG_MAX to the IMA
original measurement interface. This value represents the number of
measurements that should be deleted from the current measurements list. In
this case, measurements are staged in an internal non-user visible list,
and immediately deleted.

This staging method allows the remote attestation agents to easily separate
the measurements that were verified (staged and deleted) from those that
weren't due to the race between taking a TPM quote and reading the
measurements list.

In order to minimize the locking time of ima_extend_list_mutex, deleting
N records is realized by doing a lockless walk in the current measurements
list to determine the N-th entry to cut, to cut the current measurements
list under the lock, and by deleting the excess records after releasing the
lock.

Flushing the hash table is not supported for N records, since it would
require removing the N records one by one from the hash table under the
ima_extend_list_mutex lock, which would increase the locking time.

Link: https://github.com/linux-integrity/linux/issues/1
Co-developed-by: Steven Chen <chenste@linux.microsoft.com>
Co-developed-by: Roberto Sassu <roberto.sassu@huawei.com>
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/Kconfig     |  3 ++
 security/integrity/ima/ima.h       |  1 +
 security/integrity/ima/ima_fs.c    | 32 +++++++++++++--
 security/integrity/ima/ima_queue.c | 63 ++++++++++++++++++++++++++++++
 4 files changed, 96 insertions(+), 3 deletions(-)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 02436670f746..f4d25e045808 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -341,6 +341,9 @@ config IMA_STAGING
 	  It allows user space to stage the measurements list for deletion and
 	  to delete the staged measurements after confirmation.
 
+	  Or, alternatively, it allows user space to specify N measurements
+	  records to stage internally, so that they can be immediately deleted.
+
 	  On kexec, staging is aborted and any staged measurement records are
 	  copied to the secondary kernel.
 
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index d2e740c8ff75..7a1b2d6a8b59 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -320,6 +320,7 @@ struct ima_template_desc *lookup_template_desc(const char *name);
 bool ima_template_has_modsig(const struct ima_template_desc *ima_template);
 int ima_queue_stage(void);
 int ima_queue_staged_delete_all(void);
+int ima_queue_delete_partial(unsigned long req_value);
 int ima_restore_measurement_entry(struct ima_template_entry *entry);
 int ima_restore_measurement_list(loff_t bufsize, void *buf);
 int ima_measurements_show(struct seq_file *m, void *v);
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 96d7503a605b..174a94740da1 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -28,6 +28,7 @@
  * Requests:
  * 'A\n': stage the entire measurements list
  * 'D\n': delete all staged measurements
+ * '[1, ULONG_MAX]\n' delete N measurements records
  */
 #define STAGED_REQ_LENGTH 21
 
@@ -343,6 +344,7 @@ static ssize_t _ima_measurements_write(struct file *file,
 				       loff_t *ppos, bool staged_interface)
 {
 	char req[STAGED_REQ_LENGTH];
+	unsigned long req_value;
 	int ret;
 
 	if (datalen < 2 || datalen > STAGED_REQ_LENGTH)
@@ -370,7 +372,24 @@ static ssize_t _ima_measurements_write(struct file *file,
 		ret = ima_queue_staged_delete_all();
 		break;
 	default:
-		ret = -EINVAL;
+		if (staged_interface)
+			return -EINVAL;
+
+		if (ima_flush_htable) {
+			pr_debug("Deleting staged N measurements not supported when flushing the hash table is requested\n");
+			return -EINVAL;
+		}
+
+		ret = kstrtoul(req, 10, &req_value);
+		if (ret < 0)
+			return ret;
+
+		if (req_value == 0) {
+			pr_debug("Must delete at least one entry\n");
+			return -EINVAL;
+		}
+
+		ret = ima_queue_delete_partial(req_value);
 	}
 
 	if (ret < 0)
@@ -379,6 +398,12 @@ static ssize_t _ima_measurements_write(struct file *file,
 	return datalen;
 }
 
+static ssize_t ima_measurements_write(struct file *file, const char __user *buf,
+				      size_t datalen, loff_t *ppos)
+{
+	return _ima_measurements_write(file, buf, datalen, ppos, false);
+}
+
 static ssize_t ima_measurements_staged_write(struct file *file,
 					     const char __user *buf,
 					     size_t datalen, loff_t *ppos)
@@ -389,6 +414,7 @@ static ssize_t ima_measurements_staged_write(struct file *file,
 static const struct file_operations ima_measurements_ops = {
 	.open = ima_measurements_open,
 	.read = seq_read,
+	.write = ima_measurements_write,
 	.llseek = seq_lseek,
 	.release = ima_measurements_release,
 };
@@ -470,6 +496,7 @@ static int ima_ascii_measurements_open(struct inode *inode, struct file *file)
 static const struct file_operations ima_ascii_measurements_ops = {
 	.open = ima_ascii_measurements_open,
 	.read = seq_read,
+	.write = ima_measurements_write,
 	.llseek = seq_lseek,
 	.release = ima_measurements_release,
 };
@@ -603,14 +630,13 @@ static int __init create_securityfs_measurement_lists(bool staging)
 {
 	const struct file_operations *ascii_ops = &ima_ascii_measurements_ops;
 	const struct file_operations *binary_ops = &ima_measurements_ops;
-	umode_t permissions = (S_IRUSR | S_IRGRP);
+	umode_t permissions = (S_IRUSR | S_IRGRP | S_IWUSR | S_IWGRP);
 	const char *file_suffix = "";
 	int count = NR_BANKS(ima_tpm_chip);
 
 	if (staging) {
 		ascii_ops = &ima_ascii_measurements_staged_ops;
 		binary_ops = &ima_measurements_staged_ops;
-		permissions |= (S_IWUSR | S_IWGRP);
 		file_suffix = "_staged";
 	}
 
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index af0502f27d57..718991ba8bcd 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -405,6 +405,69 @@ int ima_queue_staged_delete_all(void)
 	return 0;
 }
 
+/**
+ * ima_queue_delete_partial - Delete current measurements
+ * @req_value: Number of measurements to delete
+ *
+ * Delete the requested number of measurements from the current measurements
+ * list, and update the number of records and the binary run-time size
+ * accordingly.
+ *
+ * Refuse to delete current measurements if measurement is suspended, so that
+ * dump can be done in a lockless way and user space is notified about current
+ * measurements being carried over to the secondary kernel, so that it does not
+ * save them twice.
+ *
+ * Return: Zero on success, a negative value otherwise.
+ */
+int ima_queue_delete_partial(unsigned long req_value)
+{
+	unsigned long req_value_copy = req_value;
+	unsigned long size_to_remove = 0, num_to_remove = 0;
+	LIST_HEAD(ima_measurements_trim);
+	struct ima_queue_entry *qe;
+	int ret = 0;
+
+	/*
+	 * list_for_each_entry_rcu() without rcu_read_lock() is fine because
+	 * only list append can happen concurrently. No list replace due to the
+	 * staging/delete writers mutual exclusion.
+	 */
+	list_for_each_entry_rcu(qe, &ima_measurements, later, true) {
+		size_to_remove += get_binary_runtime_size(qe->entry);
+		num_to_remove++;
+
+		if (--req_value_copy == 0)
+			break;
+	}
+
+	/* Not enough records to delete. */
+	if (req_value_copy > 0)
+		return -ENOENT;
+
+	mutex_lock(&ima_extend_list_mutex);
+	if (ima_measurements_suspended) {
+		mutex_unlock(&ima_extend_list_mutex);
+		return -ESTALE;
+	}
+
+	/*
+	 * qe remains valid because ima_fs.c enforces single-writer exclusion.
+	 */
+	__list_cut_position(&ima_measurements_trim, &ima_measurements,
+			    &qe->later);
+
+	atomic_long_sub(num_to_remove, &ima_num_records[BINARY]);
+
+	if (IS_ENABLED(CONFIG_IMA_KEXEC))
+		binary_runtime_size[BINARY] -= size_to_remove;
+
+	mutex_unlock(&ima_extend_list_mutex);
+
+	ima_queue_delete(&ima_measurements_trim, false);
+	return ret;
+}
+
 /**
  * ima_queue_delete - Delete measurements
  * @head: List head measurements are deleted from
-- 
2.43.0



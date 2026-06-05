Return-Path: <linux-integrity+bounces-9764-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vA43Mg4NI2rLhAEAu9opvQ
	(envelope-from <linux-integrity+bounces-9764-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 05 Jun 2026 19:53:18 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B07064A568
	for <lists+linux-integrity@lfdr.de>; Fri, 05 Jun 2026 19:53:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9764-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9764-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB63A3096B67
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Jun 2026 17:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7E1368D69;
	Fri,  5 Jun 2026 17:25:40 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F19433893D;
	Fri,  5 Jun 2026 17:25:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780680340; cv=none; b=k05uj8dp3T082RNG+UxZPBjbnJe3hfMuO/Isj6kTDTg7TbVSuWvV+e3Ic6TX7mHWLxLP26jrPSpSNqYPsT26hUXwOIsHHKcqJmOKNGXsQb3dDOsYXETxOnnJ56kuw87rbKSNLZSLzOmiRZK+WG3UAZoShQNEe5kOoGFXpdfusMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780680340; c=relaxed/simple;
	bh=FDGfuAGYylimIGqrbY7iUdj5DzPRO9Yhk1c3hXVf35c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qVwKr4QW2TpjV2nOha43RJxybJVOlSYCK5t6itFzkSiepNz/9g5rjulOUBwYYdheNObBXGyWva+2r17egMJGx5WHfDX+gt5AKoRJHUMKI1bmN8cIM+AH8OYE0BNxrhXJXJJGqJSq3D8DpcOtv8/+Op/EZWqginZS+d1StnV+Q2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Received: from mail.maildlp.com (unknown [172.18.224.196])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gX7VT6qJ3z1HCnS;
	Sat,  6 Jun 2026 01:20:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id CBD424056C;
	Sat,  6 Jun 2026 01:25:36 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwCXWY9+BiNqCg9lAA--.44013S3;
	Fri, 05 Jun 2026 18:25:36 +0100 (CET)
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
Subject: [PATCH v7 11/12] ima: Support staging and deleting N measurements records
Date: Fri,  5 Jun 2026 19:22:35 +0200
Message-ID: <20260605172236.2042045-12-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260605172236.2042045-1-roberto.sassu@huaweicloud.com>
References: <20260605172236.2042045-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwCXWY9+BiNqCg9lAA--.44013S3
X-Coremail-Antispam: 1UD129KBjvJXoWxKFykWFyrKr15JFW3ZFy7Wrg_yoWfXw1xpa
	9aga4rGr18J34fKrn7Ga1Dur4ru3ykKF4UWr45Ga42yF1rXryj9r45Cry2yFs8KryrJr18
	twsIqr45Can8taDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAPBGoiO0QKbwAAsY
X-Rspamd-Action: add header
X-Spamd-Result: default: False [6.34 / 15.00];
	SEM_URIBL(3.50)[huaweicloud.com:from_mime,huaweicloud.com:mid];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-9764-lists,linux-integrity=lfdr.de];
	DMARC_NA(0.00)[huaweicloud.com];
	FORGED_RECIPIENTS(0.00)[m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:zohar@linux.ibm.com,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:paul@paul-moore.com,m:jmorris@namei.org,m:serge@hallyn.com,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-integrity@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:gregorylumen@linux.microsoft.com,m:chenste@linux.microsoft.com,m:nramas@linux.microsoft.com,m:roberto.sassu@huawei.com,m:dmitrykasatkin@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[roberto.sassu@huaweicloud.com,linux-integrity@vger.kernel.org];
	GREYLIST(0.00)[pass,body];
	FREEMAIL_TO(0.00)[lwn.net,linuxfoundation.org,linux.ibm.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[roberto.sassu@huaweicloud.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huaweicloud.com:from_mime,huaweicloud.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4B07064A568
X-Spam: Yes

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
Signed-off-by: Steven Chen <chenste@linux.microsoft.com>
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/Kconfig     |  3 ++
 security/integrity/ima/ima.h       |  2 +
 security/integrity/ima/ima_fs.c    | 32 +++++++++++++--
 security/integrity/ima/ima_queue.c | 65 +++++++++++++++++++++++++++++-
 4 files changed, 98 insertions(+), 4 deletions(-)

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
index 3892d2a6c2e2..caaedd4b58fd 100644
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
@@ -342,6 +343,7 @@ extern atomic_long_t ima_num_records[BINARY__LAST];
 /* Total number of violations since hard boot. */
 extern atomic_long_t ima_num_violations;
 extern struct hlist_head __rcu *ima_htable;
+extern bool ima_flush_htable;
 
 static inline unsigned int ima_hash_key(u8 *digest)
 {
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
index df1e81ea7a36..f89f0ca3d4ed 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -22,7 +22,7 @@
 
 #define AUDIT_CAUSE_LEN_MAX 32
 
-static bool ima_flush_htable;
+bool ima_flush_htable;
 
 static int __init ima_flush_htable_setup(char *str)
 {
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



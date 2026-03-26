Return-Path: <linux-integrity+bounces-9101-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDiBMJdwxWkU+QQAu9opvQ
	(envelope-from <linux-integrity+bounces-9101-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Mar 2026 18:44:55 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6633395CA
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Mar 2026 18:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6134531A52B8
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Mar 2026 17:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9493C661A;
	Thu, 26 Mar 2026 17:33:30 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14F9423169;
	Thu, 26 Mar 2026 17:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774546409; cv=none; b=ao3VwAzVU73xewMWuiS5XUiAXmhLxt6qutSuWro27iYgWiVSadyuvoTv7nct/nhAmr0lfKpRmBSn1ElfZaZrpgM3hZEO1B7e8Ugmc/i7kZnFJQARsE9frnH/F6fvsweOksyZ6QeXmxqf4QOrl4sJQbpbCADvKpgDSP/5POt8aaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774546409; c=relaxed/simple;
	bh=EEplomlhYsF8C3nCyf8tvOwCRBmB9KsbLIaEfW+askY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OtBk4ERa941+2lljKHDk8djEAearnBzvjql7wQfrDXZOHVQLpSeYuVJhVr2/0QT+r8tqt/KGPxCvnC1U2/LnomMbf66BubiBv8p530dID+vNL2v2/+SVHv+CJrC1Tl5LRjby6oAADoCjkYF2USfExL7fV/olSEQt+df3EM03zdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.196])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fhW4602ZsztKRL;
	Fri, 27 Mar 2026 01:29:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 6CFE14056B;
	Fri, 27 Mar 2026 01:33:18 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwCHcu_MbcVpXmwvAQ--.1493S3;
	Thu, 26 Mar 2026 18:33:17 +0100 (CET)
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
Subject: [PATCH v4 11/13] ima: Support staging and deleting N measurements entries
Date: Thu, 26 Mar 2026 18:30:09 +0100
Message-ID: <20260326173011.1191815-12-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260326173011.1191815-1-roberto.sassu@huaweicloud.com>
References: <20260326173011.1191815-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwCHcu_MbcVpXmwvAQ--.1493S3
X-Coremail-Antispam: 1UD129KBjvJXoWxKFyfCw43Kw13CrWUAw43Jrb_yoWxKrykpa
	90ga48Cry8JryxKrykGas7Ars5W3ykGF1UGw43GasFyF13XFyj9rnxAFy2kFs8CrZ5Xr4f
	twsIqrs8Can0yaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7
	AKxVWrXVW3AwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wr
	ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x
	07jQ4SrUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAEBGnEnS4T7QABsj
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[huaweicloud.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lwn.net,linuxfoundation.org,linux.ibm.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9101-lists,linux-integrity=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[roberto.sassu@huaweicloud.com,linux-integrity@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huaweicloud.com:mid,huawei.com:email]
X-Rspamd-Queue-Id: 3E6633395CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Roberto Sassu <roberto.sassu@huawei.com>

Add support for sending a value N between 1 and ULONG_MAX to the staging
interface. This value represents the number of measurements that should be
deleted from the current measurements list.

This staging method allows the remote attestation agents to easily separate
the measurements that were verified (staged and deleted) from those that
weren't due to the race between taking a TPM quote and reading the
measurements list.

In order to minimize the locking time of ima_extend_list_mutex, deleting
N entries is realized by staging the entire current measurements list
(with the lock), by determining the N-th staged entry (without the lock),
and by splicing the entries in excess back to the current measurements list
(with the lock). Finally, the N entries are deleted (without the lock).

Flushing the hash table is not supported for N entries, since it would
require removing the N entries one by one from the hash table under the
ima_extend_list_mutex lock, which would increase the locking time.

The ima_extend_list_mutex lock is necessary in ima_dump_measurement_list()
because ima_queue_staged_delete_partial() uses __list_cut_position() to
modify ima_measurements_staged, for which no RCU-safe variant exists. For
the staging with prompt flavor alone, list_replace_rcu() could have been
used instead, but since both flavors share the same kexec serialization
path, the mutex is required regardless.

Link: https://github.com/linux-integrity/linux/issues/1
Suggested-by: Steven Chen <chenste@linux.microsoft.com>
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/Kconfig     |  3 ++
 security/integrity/ima/ima.h       |  1 +
 security/integrity/ima/ima_fs.c    | 22 +++++++++-
 security/integrity/ima/ima_queue.c | 70 ++++++++++++++++++++++++++++++
 4 files changed, 95 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index e714726f3384..6ddb4e77bff5 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -341,6 +341,9 @@ config IMA_STAGING
 	  It allows user space to stage the measurements list for deletion and
 	  to delete the staged measurements after confirmation.
 
+	  Or, alternatively, it allows user space to specify N measurements
+	  entries to be deleted.
+
 	  On kexec, staging is reverted and staged measurements are prepended
 	  to the current measurements list when measurements are copied to the
 	  secondary kernel.
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 699b735dec7d..de0693fce53c 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -319,6 +319,7 @@ struct ima_template_desc *lookup_template_desc(const char *name);
 bool ima_template_has_modsig(const struct ima_template_desc *ima_template);
 int ima_queue_stage(void);
 int ima_queue_staged_delete_all(void);
+int ima_queue_staged_delete_partial(unsigned long req_value);
 int ima_restore_measurement_entry(struct ima_template_entry *entry);
 int ima_restore_measurement_list(loff_t bufsize, void *buf);
 int ima_measurements_show(struct seq_file *m, void *v);
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 39d9128e9f22..eb3f343c1138 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -28,6 +28,7 @@
  * Requests:
  * 'A\n': stage the entire measurements list
  * 'D\n': delete all staged measurements
+ * '[1, ULONG_MAX]\n' delete N measurements entries
  */
 #define STAGED_REQ_LENGTH 21
 
@@ -319,6 +320,7 @@ static ssize_t ima_measurements_staged_write(struct file *file,
 					     size_t datalen, loff_t *ppos)
 {
 	char req[STAGED_REQ_LENGTH];
+	unsigned long req_value;
 	int ret;
 
 	if (*ppos > 0 || datalen < 2 || datalen > STAGED_REQ_LENGTH)
@@ -346,7 +348,25 @@ static ssize_t ima_measurements_staged_write(struct file *file,
 		ret = ima_queue_staged_delete_all();
 		break;
 	default:
-		ret = -EINVAL;
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
+		ret = ima_queue_stage();
+		if (ret < 0)
+			return ret;
+
+		ret = ima_queue_staged_delete_partial(req_value);
 	}
 
 	if (ret < 0)
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index f5c18acfbc43..4fb557d61a88 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -371,6 +371,76 @@ int ima_queue_staged_delete_all(void)
 	return 0;
 }
 
+int ima_queue_staged_delete_partial(unsigned long req_value)
+{
+	unsigned long req_value_copy = req_value;
+	unsigned long size_to_remove = 0, num_to_remove = 0;
+	struct list_head *cut_pos = NULL;
+	LIST_HEAD(ima_measurements_trim);
+	struct ima_queue_entry *qe;
+	int ret = 0;
+
+	/*
+	 * Safe walk (no concurrent write), not under ima_extend_list_mutex
+	 * for performance reasons.
+	 */
+	list_for_each_entry(qe, &ima_measurements_staged, later) {
+		size_to_remove += get_binary_runtime_size(qe->entry);
+		num_to_remove++;
+
+		if (--req_value_copy == 0) {
+			/* qe->later always points to a valid list entry. */
+			cut_pos = &qe->later;
+			break;
+		}
+	}
+
+	/* Nothing to remove, undoing staging. */
+	if (req_value_copy > 0) {
+		size_to_remove = 0;
+		num_to_remove = 0;
+		ret = -ENOENT;
+	}
+
+	mutex_lock(&ima_extend_list_mutex);
+	if (list_empty(&ima_measurements_staged)) {
+		mutex_unlock(&ima_extend_list_mutex);
+		return -ENOENT;
+	}
+
+	if (cut_pos != NULL)
+		/*
+		 * ima_dump_measurement_list() does not modify the list,
+		 * cut_pos remains the same even if it was computed before
+		 * the lock.
+		 */
+		__list_cut_position(&ima_measurements_trim,
+				    &ima_measurements_staged, cut_pos);
+
+	atomic_long_sub(num_to_remove, &ima_num_entries[BINARY_STAGED]);
+	atomic_long_add(atomic_long_read(&ima_num_entries[BINARY_STAGED]),
+			&ima_num_entries[BINARY]);
+	atomic_long_set(&ima_num_entries[BINARY_STAGED], 0);
+
+	if (IS_ENABLED(CONFIG_IMA_KEXEC)) {
+		binary_runtime_size[BINARY_STAGED] -= size_to_remove;
+		binary_runtime_size[BINARY] +=
+					binary_runtime_size[BINARY_STAGED];
+		binary_runtime_size[BINARY_STAGED] = 0;
+	}
+
+	/*
+	 * Splice (prepend) any remaining non-deleted staged entries to the
+	 * active list (RCU not needed, there cannot be concurrent readers).
+	 */
+	list_splice(&ima_measurements_staged, &ima_measurements);
+	INIT_LIST_HEAD(&ima_measurements_staged);
+	mutex_unlock(&ima_extend_list_mutex);
+
+	ima_queue_delete(&ima_measurements_trim, false);
+	return ret;
+}
+
 static void ima_queue_delete(struct list_head *head, bool flush_htable)
 {
 	struct ima_queue_entry *qe, *qe_tmp;
-- 
2.43.0



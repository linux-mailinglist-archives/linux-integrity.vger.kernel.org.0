Return-Path: <linux-integrity+bounces-9370-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mC/fK8ct8mlvogEAu9opvQ
	(envelope-from <linux-integrity+bounces-9370-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Apr 2026 18:11:51 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4593549787A
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Apr 2026 18:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 740543104024
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Apr 2026 16:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E7D388E4B;
	Wed, 29 Apr 2026 16:06:25 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32168388364;
	Wed, 29 Apr 2026 16:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777478785; cv=none; b=NVhDeBFIqCPBe5pm5oenirfv3anGSdDZUSENjeAkCFK7yT5CavrmqtrD5uQafMJCAJvDC0ysWrYNhyhz6j1Pa36p4RD/eKw3NaQrPM+3OF89CsZ0mxuWTjz69gGgUhYtLiytor6+Kz7mjivaLv119L2SoAkH89TRKv2ZegkgPNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777478785; c=relaxed/simple;
	bh=S1PnzrcZiFF2Muvhhg6xR2hu1pWceJZo3cff+Ua6lkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OfB5DielPRAd4wxhueobjvKGR9Q3Yu+lCSq8i3C/1ubWKuxcrFqwx0mFGHB832VTZb07sjqioGSy/EF+zx6syEe7WC3E5MgCzrKPCczXc6nAFsnMkI+Nbx4NIhTGUk80er0xxIvfrHfDRz2lEgy/OGXZ9GRLlXPXQSDc8yICyJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.196])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTPS id 4g5MWH1Z48zvQkC;
	Thu, 30 Apr 2026 00:02:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 1635D40562;
	Thu, 30 Apr 2026 00:06:19 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwC3rWlpLPJp2RNBAA--.11842S3;
	Wed, 29 Apr 2026 17:06:18 +0100 (CET)
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
Subject: [PATCH v5 11/13] ima: Support staging and deleting N measurements entries
Date: Wed, 29 Apr 2026 18:03:17 +0200
Message-ID: <20260429160319.4162918-12-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429160319.4162918-1-roberto.sassu@huaweicloud.com>
References: <20260429160319.4162918-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwC3rWlpLPJp2RNBAA--.11842S3
X-Coremail-Antispam: 1UD129KBjvJXoWxKFykWFyrKr15JFW3ZFy7Wrg_yoWxtr17pa
	9Iga48Gry8JryfKr97J3Z7Cr4F93ykGF1UGwsxGasFyF13XFyUurnxCry29r4rCr95JFyx
	twsIqrs8Ca1DtFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQASBGnx6jgGJAAAs-
X-Rspamd-Queue-Id: 4593549787A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9370-lists,linux-integrity=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[lwn.net,linuxfoundation.org,linux.ibm.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_SPAM(0.00)[0.890];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[roberto.sassu@huaweicloud.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-integrity];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huaweicloud.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email]

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
N entries is realized by doing a lockless walk in the current measurements
list to determine the N-th entry to cut, to cut the current measurements
list under the lock, and by deleting the excess entries after releasing the
lock.

Flushing the hash table is not supported for N entries, since it would
require removing the N entries one by one from the hash table under the
ima_extend_list_mutex lock, which would increase the locking time.

The ima_extend_list_mutex lock is necessary in ima_dump_measurement_list()
because ima_queue_delete_partial() uses __list_cut_position() to modify
ima_measurements, for which no RCU-safe variant exists. For the staging
with prompt flavor alone, list_replace_rcu() could have been used instead,
but since both flavors share the same kexec serialization path, the mutex
is required regardless.

Link: https://github.com/linux-integrity/linux/issues/1
Suggested-by: Steven Chen <chenste@linux.microsoft.com>
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/Kconfig     |  3 +++
 security/integrity/ima/ima.h       |  1 +
 security/integrity/ima/ima_fs.c    | 21 ++++++++++++++-
 security/integrity/ima/ima_kexec.c |  3 ++-
 security/integrity/ima/ima_queue.c | 43 ++++++++++++++++++++++++++++++
 5 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 48c906793efb..4f4373859a4f 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -341,6 +341,9 @@ config IMA_STAGING
 	  It allows user space to stage the measurements list for deletion and
 	  to delete the staged measurements after confirmation.
 
+	  Or, alternatively, it allows user space to specify N measurements
+	  entries to stage internally, so that they can be immediately deleted.
+
 	  On kexec, staging is reverted and staged measurements are prepended
 	  to the current measurements list when measurements are copied to the
 	  secondary kernel.
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 4af66c1de4dc..9a741b33d524 100644
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
index 088d5a69aa92..6843dc203b54 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -28,6 +28,7 @@
  * Requests:
  * 'A\n': stage the entire measurements list
  * 'D\n': delete all staged measurements
+ * '[1, ULONG_MAX]\n' delete N measurements entries
  */
 #define STAGED_REQ_LENGTH 21
 
@@ -312,6 +313,7 @@ static ssize_t _ima_measurements_write(struct file *file,
 				       loff_t *ppos, bool staged_interface)
 {
 	char req[STAGED_REQ_LENGTH];
+	unsigned long req_value;
 	int ret;
 
 	if (*ppos > 0 || datalen < 2 || datalen > STAGED_REQ_LENGTH)
@@ -339,7 +341,24 @@ static ssize_t _ima_measurements_write(struct file *file,
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
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 064cfce0c318..e7bde3d917b2 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -107,7 +107,8 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
 	memset(&khdr, 0, sizeof(khdr));
 	khdr.version = 1;
 	/*
-	 * It can race with ima_queue_stage() and ima_queue_staged_delete_all().
+	 * It can race with ima_queue_stage(), ima_queue_staged_delete_all()
+	 * and ima_queue_delete_partial().
 	 */
 	mutex_lock(&ima_extend_list_mutex);
 
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index f5c18acfbc43..64c4fe73dd5f 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -371,6 +371,49 @@ int ima_queue_staged_delete_all(void)
 	return 0;
 }
 
+int ima_queue_delete_partial(unsigned long req_value)
+{
+	unsigned long req_value_copy = req_value;
+	unsigned long size_to_remove = 0, num_to_remove = 0;
+	LIST_HEAD(ima_measurements_trim);
+	struct ima_queue_entry *qe;
+	int ret = 0;
+
+	/*
+	 * Safe to walk without rcu_read_lock(): single-writer
+	 * exclusion in ima_fs.c prevents any concurrent modification
+	 * to ima_measurements during this walk.
+	 */
+	list_for_each_entry_rcu(qe, &ima_measurements, later, true) {
+		size_to_remove += get_binary_runtime_size(qe->entry);
+		num_to_remove++;
+
+		if (--req_value_copy == 0)
+			break;
+	}
+
+	/* Not enough entries to delete. */
+	if (req_value_copy > 0)
+		return -ENOENT;
+
+	mutex_lock(&ima_extend_list_mutex);
+	/*
+	 * qe remains valid because ima_fs.c enforces single-writer exclusion.
+	 */
+	__list_cut_position(&ima_measurements_trim, &ima_measurements,
+			    &qe->later);
+
+	atomic_long_sub(num_to_remove, &ima_num_entries[BINARY]);
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
 static void ima_queue_delete(struct list_head *head, bool flush_htable)
 {
 	struct ima_queue_entry *qe, *qe_tmp;
-- 
2.43.0



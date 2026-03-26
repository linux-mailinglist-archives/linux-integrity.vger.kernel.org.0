Return-Path: <linux-integrity+bounces-9099-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABN8EdBuxWl1+AQAu9opvQ
	(envelope-from <linux-integrity+bounces-9099-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Mar 2026 18:37:20 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A124B3393DF
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Mar 2026 18:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AE90301CCE0
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Mar 2026 17:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0008042E00E;
	Thu, 26 Mar 2026 17:32:06 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9116C40148F;
	Thu, 26 Mar 2026 17:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774546326; cv=none; b=A+/lgpCCNRge1KB8wcdGd+ESjaTkHuueR31Gmq6w0EfYq5JFepWqQIFp5mxNy9QbWkb0k3aj8Gb+03E0OtEue2wNwhrhoB+jgCNql9za6BD10tj1nZIJougv36uzL1JZueTgQ3Jx6CagDYUZSwKrYsBXRcAnhzon0YdlrSdIDqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774546326; c=relaxed/simple;
	bh=9p7fWaVl7ZEWmOdGITQtOUzcTdTRbGufiwagrCQXlbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jcHY0JJgKhtdi/wLs+tBjI2eN3Rtd9g61+Bx/uTnDN4S6JqJvioDzPpynOJCvQeN6pGw2jq4lLzSNa9RAFlGjyHPVd5AfHbCuTupB1Jvk3Ws92h6rGe6TYjQkaSioKlNvDepLh4VwqnBROFM3sPDsByaJNQFBzBceu6QEDkJagw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.235])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fhW2K6JLrz1HCPs;
	Fri, 27 Mar 2026 01:28:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 28E9B4056A;
	Fri, 27 Mar 2026 01:31:57 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwB3Yu84bcVppGUvAQ--.1881S11;
	Thu, 26 Mar 2026 18:31:56 +0100 (CET)
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
Subject: [PATCH v4 09/13] ima: Add support for staging measurements with prompt
Date: Thu, 26 Mar 2026 18:30:07 +0100
Message-ID: <20260326173011.1191815-10-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:LxC2BwB3Yu84bcVppGUvAQ--.1881S11
X-Coremail-Antispam: 1UD129KBjvAXoW3tw18Cr1DKFW5AF48Zw4kXrb_yoW8CFykWo
	Za9rZ8GF48Wrn3Cw4UKrsxtFy8WFZ5Wws7Jr4rtrs8CF129r15GayIq3WUAa1Iqw4rW34U
	G34kA348ZFs2q3Z3n29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUOo7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF
	0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x02
	67AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F4
	0Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC
	6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxV
	Aaw2AFwI0_Wrv_ZF1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2Iq
	xVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r
	4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY
	6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2js
	IE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIF
	yTuYvjxUVdgAUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAEBGnEnSsT3gAAsX
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[huaweicloud.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lwn.net,linuxfoundation.org,linux.ibm.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9099-lists,linux-integrity=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[roberto.sassu@huaweicloud.com,linux-integrity@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email,huaweicloud.com:mid]
X-Rspamd-Queue-Id: A124B3393DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Roberto Sassu <roberto.sassu@huawei.com>

Introduce the ability of staging the IMA measurement list and deleting them
with a prompt.

Staging means moving the current content of the measurement list to a
separate location, and allowing users to read and delete it. This causes
the measurement list to be atomically truncated before new measurements can
be added. Staging can be done only once at a time. In the event of kexec(),
staging is reverted and staged entries will be carried over to the new
kernel.

Introduce ascii_runtime_measurements_<algo>_staged and
binary_runtime_measurements_<algo>_staged interfaces to stage and delete
the measurements. Use 'echo A > <IMA interface>' and
'echo D > <IMA interface>' to respectively stage and delete the entire
measurements list. Locking of these interfaces is also mediated with a call
to _ima_measurements_open() and with ima_measurements_release().

Implement the staging functionality by introducing the new global
measurements list ima_measurements_staged, and ima_queue_stage() and
ima_queue_delete_staged_all() to respectively move measurements from the
current measurements list to the staged one, and to move staged
measurements to the ima_measurements_trim list for deletion. Introduce
ima_queue_delete() to delete the measurements.

Finally, introduce the BINARY_STAGED AND BINARY_FULL binary measurements
list types, to maintain the counters and the binary size of staged
measurements and the full measurements list (including entries that were
staged). BINARY still represents the current binary measurements list.

Use the binary size for the BINARY + BINARY_STAGED types in
ima_add_kexec_buffer(), since both measurements list types are copied to
the secondary kernel during kexec. Use BINARY_FULL in
ima_measure_kexec_event(), to generate a critical data record.

It should be noted that the BINARY_FULL counter is not passed through
kexec. Thus, the number of entries included in the kexec critical data
records refers to the entries since the previous kexec records.

Note: This code derives from the Alt-IMA Huawei project, whose license is
      GPL-2.0 OR MIT.

Link: https://github.com/linux-integrity/linux/issues/1
Suggested-by: Gregory Lumen <gregorylumen@linux.microsoft.com> (staging revert)
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/Kconfig     |  13 +++
 security/integrity/ima/ima.h       |   8 +-
 security/integrity/ima/ima_fs.c    | 167 ++++++++++++++++++++++++++---
 security/integrity/ima/ima_kexec.c |  22 +++-
 security/integrity/ima/ima_queue.c |  97 ++++++++++++++++-
 5 files changed, 286 insertions(+), 21 deletions(-)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 976e75f9b9ba..e714726f3384 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -332,4 +332,17 @@ config IMA_KEXEC_EXTRA_MEMORY_KB
 	  If set to the default value of 0, an extra half page of memory for those
 	  additional measurements will be allocated.
 
+config IMA_STAGING
+	bool "Support for staging the measurements list"
+	default y
+	help
+	  Add support for staging the measurements list.
+
+	  It allows user space to stage the measurements list for deletion and
+	  to delete the staged measurements after confirmation.
+
+	  On kexec, staging is reverted and staged measurements are prepended
+	  to the current measurements list when measurements are copied to the
+	  secondary kernel.
+
 endif
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 97b7d6024b5d..65db152a0a24 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -30,9 +30,11 @@ enum tpm_pcrs { TPM_PCR0 = 0, TPM_PCR8 = 8, TPM_PCR10 = 10 };
 
 /*
  * BINARY: current binary measurements list
+ * BINARY_STAGED: staged binary measurements list
+ * BINARY_FULL: binary measurements list since IMA init (lost after kexec)
  */
 enum binary_lists {
-	BINARY, BINARY__LAST
+	BINARY, BINARY_STAGED, BINARY_FULL, BINARY__LAST
 };
 
 /* digest size for IMA, fits SHA1 or MD5 */
@@ -125,6 +127,7 @@ struct ima_queue_entry {
 	struct ima_template_entry *entry;
 };
 extern struct list_head ima_measurements;	/* list of all measurements */
+extern struct list_head ima_measurements_staged; /* list of staged meas. */
 
 /* Some details preceding the binary serialized measurement list */
 struct ima_kexec_hdr {
@@ -314,6 +317,8 @@ struct ima_template_desc *ima_template_desc_current(void);
 struct ima_template_desc *ima_template_desc_buf(void);
 struct ima_template_desc *lookup_template_desc(const char *name);
 bool ima_template_has_modsig(const struct ima_template_desc *ima_template);
+int ima_queue_stage(void);
+int ima_queue_staged_delete_all(void);
 int ima_restore_measurement_entry(struct ima_template_entry *entry);
 int ima_restore_measurement_list(loff_t bufsize, void *buf);
 int ima_measurements_show(struct seq_file *m, void *v);
@@ -334,6 +339,7 @@ extern spinlock_t ima_queue_lock;
 extern atomic_long_t ima_num_entries[BINARY__LAST];
 extern atomic_long_t ima_num_violations;
 extern struct hlist_head __rcu *ima_htable;
+extern struct mutex ima_extend_list_mutex;
 
 static inline unsigned int ima_hash_key(u8 *digest)
 {
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 7709a4576322..39d9128e9f22 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -24,6 +24,13 @@
 
 #include "ima.h"
 
+/*
+ * Requests:
+ * 'A\n': stage the entire measurements list
+ * 'D\n': delete all staged measurements
+ */
+#define STAGED_REQ_LENGTH 21
+
 static DEFINE_MUTEX(ima_write_mutex);
 static DEFINE_MUTEX(ima_measure_mutex);
 static long ima_measure_users;
@@ -97,6 +104,11 @@ static void *ima_measurements_start(struct seq_file *m, loff_t *pos)
 	return _ima_measurements_start(m, pos, &ima_measurements);
 }
 
+static void *ima_measurements_staged_start(struct seq_file *m, loff_t *pos)
+{
+	return _ima_measurements_start(m, pos, &ima_measurements_staged);
+}
+
 static void *_ima_measurements_next(struct seq_file *m, void *v, loff_t *pos,
 				    struct list_head *head)
 {
@@ -118,6 +130,12 @@ static void *ima_measurements_next(struct seq_file *m, void *v, loff_t *pos)
 	return _ima_measurements_next(m, v, pos, &ima_measurements);
 }
 
+static void *ima_measurements_staged_next(struct seq_file *m, void *v,
+					  loff_t *pos)
+{
+	return _ima_measurements_next(m, v, pos, &ima_measurements_staged);
+}
+
 static void ima_measurements_stop(struct seq_file *m, void *v)
 {
 }
@@ -283,6 +301,68 @@ static const struct file_operations ima_measurements_ops = {
 	.release = ima_measurements_release,
 };
 
+static const struct seq_operations ima_measurments_staged_seqops = {
+	.start = ima_measurements_staged_start,
+	.next = ima_measurements_staged_next,
+	.stop = ima_measurements_stop,
+	.show = ima_measurements_show
+};
+
+static int ima_measurements_staged_open(struct inode *inode, struct file *file)
+{
+	return _ima_measurements_open(inode, file,
+				      &ima_measurments_staged_seqops);
+}
+
+static ssize_t ima_measurements_staged_write(struct file *file,
+					     const char __user *buf,
+					     size_t datalen, loff_t *ppos)
+{
+	char req[STAGED_REQ_LENGTH];
+	int ret;
+
+	if (*ppos > 0 || datalen < 2 || datalen > STAGED_REQ_LENGTH)
+		return -EINVAL;
+
+	if (copy_from_user(req, buf, datalen) != 0)
+		return -EFAULT;
+
+	if (req[datalen - 1] != '\n')
+		return -EINVAL;
+
+	req[datalen - 1] = '\0';
+
+	switch (req[0]) {
+	case 'A':
+		if (datalen != 2)
+			return -EINVAL;
+
+		ret = ima_queue_stage();
+		break;
+	case 'D':
+		if (datalen != 2)
+			return -EINVAL;
+
+		ret = ima_queue_staged_delete_all();
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	if (ret < 0)
+		return ret;
+
+	return datalen;
+}
+
+static const struct file_operations ima_measurements_staged_ops = {
+	.open = ima_measurements_staged_open,
+	.read = seq_read,
+	.write = ima_measurements_staged_write,
+	.llseek = seq_lseek,
+	.release = ima_measurements_release,
+};
+
 void ima_print_digest(struct seq_file *m, u8 *digest, u32 size)
 {
 	u32 i;
@@ -356,6 +436,28 @@ static const struct file_operations ima_ascii_measurements_ops = {
 	.release = ima_measurements_release,
 };
 
+static const struct seq_operations ima_ascii_measurements_staged_seqops = {
+	.start = ima_measurements_staged_start,
+	.next = ima_measurements_staged_next,
+	.stop = ima_measurements_stop,
+	.show = ima_ascii_measurements_show
+};
+
+static int ima_ascii_measurements_staged_open(struct inode *inode,
+					      struct file *file)
+{
+	return _ima_measurements_open(inode, file,
+				      &ima_ascii_measurements_staged_seqops);
+}
+
+static const struct file_operations ima_ascii_measurements_staged_ops = {
+	.open = ima_ascii_measurements_staged_open,
+	.read = seq_read,
+	.write = ima_measurements_staged_write,
+	.llseek = seq_lseek,
+	.release = ima_measurements_release,
+};
+
 static ssize_t ima_read_policy(char *path)
 {
 	void *data = NULL;
@@ -459,10 +561,21 @@ static const struct seq_operations ima_policy_seqops = {
 };
 #endif
 
-static int __init create_securityfs_measurement_lists(void)
+static int __init create_securityfs_measurement_lists(bool staging)
 {
+	const struct file_operations *ascii_ops = &ima_ascii_measurements_ops;
+	const struct file_operations *binary_ops = &ima_measurements_ops;
+	mode_t permissions = S_IRUSR | S_IRGRP;
+	const char *file_suffix = "";
 	int count = NR_BANKS(ima_tpm_chip);
 
+	if (staging) {
+		ascii_ops = &ima_ascii_measurements_staged_ops;
+		binary_ops = &ima_measurements_staged_ops;
+		file_suffix = "_staged";
+		permissions |= (S_IWUSR | S_IWGRP);
+	}
+
 	if (ima_sha1_idx >= NR_BANKS(ima_tpm_chip))
 		count++;
 
@@ -473,29 +586,32 @@ static int __init create_securityfs_measurement_lists(void)
 
 		if (algo == HASH_ALGO__LAST)
 			snprintf(file_name, sizeof(file_name),
-				 "ascii_runtime_measurements_tpm_alg_%x",
-				 ima_tpm_chip->allocated_banks[i].alg_id);
+				 "ascii_runtime_measurements_tpm_alg_%x%s",
+				 ima_tpm_chip->allocated_banks[i].alg_id,
+				 file_suffix);
 		else
 			snprintf(file_name, sizeof(file_name),
-				 "ascii_runtime_measurements_%s",
-				 hash_algo_name[algo]);
-		dentry = securityfs_create_file(file_name, S_IRUSR | S_IRGRP,
+				 "ascii_runtime_measurements_%s%s",
+				 hash_algo_name[algo], file_suffix);
+		dentry = securityfs_create_file(file_name, permissions,
 						ima_dir, (void *)(uintptr_t)i,
-						&ima_ascii_measurements_ops);
+						ascii_ops);
 		if (IS_ERR(dentry))
 			return PTR_ERR(dentry);
 
 		if (algo == HASH_ALGO__LAST)
 			snprintf(file_name, sizeof(file_name),
-				 "binary_runtime_measurements_tpm_alg_%x",
-				 ima_tpm_chip->allocated_banks[i].alg_id);
+				 "binary_runtime_measurements_tpm_alg_%x%s",
+				 ima_tpm_chip->allocated_banks[i].alg_id,
+				 file_suffix);
 		else
 			snprintf(file_name, sizeof(file_name),
-				 "binary_runtime_measurements_%s",
-				 hash_algo_name[algo]);
-		dentry = securityfs_create_file(file_name, S_IRUSR | S_IRGRP,
+				 "binary_runtime_measurements_%s%s",
+				 hash_algo_name[algo], file_suffix);
+
+		dentry = securityfs_create_file(file_name, permissions,
 						ima_dir, (void *)(uintptr_t)i,
-						&ima_measurements_ops);
+						binary_ops);
 		if (IS_ERR(dentry))
 			return PTR_ERR(dentry);
 	}
@@ -503,6 +619,23 @@ static int __init create_securityfs_measurement_lists(void)
 	return 0;
 }
 
+static int __init create_securityfs_staging_links(void)
+{
+	struct dentry *dentry;
+
+	dentry = securityfs_create_symlink("binary_runtime_measurements_staged",
+		ima_dir, "binary_runtime_measurements_sha1_staged", NULL);
+	if (IS_ERR(dentry))
+		return PTR_ERR(dentry);
+
+	dentry = securityfs_create_symlink("ascii_runtime_measurements_staged",
+		ima_dir, "ascii_runtime_measurements_sha1_staged", NULL);
+	if (IS_ERR(dentry))
+		return PTR_ERR(dentry);
+
+	return 0;
+}
+
 /*
  * ima_open_policy: sequentialize access to the policy file
  */
@@ -595,7 +728,13 @@ int __init ima_fs_init(void)
 		goto out;
 	}
 
-	ret = create_securityfs_measurement_lists();
+	ret = create_securityfs_measurement_lists(false);
+	if (ret == 0 && IS_ENABLED(CONFIG_IMA_STAGING)) {
+		ret = create_securityfs_measurement_lists(true);
+		if (ret == 0)
+			ret = create_securityfs_staging_links();
+	}
+
 	if (ret != 0)
 		goto out;
 
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index d7d0fb639d99..d5503dd5cc9b 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -42,8 +42,8 @@ void ima_measure_kexec_event(const char *event_name)
 	long len;
 	int n;
 
-	buf_size = ima_get_binary_runtime_size(BINARY);
-	len = atomic_long_read(&ima_num_entries[BINARY]);
+	buf_size = ima_get_binary_runtime_size(BINARY_FULL);
+	len = atomic_long_read(&ima_num_entries[BINARY_FULL]);
 
 	n = scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
 		      "kexec_segment_size=%lu;ima_binary_runtime_size=%lu;"
@@ -106,13 +106,26 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
 
 	memset(&khdr, 0, sizeof(khdr));
 	khdr.version = 1;
-	/* This is an append-only list, no need to hold the RCU read lock */
-	list_for_each_entry_rcu(qe, &ima_measurements, later, true) {
+	/* It can race with ima_queue_stage() and ima_queue_delete_staged(). */
+	mutex_lock(&ima_extend_list_mutex);
+
+	list_for_each_entry_rcu(qe, &ima_measurements_staged, later,
+				lockdep_is_held(&ima_extend_list_mutex)) {
 		ret = ima_dump_measurement(&khdr, qe);
 		if (ret < 0)
 			break;
 	}
 
+	list_for_each_entry_rcu(qe, &ima_measurements, later,
+				lockdep_is_held(&ima_extend_list_mutex)) {
+		if (!ret)
+			ret = ima_dump_measurement(&khdr, qe);
+		if (ret < 0)
+			break;
+	}
+
+	mutex_unlock(&ima_extend_list_mutex);
+
 	/*
 	 * fill in reserved space with some buffer details
 	 * (eg. version, buffer size, number of measurements)
@@ -167,6 +180,7 @@ void ima_add_kexec_buffer(struct kimage *image)
 		extra_memory = CONFIG_IMA_KEXEC_EXTRA_MEMORY_KB * 1024;
 
 	binary_runtime_size = ima_get_binary_runtime_size(BINARY) +
+			      ima_get_binary_runtime_size(BINARY_STAGED) +
 			      extra_memory;
 
 	if (binary_runtime_size >= ULONG_MAX - PAGE_SIZE)
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index b6d10dceb669..50519ed837d4 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -26,6 +26,7 @@
 static struct tpm_digest *digests;
 
 LIST_HEAD(ima_measurements);	/* list of all measurements */
+LIST_HEAD(ima_measurements_staged); /* list of staged measurements */
 #ifdef CONFIG_IMA_KEXEC
 static unsigned long binary_runtime_size[BINARY__LAST];
 #else
@@ -45,11 +46,11 @@ atomic_long_t ima_num_violations = ATOMIC_LONG_INIT(0);
 /* key: inode (before secure-hashing a file) */
 struct hlist_head __rcu *ima_htable;
 
-/* mutex protects atomicity of extending measurement list
+/* mutex protects atomicity of extending and staging measurement list
  * and extending the TPM PCR aggregate. Since tpm_extend can take
  * long (and the tpm driver uses a mutex), we can't use the spinlock.
  */
-static DEFINE_MUTEX(ima_extend_list_mutex);
+DEFINE_MUTEX(ima_extend_list_mutex);
 
 /*
  * Used internally by the kernel to suspend measurements.
@@ -174,12 +175,16 @@ static int ima_add_digest_entry(struct ima_template_entry *entry,
 				lockdep_is_held(&ima_extend_list_mutex));
 
 	atomic_long_inc(&ima_num_entries[BINARY]);
+	atomic_long_inc(&ima_num_entries[BINARY_FULL]);
+
 	if (update_htable) {
 		key = ima_hash_key(entry->digests[ima_hash_algo_idx].digest);
 		hlist_add_head_rcu(&qe->hnext, &htable[key]);
 	}
 
 	ima_update_binary_runtime_size(entry, BINARY);
+	ima_update_binary_runtime_size(entry, BINARY_FULL);
+
 	return 0;
 }
 
@@ -280,6 +285,94 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
 	return result;
 }
 
+int ima_queue_stage(void)
+{
+	int ret = 0;
+
+	mutex_lock(&ima_extend_list_mutex);
+	if (!list_empty(&ima_measurements_staged)) {
+		ret = -EEXIST;
+		goto out_unlock;
+	}
+
+	if (list_empty(&ima_measurements)) {
+		ret = -ENOENT;
+		goto out_unlock;
+	}
+
+	list_replace(&ima_measurements, &ima_measurements_staged);
+	INIT_LIST_HEAD(&ima_measurements);
+
+	atomic_long_set(&ima_num_entries[BINARY_STAGED],
+			atomic_long_read(&ima_num_entries[BINARY]));
+	atomic_long_set(&ima_num_entries[BINARY], 0);
+
+	if (IS_ENABLED(CONFIG_IMA_KEXEC)) {
+		binary_runtime_size[BINARY_STAGED] =
+					binary_runtime_size[BINARY];
+		binary_runtime_size[BINARY] = 0;
+	}
+out_unlock:
+	mutex_unlock(&ima_extend_list_mutex);
+	return ret;
+}
+
+static void ima_queue_delete(struct list_head *head);
+
+int ima_queue_staged_delete_all(void)
+{
+	LIST_HEAD(ima_measurements_trim);
+
+	mutex_lock(&ima_extend_list_mutex);
+	if (list_empty(&ima_measurements_staged)) {
+		mutex_unlock(&ima_extend_list_mutex);
+		return -ENOENT;
+	}
+
+	list_replace(&ima_measurements_staged, &ima_measurements_trim);
+	INIT_LIST_HEAD(&ima_measurements_staged);
+
+	atomic_long_set(&ima_num_entries[BINARY_STAGED], 0);
+
+	if (IS_ENABLED(CONFIG_IMA_KEXEC))
+		binary_runtime_size[BINARY_STAGED] = 0;
+
+	mutex_unlock(&ima_extend_list_mutex);
+
+	ima_queue_delete(&ima_measurements_trim);
+	return 0;
+}
+
+static void ima_queue_delete(struct list_head *head)
+{
+	struct ima_queue_entry *qe, *qe_tmp;
+	unsigned int i;
+
+	list_for_each_entry_safe(qe, qe_tmp, head, later) {
+		/*
+		 * Safe to free template_data here without synchronize_rcu()
+		 * because the only htable reader, ima_lookup_digest_entry(),
+		 * accesses only entry->digests, not template_data. If new
+		 * htable readers are added that access template_data, a
+		 * synchronize_rcu() is required here.
+		 */
+		for (i = 0; i < qe->entry->template_desc->num_fields; i++) {
+			kfree(qe->entry->template_data[i].data);
+			qe->entry->template_data[i].data = NULL;
+			qe->entry->template_data[i].len = 0;
+		}
+
+		list_del(&qe->later);
+
+		/* No leak if condition is false, referenced by ima_htable. */
+		if (IS_ENABLED(CONFIG_IMA_DISABLE_HTABLE)) {
+			kfree(qe->entry->digests);
+			kfree(qe->entry);
+			kfree(qe);
+		}
+	}
+}
+
 int ima_restore_measurement_entry(struct ima_template_entry *entry)
 {
 	int result = 0;
-- 
2.43.0



Return-Path: <linux-integrity+bounces-8979-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGThCLmlsWn4EAAAu9opvQ
	(envelope-from <linux-integrity+bounces-8979-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Mar 2026 18:26:17 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC5D267FF5
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Mar 2026 18:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C68D930AC5C9
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Mar 2026 17:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED7F30C621;
	Wed, 11 Mar 2026 17:20:40 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF83230AD05;
	Wed, 11 Mar 2026 17:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773249640; cv=none; b=LduJgN/H44y2uyC3hLFNudjErzFPdi01IerYLjGvanOmvGBZoWD1mNTkxcIfca7CZuLt4elhzMgd6wmusCLfuWeLY3iZab7FsxOQmwVztcWz5/O+83no1E89Hg9GE1pzNK5Fqi7Jwwsg0IqrrkJLqIG6EdURXf30E34vvkbrj7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773249640; c=relaxed/simple;
	bh=kd9+gQRxnwGQNQjIXvjNb95XL+BW+h9kM0t8vjyUaa4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RH1qMZZnSiM4Yfv7jjndLAlgxvhKn83cve/YW8LDEGwQj9MaVjxTptv3JcMPuNEvydV2O39huxe9BCuLKtY/w5yOSwYelz2vZIIkjrZGVMviNN4dDgbOM+7AWtlwsoiCHd3ya/RetEbDjz8E9YSsUxLnsemeWp3umxULX+RcXwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.196])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTPS id 4fWHVV40q0zpVG8;
	Thu, 12 Mar 2026 01:17:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 3A8F540568;
	Thu, 12 Mar 2026 01:20:36 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwDXp4RIpLFpppJGAA--.17394S4;
	Wed, 11 Mar 2026 18:20:35 +0100 (CET)
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
Subject: [PATCH v3 3/3] ima: Add support for staging measurements for deletion
Date: Wed, 11 Mar 2026 18:19:56 +0100
Message-ID: <20260311171956.2317781-3-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311171956.2317781-1-roberto.sassu@huaweicloud.com>
References: <20260311171956.2317781-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwDXp4RIpLFpppJGAA--.17394S4
X-Coremail-Antispam: 1UD129KBjvAXoWfAFWfKF4fuF4kCrWxXw1UZFb_yoW5CF13Go
	Za9FZ8GF48Grn5Cw4UKrsxtFy8WFZ8Wws7tr48trs8uF17Wr15KayxX3WUA3WIqw4Fgry7
	Gw1kA348XFZ2qwn3n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUOb7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr
	yl82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFSdy
	UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAJBGmw1qwJZQADsD
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[huaweicloud.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lwn.net,linuxfoundation.org,linux.ibm.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8979-lists,linux-integrity=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.711];
	FROM_NEQ_ENVFROM(0.00)[roberto.sassu@huaweicloud.com,linux-integrity@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huaweicloud.com:mid]
X-Rspamd-Queue-Id: 8AC5D267FF5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Roberto Sassu <roberto.sassu@huawei.com>

Introduce the ability of staging the IMA measurement list for deletion.
Staging means moving the current content of the measurement list to a
separate location, and allowing users to read and delete it. This causes
the measurement list to be atomically truncated before new measurements can
be added. Staging can be done only once at a time. In the event of kexec(),
staging is reverted and staged entries will be carried over to the new
kernel.

Staged measurements can be deleted entirely, or partially, with the
non-deleted ones added back to the IMA measurements list. This allows the
remote attestation agents to easily separate the measurements that where
verified (staged and deleted) from those that weren't due to the race
between taking a TPM quote and reading the measurements list.

User space is responsible to concatenate the staged IMA measurements list
portions (excluding the measurements added back to the IMA measurements
list) following the temporal order in which the operations were done,
together with the current measurement list. Then, it can send the collected
data to the remote verifiers.

The benefit of staging and deleting is the ability to free precious kernel
memory, in exchange of delegating user space to reconstruct the full
measurement list from the chunks. No trust needs to be given to user space,
since the integrity of the measurement list is protected by the TPM.

By default, staging the measurements list does not alter the hash table.
When staging and deleting are done, IMA is still able to detect collisions
on the staged and later deleted measurement entries, by keeping the entry
digests (only template data are freed).

However, since during the measurements list serialization only the SHA1
digest is passed, and since there are no template data to recalculate the
other digests from, the hash table is currently not populated with digests
from staged/deleted entries after kexec().

Introduce the new kernel option ima_flush_htable to decide whether or not
the digests of staged measurement entries are flushed from the hash table,
when they are deleted. Flushing the hash table is supported only when
deleting all the staged measurements, since in that case the old hash table
can be quickly swapped with a blank one (otherwise entries would have to be
removed one by one for partial deletion).

Then, introduce ascii_runtime_measurements_<algo>_staged and
binary_runtime_measurements_<algo>_staged interfaces to stage and delete
the measurements. Use 'echo A > <IMA interface>' and
'echo D > <IMA interface>' to respectively stage and delete the entire
measurements list. Use 'echo N > <IMA interface>', with N between 1 and
ULONG_MAX - 1, to delete the selected staged portion of the measurements
list.

The ima_measure_users counter (protected by the ima_measure_mutex mutex)
has been introduced to protect access to the measurements list and the
staged part. The open method of all the measurement interfaces has been
extended to allow only one writer at a time or, in alternative, multiple
readers. The write permission is used to stage and delete the measurements,
the read permission to read them. Write requires also the CAP_SYS_ADMIN
capability.

Finally, introduce the binary_lists enum and make binary_runtime_size
and ima_num_entries as arrays, to keep track of their values for the
current IMA measurements list (BINARY), current list plus staged
measurements (BINARY_STAGED) and the cumulative list since IMA
initialization (BINARY_FULL).

Use BINARY in ima_show_measurements_count(), BINARY_STAGED in
ima_add_kexec_buffer() and BINARY_FULL in ima_measure_kexec_event().

It should be noted that the BINARY_FULL counter is not passed through
kexec. Thus, the number of entries included in the kexec critical data
records refers to the entries since the previous kexec records.

Note: This code derives from the Alt-IMA Huawei project, whose license is
      GPL-2.0 OR MIT.

Link: https://github.com/linux-integrity/linux/issues/1
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
Changelog
v2:
 - Forbid partial deletion when flushing hash table (suggested by Mimi)
 - Ignore ima_flush_htable if CONFIG_IMA_DISABLE_HTABLE is enabled
 - BINARY_SIZE_* renamed to BINARY_* for better clarity
 - Removed ima_measurements_staged_exist and testing list empty instead
 - ima_queue_stage_trim() and ima_queue_delete_staged_trimmed() renamed to
   ima_queue_stage() and ima_queue_delete_staged()
 - New delete interval [1, ULONG_MAX - 1]
 - Rename ima_measure_lock to ima_measure_mutex
 - Move seq_open() and seq_release() outside the ima_measure_mutex lock
 - Drop ima_measurements_staged_read() and use seq_read() instead
 - Optimize create_securityfs_measurement_lists() changes
 - New file name format with _staged suffix at the end of the file name
 - Use _rcu list variant in ima_dump_measurement_list()
 - Remove support for direct trimming and splice the remaining entries to
   the active list (suggested by Mimi)
 - Hot swap the hash table if flushing is requested

v1:
 - Support for direct trimming without staging
 - Support unstaging on kexec (requested by Gregory Lumen)
---
 .../admin-guide/kernel-parameters.txt         |   4 +
 security/integrity/ima/ima.h                  |  17 +-
 security/integrity/ima/ima_fs.c               | 266 ++++++++++++++++--
 security/integrity/ima/ima_kexec.c            |  43 ++-
 security/integrity/ima/ima_queue.c            | 205 +++++++++++++-
 5 files changed, 484 insertions(+), 51 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index cb850e5290c2..7a377812aa0a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2345,6 +2345,10 @@ Kernel parameters
 			Use the canonical format for the binary runtime
 			measurements, instead of host native format.
 
+	ima_flush_htable  [IMA]
+			Flush the IMA hash table when deleting all the
+			staged measurement entries.
+
 	ima_hash=	[IMA]
 			Format: { md5 | sha1 | rmd160 | sha256 | sha384
 				   | sha512 | ... }
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index ccd037d49de7..e8aaf1e62139 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -28,6 +28,15 @@ enum ima_show_type { IMA_SHOW_BINARY, IMA_SHOW_BINARY_NO_FIELD_LEN,
 		     IMA_SHOW_BINARY_OLD_STRING_FMT, IMA_SHOW_ASCII };
 enum tpm_pcrs { TPM_PCR0 = 0, TPM_PCR8 = 8, TPM_PCR10 = 10 };
 
+/*
+ * BINARY: current binary measurements list
+ * BINARY_STAGED: current binary measurements list + staged entries
+ * BINARY_FULL: binary measurements list since IMA init (lost after kexec)
+ */
+enum binary_lists {
+	BINARY, BINARY_STAGED, BINARY_FULL, BINARY__LAST
+};
+
 /* digest size for IMA, fits SHA1 or MD5 */
 #define IMA_DIGEST_SIZE		SHA1_DIGEST_SIZE
 #define IMA_EVENT_NAME_LEN_MAX	255
@@ -118,6 +127,7 @@ struct ima_queue_entry {
 	struct ima_template_entry *entry;
 };
 extern struct list_head ima_measurements;	/* list of all measurements */
+extern struct list_head ima_measurements_staged; /* list of staged meas. */
 
 /* Some details preceding the binary serialized measurement list */
 struct ima_kexec_hdr {
@@ -282,11 +292,13 @@ struct ima_template_desc *ima_template_desc_current(void);
 struct ima_template_desc *ima_template_desc_buf(void);
 struct ima_template_desc *lookup_template_desc(const char *name);
 bool ima_template_has_modsig(const struct ima_template_desc *ima_template);
+int ima_queue_stage(void);
+int ima_queue_delete_staged(unsigned long req_value);
 int ima_restore_measurement_entry(struct ima_template_entry *entry);
 int ima_restore_measurement_list(loff_t bufsize, void *buf);
 int ima_measurements_show(struct seq_file *m, void *v);
 int __init ima_init_htable(void);
-unsigned long ima_get_binary_runtime_size(void);
+unsigned long ima_get_binary_runtime_size(enum binary_lists binary_list);
 int ima_init_template(void);
 void ima_init_template_list(void);
 int __init ima_init_digests(void);
@@ -299,9 +311,10 @@ int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
  */
 extern spinlock_t ima_queue_lock;
 
-extern atomic_long_t ima_num_entries;
+extern atomic_long_t ima_num_entries[BINARY__LAST];
 extern atomic_long_t ima_num_violations;
 extern struct hlist_head __rcu *ima_htable;
+extern struct mutex ima_extend_list_mutex;
 
 static inline unsigned int ima_hash_key(u8 *digest)
 {
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index aaa460d70ff7..cf85b0892275 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -24,7 +24,17 @@
 
 #include "ima.h"
 
+/*
+ * Requests:
+ * 'A\n': stage the entire measurements list
+ * 'D\n': delete all staged measurements
+ * '[1, ULONG_MAX - 1]\n' delete N measurements entries and unstage the rest
+ */
+#define STAGED_REQ_LENGTH 21
+
 static DEFINE_MUTEX(ima_write_mutex);
+static DEFINE_MUTEX(ima_measure_mutex);
+static long ima_measure_users;
 
 bool ima_canonical_fmt;
 static int __init default_canonical_fmt_setup(char *str)
@@ -63,7 +73,7 @@ static ssize_t ima_show_measurements_count(struct file *filp,
 					   char __user *buf,
 					   size_t count, loff_t *ppos)
 {
-	return ima_show_counter(buf, count, ppos, &ima_num_entries);
+	return ima_show_counter(buf, count, ppos, &ima_num_entries[BINARY]);
 
 }
 
@@ -73,14 +83,15 @@ static const struct file_operations ima_measurements_count_ops = {
 };
 
 /* returns pointer to hlist_node */
-static void *ima_measurements_start(struct seq_file *m, loff_t *pos)
+static void *_ima_measurements_start(struct seq_file *m, loff_t *pos,
+				     struct list_head *head)
 {
 	loff_t l = *pos;
 	struct ima_queue_entry *qe;
 
 	/* we need a lock since pos could point beyond last element */
 	rcu_read_lock();
-	list_for_each_entry_rcu(qe, &ima_measurements, later) {
+	list_for_each_entry_rcu(qe, head, later) {
 		if (!l--) {
 			rcu_read_unlock();
 			return qe;
@@ -90,7 +101,18 @@ static void *ima_measurements_start(struct seq_file *m, loff_t *pos)
 	return NULL;
 }
 
-static void *ima_measurements_next(struct seq_file *m, void *v, loff_t *pos)
+static void *ima_measurements_start(struct seq_file *m, loff_t *pos)
+{
+	return _ima_measurements_start(m, pos, &ima_measurements);
+}
+
+static void *ima_measurements_staged_start(struct seq_file *m, loff_t *pos)
+{
+	return _ima_measurements_start(m, pos, &ima_measurements_staged);
+}
+
+static void *_ima_measurements_next(struct seq_file *m, void *v, loff_t *pos,
+				    struct list_head *head)
 {
 	struct ima_queue_entry *qe = v;
 
@@ -102,7 +124,18 @@ static void *ima_measurements_next(struct seq_file *m, void *v, loff_t *pos)
 	rcu_read_unlock();
 	(*pos)++;
 
-	return (&qe->later == &ima_measurements) ? NULL : qe;
+	return (&qe->later == head) ? NULL : qe;
+}
+
+static void *ima_measurements_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	return _ima_measurements_next(m, v, pos, &ima_measurements);
+}
+
+static void *ima_measurements_staged_next(struct seq_file *m, void *v,
+					  loff_t *pos)
+{
+	return _ima_measurements_next(m, v, pos, &ima_measurements_staged);
 }
 
 static void ima_measurements_stop(struct seq_file *m, void *v)
@@ -198,16 +231,145 @@ static const struct seq_operations ima_measurments_seqops = {
 	.show = ima_measurements_show
 };
 
+static int ima_measure_lock(bool write)
+{
+	mutex_lock(&ima_measure_mutex);
+	if ((write && ima_measure_users != 0) ||
+	    (!write && ima_measure_users < 0)) {
+		mutex_unlock(&ima_measure_mutex);
+		return -EBUSY;
+	}
+
+	if (write)
+		ima_measure_users--;
+	else
+		ima_measure_users++;
+	mutex_unlock(&ima_measure_mutex);
+	return 0;
+}
+
+static void ima_measure_unlock(bool write)
+{
+	mutex_lock(&ima_measure_mutex);
+	if (write)
+		ima_measure_users++;
+	else
+		ima_measure_users--;
+	mutex_unlock(&ima_measure_mutex);
+}
+
+static int _ima_measurements_open(struct inode *inode, struct file *file,
+				  const struct seq_operations *seq_ops)
+{
+	bool write = (file->f_mode & FMODE_WRITE);
+	int ret;
+
+	if (write && !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	ret = ima_measure_lock(write);
+	if (ret < 0)
+		return ret;
+
+	ret = seq_open(file, seq_ops);
+	if (ret < 0)
+		ima_measure_unlock(write);
+
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
+	bool write = (file->f_mode & FMODE_WRITE);
+	int ret;
+
+	ret = seq_release(inode, file);
+
+	ima_measure_unlock(write);
+
+	return ret;
 }
 
 static const struct file_operations ima_measurements_ops = {
 	.open = ima_measurements_open,
 	.read = seq_read,
 	.llseek = seq_lseek,
-	.release = seq_release,
+	.release = ima_measurements_release,
+};
+
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
+	unsigned long req_value;
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
+		ret = ima_queue_delete_staged(ULONG_MAX);
+		break;
+	default:
+		ret = kstrtoul(req, 10, &req_value);
+		if (ret < 0)
+			return ret;
+
+		if (req_value == ULONG_MAX)
+			return -ERANGE;
+
+		ret = ima_queue_delete_staged(req_value);
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
 };
 
 void ima_print_digest(struct seq_file *m, u8 *digest, u32 size)
@@ -272,14 +434,37 @@ static const struct seq_operations ima_ascii_measurements_seqops = {
 
 static int ima_ascii_measurements_open(struct inode *inode, struct file *file)
 {
-	return seq_open(file, &ima_ascii_measurements_seqops);
+	return _ima_measurements_open(inode, file,
+				      &ima_ascii_measurements_seqops);
 }
 
 static const struct file_operations ima_ascii_measurements_ops = {
 	.open = ima_ascii_measurements_open,
 	.read = seq_read,
 	.llseek = seq_lseek,
-	.release = seq_release,
+	.release = ima_measurements_release,
+};
+
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
 };
 
 static ssize_t ima_read_policy(char *path)
@@ -385,10 +570,21 @@ static const struct seq_operations ima_policy_seqops = {
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
+		permissions |= S_IWUSR | S_IWGRP;
+	}
+
 	if (ima_sha1_idx >= NR_BANKS(ima_tpm_chip))
 		count++;
 
@@ -398,26 +594,33 @@ static int __init create_securityfs_measurement_lists(void)
 		struct dentry *dentry;
 
 		if (algo == HASH_ALGO__LAST)
-			sprintf(file_name, "ascii_runtime_measurements_tpm_alg_%x",
-				ima_tpm_chip->allocated_banks[i].alg_id);
+			snprintf(file_name, sizeof(file_name),
+				 "ascii_runtime_measurements_tpm_alg_%x%s",
+				 ima_tpm_chip->allocated_banks[i].alg_id,
+				 file_suffix);
 		else
-			sprintf(file_name, "ascii_runtime_measurements_%s",
-				hash_algo_name[algo]);
-		dentry = securityfs_create_file(file_name, S_IRUSR | S_IRGRP,
+			snprintf(file_name, sizeof(file_name),
+				 "ascii_runtime_measurements_%s%s",
+				 hash_algo_name[algo], file_suffix);
+		dentry = securityfs_create_file(file_name, permissions,
 						ima_dir, (void *)(uintptr_t)i,
-						&ima_ascii_measurements_ops);
+						ascii_ops);
 		if (IS_ERR(dentry))
 			return PTR_ERR(dentry);
 
 		if (algo == HASH_ALGO__LAST)
-			sprintf(file_name, "binary_runtime_measurements_tpm_alg_%x",
-				ima_tpm_chip->allocated_banks[i].alg_id);
+			snprintf(file_name, sizeof(file_name),
+				 "binary_runtime_measurements_tpm_alg_%x%s",
+				 ima_tpm_chip->allocated_banks[i].alg_id,
+				 file_suffix);
 		else
-			sprintf(file_name, "binary_runtime_measurements_%s",
-				hash_algo_name[algo]);
-		dentry = securityfs_create_file(file_name, S_IRUSR | S_IRGRP,
+			snprintf(file_name, sizeof(file_name),
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
@@ -517,7 +720,10 @@ int __init ima_fs_init(void)
 		goto out;
 	}
 
-	ret = create_securityfs_measurement_lists();
+	ret = create_securityfs_measurement_lists(false);
+	if (ret == 0)
+		ret = create_securityfs_measurement_lists(true);
+
 	if (ret != 0)
 		goto out;
 
@@ -535,6 +741,20 @@ int __init ima_fs_init(void)
 		goto out;
 	}
 
+	dentry = securityfs_create_symlink("binary_runtime_measurements_staged",
+		ima_dir, "binary_runtime_measurements_sha1_staged", NULL);
+	if (IS_ERR(dentry)) {
+		ret = PTR_ERR(dentry);
+		goto out;
+	}
+
+	dentry = securityfs_create_symlink("ascii_runtime_measurements_staged",
+		ima_dir, "ascii_runtime_measurements_sha1_staged", NULL);
+	if (IS_ERR(dentry)) {
+		ret = PTR_ERR(dentry);
+		goto out;
+	}
+
 	dentry = securityfs_create_file("runtime_measurements_count",
 				   S_IRUSR | S_IRGRP, ima_dir, NULL,
 				   &ima_measurements_count_ops);
diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 5801649fbbef..70ee3a039df2 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -42,8 +42,8 @@ void ima_measure_kexec_event(const char *event_name)
 	long len;
 	int n;
 
-	buf_size = ima_get_binary_runtime_size();
-	len = atomic_long_read(&ima_num_entries);
+	buf_size = ima_get_binary_runtime_size(BINARY_FULL);
+	len = atomic_long_read(&ima_num_entries[BINARY_FULL]);
 
 	n = scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
 		      "kexec_segment_size=%lu;ima_binary_runtime_size=%lu;"
@@ -80,6 +80,17 @@ static int ima_alloc_kexec_file_buf(size_t segment_size)
 	return 0;
 }
 
+static int ima_dump_measurement(struct ima_kexec_hdr *khdr,
+				struct ima_queue_entry *qe)
+{
+	if (ima_kexec_file.count >= ima_kexec_file.size)
+		return -EINVAL;
+
+	khdr->count++;
+	ima_measurements_show(&ima_kexec_file, qe);
+	return 0;
+}
+
 static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
 				     unsigned long segment_size)
 {
@@ -95,17 +106,26 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
 
 	memset(&khdr, 0, sizeof(khdr));
 	khdr.version = 1;
-	/* This is an append-only list, no need to hold the RCU read lock */
-	list_for_each_entry_rcu(qe, &ima_measurements, later, true) {
-		if (ima_kexec_file.count < ima_kexec_file.size) {
-			khdr.count++;
-			ima_measurements_show(&ima_kexec_file, qe);
-		} else {
-			ret = -EINVAL;
+	/* It can race with ima_queue_stage() and ima_queue_delete_staged(). */
+	mutex_lock(&ima_extend_list_mutex);
+
+	list_for_each_entry_rcu(qe, &ima_measurements_staged, later,
+				lockdep_is_held(&ima_extend_list_mutex)) {
+		ret = ima_dump_measurement(&khdr, qe);
+		if (ret < 0)
 			break;
-		}
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
@@ -159,7 +179,8 @@ void ima_add_kexec_buffer(struct kimage *image)
 	else
 		extra_memory = CONFIG_IMA_KEXEC_EXTRA_MEMORY_KB * 1024;
 
-	binary_runtime_size = ima_get_binary_runtime_size() + extra_memory;
+	binary_runtime_size = ima_get_binary_runtime_size(BINARY_STAGED) +
+			      extra_memory;
 
 	if (binary_runtime_size >= ULONG_MAX - PAGE_SIZE)
 		kexec_segment_size = ULONG_MAX;
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 2050b9d21e70..08cd60fa959e 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -22,29 +22,48 @@
 
 #define AUDIT_CAUSE_LEN_MAX 32
 
+bool ima_flush_htable;
+static int __init ima_flush_htable_setup(char *str)
+{
+	if (IS_ENABLED(CONFIG_IMA_DISABLE_HTABLE)) {
+		pr_warn("Hash table not enabled, ignoring request to flush\n");
+		return 1;
+	}
+
+	ima_flush_htable = true;
+	return 1;
+}
+__setup("ima_flush_htable", ima_flush_htable_setup);
+
 /* pre-allocated array of tpm_digest structures to extend a PCR */
 static struct tpm_digest *digests;
 
 LIST_HEAD(ima_measurements);	/* list of all measurements */
+LIST_HEAD(ima_measurements_staged); /* list of staged measurements */
 #ifdef CONFIG_IMA_KEXEC
-static unsigned long binary_runtime_size;
+static unsigned long binary_runtime_size[BINARY__LAST];
 #else
-static unsigned long binary_runtime_size = ULONG_MAX;
+static unsigned long binary_runtime_size[BINARY__LAST] = {
+	[0 ... BINARY__LAST - 1] = ULONG_MAX
+};
 #endif
 
 /* num of stored meas. in the list */
-atomic_long_t ima_num_entries = ATOMIC_LONG_INIT(0);
+atomic_long_t ima_num_entries[BINARY__LAST] = {
+	[0 ... BINARY__LAST - 1] = ATOMIC_LONG_INIT(0)
+};
+
 /* num of violations in the list */
 atomic_long_t ima_num_violations = ATOMIC_LONG_INIT(0);
 
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
@@ -140,7 +159,7 @@ static int ima_add_digest_entry(struct ima_template_entry *entry,
 {
 	struct ima_queue_entry *qe;
 	struct hlist_head *htable;
-	unsigned int key;
+	unsigned int key, i;
 
 	qe = kmalloc_obj(*qe);
 	if (qe == NULL) {
@@ -155,19 +174,25 @@ static int ima_add_digest_entry(struct ima_template_entry *entry,
 	htable = rcu_dereference_protected(ima_htable,
 				lockdep_is_held(&ima_extend_list_mutex));
 
-	atomic_long_inc(&ima_num_entries);
+	for (i = 0; i < BINARY__LAST; i++)
+		atomic_long_inc(&ima_num_entries[i]);
+
 	if (update_htable) {
 		key = ima_hash_key(entry->digests[ima_hash_algo_idx].digest);
 		hlist_add_head_rcu(&qe->hnext, &htable[key]);
 	}
 
-	if (binary_runtime_size != ULONG_MAX) {
-		int size;
+	for (i = 0; i < BINARY__LAST; i++) {
+		if (binary_runtime_size[i] != ULONG_MAX) {
+			int size;
 
-		size = get_binary_runtime_size(entry);
-		binary_runtime_size = (binary_runtime_size < ULONG_MAX - size) ?
-		     binary_runtime_size + size : ULONG_MAX;
+			size = get_binary_runtime_size(entry);
+			binary_runtime_size[i] =
+				(binary_runtime_size[i] < ULONG_MAX - size) ?
+				binary_runtime_size[i] + size : ULONG_MAX;
+		}
 	}
+
 	return 0;
 }
 
@@ -176,12 +201,18 @@ static int ima_add_digest_entry(struct ima_template_entry *entry,
  * entire binary_runtime_measurement list, including the ima_kexec_hdr
  * structure.
  */
-unsigned long ima_get_binary_runtime_size(void)
+unsigned long ima_get_binary_runtime_size(enum binary_lists binary_list)
 {
-	if (binary_runtime_size >= (ULONG_MAX - sizeof(struct ima_kexec_hdr)))
+	unsigned long val;
+
+	mutex_lock(&ima_extend_list_mutex);
+	val = binary_runtime_size[binary_list];
+	mutex_unlock(&ima_extend_list_mutex);
+
+	if (val >= (ULONG_MAX - sizeof(struct ima_kexec_hdr)))
 		return ULONG_MAX;
 	else
-		return binary_runtime_size + sizeof(struct ima_kexec_hdr);
+		return val + sizeof(struct ima_kexec_hdr);
 }
 
 static int ima_pcr_extend(struct tpm_digest *digests_arg, int pcr)
@@ -262,6 +293,150 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
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
+	atomic_long_set(&ima_num_entries[BINARY], 0);
+	if (IS_ENABLED(CONFIG_IMA_KEXEC))
+		binary_runtime_size[BINARY] = 0;
+out_unlock:
+	mutex_unlock(&ima_extend_list_mutex);
+	return ret;
+}
+
+int ima_queue_delete_staged(unsigned long req_value)
+{
+	unsigned long req_value_copy = req_value;
+	unsigned long size_to_remove = 0, num_to_remove = 0;
+	struct ima_queue_entry *qe, *qe_tmp;
+	struct list_head *cut_pos = NULL;
+	LIST_HEAD(ima_measurements_trim);
+	struct hlist_head *old_queue = NULL;
+	unsigned int i;
+
+	if (req_value == 0) {
+		pr_err("Must delete at least one entry\n");
+		return -EINVAL;
+	}
+
+	if (req_value < ULONG_MAX && ima_flush_htable) {
+		pr_err("Deleting staged N measurements not supported when flushing the hash table is requested\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Safe walk (no concurrent write), not under ima_extend_list_mutex
+	 * for performance reasons.
+	 */
+	list_for_each_entry(qe, &ima_measurements_staged, later) {
+		size_to_remove += get_binary_runtime_size(qe->entry);
+		num_to_remove++;
+
+		if (req_value < ULONG_MAX && --req_value_copy == 0) {
+			/* qe->later always points to a valid list entry. */
+			cut_pos = &qe->later;
+			break;
+		}
+	}
+
+	if (req_value < ULONG_MAX && req_value_copy > 0)
+		return -ENOENT;
+
+	mutex_lock(&ima_extend_list_mutex);
+	if (list_empty(&ima_measurements_staged)) {
+		mutex_unlock(&ima_extend_list_mutex);
+		return -ENOENT;
+	}
+
+	if (req_value < ULONG_MAX) {
+		/*
+		 * ima_dump_measurement_list() does not modify the list,
+		 * cut_pos remains the same even if it was computed before
+		 * the lock.
+		 */
+		__list_cut_position(&ima_measurements_trim,
+				    &ima_measurements_staged, cut_pos);
+	} else {
+		list_replace(&ima_measurements_staged, &ima_measurements_trim);
+		INIT_LIST_HEAD(&ima_measurements_staged);
+	}
+
+	atomic_long_sub(num_to_remove, &ima_num_entries[BINARY_STAGED]);
+	atomic_long_add(atomic_long_read(&ima_num_entries[BINARY_STAGED]),
+			&ima_num_entries[BINARY]);
+	atomic_long_set(&ima_num_entries[BINARY_STAGED],
+			atomic_long_read(&ima_num_entries[BINARY]));
+
+	if (IS_ENABLED(CONFIG_IMA_KEXEC)) {
+		binary_runtime_size[BINARY_STAGED] -= size_to_remove;
+		binary_runtime_size[BINARY] +=
+					binary_runtime_size[BINARY_STAGED];
+		binary_runtime_size[BINARY_STAGED] =
+					binary_runtime_size[BINARY];
+	}
+
+	if (ima_flush_htable) {
+		old_queue = ima_alloc_replace_htable();
+		if (IS_ERR(old_queue)) {
+			mutex_unlock(&ima_extend_list_mutex);
+			return PTR_ERR(old_queue);
+		}
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
+	if (ima_flush_htable) {
+		synchronize_rcu();
+		kfree(old_queue);
+	}
+
+	list_for_each_entry_safe(qe, qe_tmp, &ima_measurements_trim, later) {
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
+		/* No leak if !ima_flush_htable, referenced by ima_htable. */
+		if (ima_flush_htable) {
+			kfree(qe->entry->digests);
+			kfree(qe->entry);
+			kfree(qe);
+		}
+	}
+
+	return 0;
+}
+
 int ima_restore_measurement_entry(struct ima_template_entry *entry)
 {
 	int result = 0;
-- 
2.43.0



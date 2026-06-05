Return-Path: <linux-integrity+bounces-9755-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FbeQJQcNI2rBhAEAu9opvQ
	(envelope-from <linux-integrity+bounces-9755-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 05 Jun 2026 19:53:11 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1270064A55C
	for <lists+linux-integrity@lfdr.de>; Fri, 05 Jun 2026 19:53:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9755-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9755-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A727E305129C
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Jun 2026 17:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DFA382F26;
	Fri,  5 Jun 2026 17:23:27 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E69390616;
	Fri,  5 Jun 2026 17:23:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780680207; cv=none; b=IQbtSMNDN8/FZKQsP/gZEeq+cpFIFYQWkxVQ7fMgsOJ0BCF0nKU9T1lcX5/fYZeh/kdV+MHH2SKiSVhiErHWfdkOvenKLuV3xnlo+RhUp9MMpRUAG5LGIfVUL5B6GkcVWd5WkbL3IBG8VZk3aummztZkOKp6IswDpCUANLaL8SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780680207; c=relaxed/simple;
	bh=BNA2CUESf+yHW0POrSULtI1TMqwIbV68I0AGqtEn3fU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zw2J9jp8/vPm2IGJ2vU1xoL1Fa0nm3EpLMUY8mpQq82oBoR6KIhH1C+E1eH1IBZb/+z8i4tEyJxRDjuixe4d0DDgVoDt3BFIz6ncYYyM05KlOp9NxMuNAI08rvwW6iMj5jvuXsTharUUfvbwwEXGFtJIRxlY8J5fcaUFvgvw7Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Received: from mail.maildlp.com (unknown [172.18.224.196])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gX7Rp0xdnz1HCnD;
	Sat,  6 Jun 2026 01:17:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 01ADC4056C;
	Sat,  6 Jun 2026 01:23:17 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwBHV43pBSNqZAhlAA--.46721S4;
	Fri, 05 Jun 2026 18:23:16 +0100 (CET)
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
Subject: [PATCH v7 02/12] ima: Replace static htable queue with dynamically allocated array
Date: Fri,  5 Jun 2026 19:22:26 +0200
Message-ID: <20260605172236.2042045-3-roberto.sassu@huaweicloud.com>
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
X-CM-TRANSID:GxC2BwBHV43pBSNqZAhlAA--.46721S4
X-Coremail-Antispam: 1UD129KBjvJXoW3Xw1fuw45Kr1fCr4rKryxGrg_yoWxAF18pa
	9rWFy7Kr48AFWxKr97JaySkr4fursYgryUG398G3sYk3W3Ar1Igr1fGFy2vF98ArZ5J3WS
	qr4jq3Z8CwsYyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
	JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxV
	WUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UCZXrU
	UUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAPBGoiOzcKjwABsJ
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
	TAGGED_FROM(0.00)[bounces-9755-lists,linux-integrity=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	R_DKIM_NA(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huaweicloud.com:from_mime,huaweicloud.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1270064A55C
X-Spam: Yes

From: Roberto Sassu <roberto.sassu@huawei.com>

The IMA hash table is a fixed-size array of hlist_head buckets:

    struct hlist_head ima_htable[IMA_MEASURE_HTABLE_SIZE];

IMA_MEASURE_HTABLE_SIZE is (1 << IMA_HASH_BITS) = 1024 buckets, each a
struct hlist_head (one pointer, 8 bytes on 64-bit). That is 8 KiB allocated
in BSS for every kernel, regardless of whether IMA is ever used, and
regardless of how many measurements are actually made.

Replace the fixed-size array with a RCU-protected pointer to a dynamically
allocated array that is initialized in ima_init_htable(), which is called
from ima_init() during early boot. ima_init_htable() calls the static
function ima_alloc_replace_htable() which, other than initializing the hash
table the first time, can also hot-swap the existing hash table with a
blank one.

The allocation in ima_alloc_replace_htable() uses kcalloc() so the buckets
are zero-initialised (equivalent to HLIST_HEAD_INIT { .first = NULL }).
Callers of ima_alloc_replace_htable() must call synchronize_rcu() and free
the returned hash table.

Finally, access the hash table with rcu_dereference() in
ima_lookup_digest_entry() (reader side) and with
rcu_dereference_protected() in ima_add_digest_entry() (writer side).

No functional change: bucket count, hash function, and all locking remain
identical.

Link: https://github.com/linux-integrity/linux/issues/1
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/ima/ima.h       |  3 +-
 security/integrity/ima/ima_init.c  |  5 ++++
 security/integrity/ima/ima_queue.c | 48 ++++++++++++++++++++++++++----
 3 files changed, 50 insertions(+), 6 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index b3ad7eac6a1e..0e41c2113efd 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -311,6 +311,7 @@ bool ima_template_has_modsig(const struct ima_template_desc *ima_template);
 int ima_restore_measurement_entry(struct ima_template_entry *entry);
 int ima_restore_measurement_list(loff_t bufsize, void *buf);
 int ima_measurements_show(struct seq_file *m, void *v);
+int __init ima_init_htable(void);
 unsigned long ima_get_binary_runtime_size(void);
 int ima_init_template(void);
 void ima_init_template_list(void);
@@ -328,7 +329,7 @@ extern spinlock_t ima_queue_lock;
 extern atomic_long_t ima_num_records;
 /* Total number of violations since hard boot. */
 extern atomic_long_t ima_num_violations;
-extern struct hlist_head ima_htable[IMA_MEASURE_HTABLE_SIZE];
+extern struct hlist_head __rcu *ima_htable;
 
 static inline unsigned int ima_hash_key(u8 *digest)
 {
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index a2f34f2d8ad7..7e0aa09a12e6 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -140,6 +140,11 @@ int __init ima_init(void)
 	rc = ima_init_digests();
 	if (rc != 0)
 		return rc;
+
+	rc = ima_init_htable();
+	if (rc != 0)
+		return rc;
+
 	rc = ima_add_boot_aggregate();	/* boot aggregate must be first entry */
 	if (rc != 0)
 		return rc;
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 6bdaefc790c3..a31b75d9302b 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -36,9 +36,7 @@ atomic_long_t ima_num_records = ATOMIC_LONG_INIT(0);
 atomic_long_t ima_num_violations = ATOMIC_LONG_INIT(0);
 
 /* key: inode (before secure-hashing a file) */
-struct hlist_head ima_htable[IMA_MEASURE_HTABLE_SIZE] = {
-	[0 ... IMA_MEASURE_HTABLE_SIZE - 1] = HLIST_HEAD_INIT
-};
+struct hlist_head __rcu *ima_htable;
 
 /* mutex protects atomicity of extending measurement list
  * and extending the TPM PCR aggregate. Since tpm_extend can take
@@ -52,17 +50,53 @@ static DEFINE_MUTEX(ima_extend_list_mutex);
  */
 static bool ima_measurements_suspended;
 
+/* Callers must call synchronize_rcu() and free the hash table. */
+static struct hlist_head *ima_alloc_replace_htable(void)
+{
+	struct hlist_head *old_htable, *new_htable;
+
+	/* Initializing to zeros is equivalent to call HLIST_HEAD_INIT. */
+	new_htable = kcalloc(IMA_MEASURE_HTABLE_SIZE, sizeof(struct hlist_head),
+			     GFP_KERNEL);
+	if (!new_htable)
+		return ERR_PTR(-ENOMEM);
+
+	old_htable = rcu_replace_pointer(ima_htable, new_htable,
+				lockdep_is_held(&ima_extend_list_mutex));
+
+	return old_htable;
+}
+
+int __init ima_init_htable(void)
+{
+	struct hlist_head *old_htable;
+
+	mutex_lock(&ima_extend_list_mutex);
+	old_htable = ima_alloc_replace_htable();
+	mutex_unlock(&ima_extend_list_mutex);
+
+	if (IS_ERR(old_htable))
+		return PTR_ERR(old_htable);
+
+	/* Synchronize_rcu() and kfree() not necessary, only for robustness. */
+	synchronize_rcu();
+	kfree(old_htable);
+	return 0;
+}
+
 /* lookup up the digest value in the hash table, and return the entry */
 static struct ima_queue_entry *ima_lookup_digest_entry(u8 *digest_value,
 						       int pcr)
 {
 	struct ima_queue_entry *qe, *ret = NULL;
+	struct hlist_head *htable;
 	unsigned int key;
 	int rc;
 
 	key = ima_hash_key(digest_value);
 	rcu_read_lock();
-	hlist_for_each_entry_rcu(qe, &ima_htable[key], hnext) {
+	htable = rcu_dereference(ima_htable);
+	hlist_for_each_entry_rcu(qe, &htable[key], hnext) {
 		rc = memcmp(qe->entry->digests[ima_hash_algo_idx].digest,
 			    digest_value, hash_digest_size[ima_hash_algo]);
 		if ((rc == 0) && (qe->entry->pcr == pcr)) {
@@ -102,6 +136,7 @@ static int ima_add_digest_entry(struct ima_template_entry *entry,
 				bool update_htable)
 {
 	struct ima_queue_entry *qe;
+	struct hlist_head *htable;
 	unsigned int key;
 
 	qe = kmalloc_obj(*qe);
@@ -114,10 +149,13 @@ static int ima_add_digest_entry(struct ima_template_entry *entry,
 	INIT_LIST_HEAD(&qe->later);
 	list_add_tail_rcu(&qe->later, &ima_measurements);
 
+	htable = rcu_dereference_protected(ima_htable,
+				lockdep_is_held(&ima_extend_list_mutex));
+
 	atomic_long_inc(&ima_num_records);
 	if (update_htable) {
 		key = ima_hash_key(entry->digests[ima_hash_algo_idx].digest);
-		hlist_add_head_rcu(&qe->hnext, &ima_htable[key]);
+		hlist_add_head_rcu(&qe->hnext, &htable[key]);
 	}
 
 	if (binary_runtime_size != ULONG_MAX) {
-- 
2.43.0


